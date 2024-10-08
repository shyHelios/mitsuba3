import pytest
import drjit as dr
import mitsuba as mi

def test01_create(variant_scalar_rgb):
    b = mi.load_dict({'type': 'micrograin'})
    assert b is not None
    assert b.component_count() == 1
    assert b.flags(0) == mi.BSDFFlags.GlossyReflection
    assert b.flags() == b.flags(0)


def test02_eval_pdf(variant_scalar_rgb):
    bsdf = mi.load_dict({'type': 'micrograin'})

    si    = mi.SurfaceInteraction3f()
    si.p  = [0, 0, 0]
    si.n  = [0, 0, 1]
    si.wi = [0, 0, 1]
    si.sh_frame = mi.Frame3f(si.n)

    ctx = mi.BSDFContext()

    for i in range(20):
        theta = i / 19.0 * (dr.pi / 2)
        wo = [dr.sin(theta), 0, dr.cos(theta)]

        v_pdf  = bsdf.pdf(ctx, si, wo=wo)
        v_eval = bsdf.eval(ctx, si, wo=wo)[0]
        assert dr.allclose(v_pdf, wo[2] / dr.pi)
        assert dr.allclose(v_eval, 0.5 * wo[2] / dr.pi)

        v_eval_pdf = bsdf.eval_pdf(ctx, si, wo=wo)
        assert dr.allclose(v_eval, v_eval_pdf[0])
        assert dr.allclose(v_pdf, v_eval_pdf[1])
