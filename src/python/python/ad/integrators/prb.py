import enoki as ek
import mitsuba
from .common import prepare_sampler, sample_sensor_rays, mis_weight

from typing import Union

class PRBIntegrator(mitsuba.render.SamplingIntegrator):
    """
    This integrator implements a path replay backpropagation surface path tracer.
    """

    def __init__(self, props=mitsuba.core.Properties()):
        super().__init__(props)
        self.max_depth = props.get('max_depth', 4)

    def render_forward(self: mitsuba.render.SamplingIntegrator,
                       scene: mitsuba.render.Scene,
                       params: mitsuba.python.util.SceneParameters,
                       seed: int,
                       sensor: Union[int, mitsuba.render.Sensor] = 0,
                       spp: int=0) -> mitsuba.core.TensorXf:
        from mitsuba.render import ImageBlock

        if isinstance(sensor, int):
            sensor = scene.sensors()[sensor]
        film = sensor.film()
        rfilter = film.reconstruction_filter()
        sampler = sensor.sampler()

        # Seed the sampler and compute the number of sample per pixels
        spp = prepare_sampler(sensor, seed, spp)

        ray, weight, pos, _, _ = sample_sensor_rays(sensor)

        # Sample forward paths (not differentiable)
        with ek.suspend_grad():
            primal_result = self.Li(None, scene, sampler.clone(), ray)[0]

        grad_img = self.Li(ek.ADMode.Forward, scene, sampler,
                           ray, params=params, grad=weight,
                           primal_result=primal_result)[0]

        block = ImageBlock(film.crop_size(), channel_count=5,
                           filter=rfilter, border=False)
        block.set_offset(film.crop_offset())
        block.clear()
        block.put(pos, ray.wavelengths, grad_img)
        film.prepare([])
        film.put(block)
        return film.develop()

    def render_backward(self: mitsuba.render.SamplingIntegrator,
                        scene: mitsuba.render.Scene,
                        params: mitsuba.python.util.SceneParameters,
                        image_adj: mitsuba.core.TensorXf,
                        seed: int,
                        sensor: Union[int, mitsuba.render.Sensor] = 0,
                        spp: int = 0) -> None:
        from mitsuba.core import Spectrum
        from mitsuba.render import ImageBlock

        if isinstance(sensor, int):
            sensor = scene.sensors()[sensor]
        film = sensor.film()
        rfilter = film.reconstruction_filter()
        sampler = sensor.sampler()

        # Seed the sampler and compute the number of sample per pixels
        spp = prepare_sampler(sensor, seed, spp)

        ray, weight, pos, _, _ = sample_sensor_rays(sensor)

        # Sample forward paths (not differentiable)
        with ek.suspend_grad():
            primal_result = self.Li(None, scene, sampler.clone(), ray)[0]

        block = ImageBlock(ek.detach(image_adj), rfilter, normalize=True)
        block.set_offset(film.crop_offset())
        grad = Spectrum(block.read(pos)) * weight / spp

        # Replay light paths by using the same seed and accumulate gradients
        # This uses the result from the first pass to compute gradients
        self.Li(ek.ADMode.Backward, scene, sampler, ray,
                params=params, grad=grad, primal_result=primal_result)

    def sample(self, scene, sampler, ray, medium, active):
        res, valid = self.Li(None, scene, sampler, ray, active_=active)
        return res, valid, []

    def Li(self: mitsuba.render.SamplingIntegrator,
           mode: ek.ADMode,
           scene: mitsuba.render.Scene,
           sampler: mitsuba.render.Sampler,
           ray: mitsuba.core.RayDifferential3f,
           depth: mitsuba.core.UInt32=1,
           params=mitsuba.python.util.SceneParameters(),
           grad: mitsuba.core.Spectrum=None,
           active_: mitsuba.core.Mask=True,
           primal_result: mitsuba.core.Spectrum=None):

        from mitsuba.core import Spectrum, Float, Mask, UInt32, Loop, Ray3f
        from mitsuba.render import DirectionSample3f, BSDFContext, BSDFFlags, has_flag, RayFlags

        is_primal = mode is None

        ray = Ray3f(ray)
        pi = scene.ray_intersect_preliminary(ray, active_)
        valid_ray = active_ & pi.is_valid()

        result = Spectrum(0.0)
        if is_primal:
            primal_result = Spectrum(0.0)

        throughput = Spectrum(1.0)
        active = Mask(active_)
        emission_weight = Float(1.0)

        depth_i = UInt32(depth)
        loop = Loop("Path Replay Backpropagation main loop" + '' if is_primal else ' - adjoint')
        loop.put(lambda: (depth_i, active, ray, emission_weight, throughput, pi, result, primal_result))
        sampler.loop_register(loop)
        loop.init()
        while loop(active):
            si = pi.compute_surface_interaction(ray, RayFlags.All, active)

            # ---------------------- Direct emission ----------------------

            emitter_val = si.emitter(scene, active).eval(si, active)
            accum = emitter_val * throughput * emission_weight

            active &= si.is_valid()
            active &= depth_i < self.max_depth

            ctx = BSDFContext()
            bsdf = si.bsdf(ray)

            # ---------------------- Emitter sampling ----------------------

            active_e = active & has_flag(bsdf.flags(), BSDFFlags.Smooth)
            ds, emitter_val = scene.sample_emitter_direction(
                si, sampler.next_2d(active_e), True, active_e)
            ds = ek.detach(ds, True)
            active_e &= ek.neq(ds.pdf, 0.0)
            wo = si.to_local(ds.d)

            bsdf_val, bsdf_pdf = bsdf.eval_pdf(ctx, si, wo, active_e)
            mis = ek.select(ds.delta, 1.0, mis_weight(ds.pdf, bsdf_pdf))

            accum += ek.select(active_e, bsdf_val * throughput * mis * emitter_val, 0.0)

            # Update accumulated radiance. When propagating gradients, we subtract the
            # emitter contributions instead of adding them
            if not is_primal:
                primal_result -= ek.detach(accum)

            # ---------------------- BSDF sampling ----------------------

            with ek.suspend_grad():
                bs, bsdf_weight = bsdf.sample(ctx, si, sampler.next_1d(active),
                                              sampler.next_2d(active), active)
                active &= bs.pdf > 0.0
                ray = si.spawn_ray(si.to_world(bs.wo))

            pi_bsdf = scene.ray_intersect_preliminary(ray, active)
            si_bsdf = pi_bsdf.compute_surface_interaction(ray, RayFlags.All, active)

            # Compute MIS weight for the BSDF sampling
            ds = DirectionSample3f(scene, si_bsdf, si)
            ds.emitter = si_bsdf.emitter(scene, active)
            delta = has_flag(bs.sampled_type, BSDFFlags.Delta)
            emitter_pdf = scene.pdf_emitter_direction(si, ds, ~delta)
            emission_weight = ek.select(delta, 1.0, mis_weight(bs.pdf, emitter_pdf))

            # Backpropagate gradients related to the current bounce
            if not is_primal:
                bsdf_eval = bsdf.eval(ctx, si, bs.wo, active)
                accum += ek.select(active, bsdf_eval * primal_result / ek.max(1e-8, ek.detach(bsdf_eval)), 0.0)

            if mode is ek.ADMode.Backward:
                ek.backward(accum * grad, ek.ADFlag.ClearVertices)
            elif mode is ek.ADMode.Forward:
                ek.enqueue(ek.ADMode.Forward, params)
                ek.traverse(Float, ek.ADFlag.ClearEdges | ek.ADFlag.ClearInterior)
                result += ek.grad(accum) * grad
            else:
                result += accum

            pi = pi_bsdf
            throughput *= bsdf_weight

            depth_i += UInt32(1)

        return result, valid_ray

    def to_string(self):
        return f'PRBIntegrator[max_depth = {self.max_depth}]'


mitsuba.render.register_integrator("prb", lambda props: PRBIntegrator(props))
