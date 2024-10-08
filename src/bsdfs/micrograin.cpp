/*
    This file is part of Mitsuba, a physically based rendering system.

    Copyright (c) 2007-2014 by Wenzel Jakob and others.

    Mitsuba is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License Version 3
    as published by the Free Software Foundation.

    Mitsuba is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program. If not, see <http://www.gnu.org/licenses/>.
*/

#include <mitsuba/core/fresolver.h>
#include <mitsuba/core/warp.h>

#include <mitsuba/render/bsdf.h>
#include <mitsuba/render/ior.h>
#include <mitsuba/render/microfacet.h>
#include <mitsuba/render/texture.h>

NAMESPACE_BEGIN(mitsuba)

template <typename Float, typename Spectrum>
class Micrograin final : public BSDF<Float, Spectrum> {
public:
    MI_IMPORT_BASE(BSDF, m_flags, m_components)
    MI_IMPORT_TYPES(Texture, MicrofacetDistribution)

    Micrograin(const Properties &props) : BSDF(props) {
        m_linear_blend = props.get<bool>("linearBlend", true);

        // 只有conductor材质才能被初始化为none
        m_is_conductor_s          = props.get<bool>("conductorS", true);
        std::string materialNameS = props.string("materialS", "Cu");
        ref<Texture> intEta, intK;
        if (m_is_conductor_s) {
            // 对于conductor要么指定material_s，要么指定eta_s和k_s
            if (materialNameS == "none") {
                intEta = props.texture<Texture>("eta_s", 0.f);
                intK   = props.texture<Texture>("k_s", 1.f);
            } else {
                std::tie(intEta, intK) =
                    complex_ior_from_file<Spectrum, Texture>(materialNameS);
            }

            ScalarFloat extEta = lookup_ior(props, "extEta_s", "air");
            SurfaceInteraction3f si;
            m_eta_s = intEta->eval(si, true) / extEta;
            m_k_s   = intK->eval(si, true) / extEta;
        } else {
            // 对于dielectric，指定intIOR(是string)和extIOR(是string)
            /* Specifies the internal index of refraction at the interface */
            Float intIOR = lookup_ior(props, "intIOR_s", "bk7");

            /* Specifies the external index of refraction at the interface */
            Float extIOR = lookup_ior(props, "extIOR_s", "air");

            if (intIOR < 0 || extIOR < 0 || intIOR == extIOR)
                Throw("The interior and exterior indices of "
                      "refraction must be positive and differ!");

            m_eta_s = Spectrum(intIOR / extIOR);
            m_kd_s  = props.get<float>("kdS", 1.f);
        }

        m_is_conductor_b          = props.get<bool>("conductorB", true);
        std::string materialNameB = props.string("materialB", "Cu");
        if (m_is_conductor_b) {
            // 对于conductor要么指定material_b，要么指定eta_s和k_s
            if (materialNameB == "none") {
                intEta = props.texture<Texture>("eta_b", 0.f);
                intK   = props.texture<Texture>("k_b", 1.f);
            } else {
                std::tie(intEta, intK) =
                    complex_ior_from_file<Spectrum, Texture>(materialNameS);
            }
            Float extEta = lookup_ior(props, "extEtaB", "air");

            SurfaceInteraction3f si;
            m_eta_b = intEta->eval(si, true) / extEta;
            m_k_b   = intK->eval(si, true) / extEta;
        } else {
            // 对于dielectric，指定intIOR(是string)和extIOR(是string)
            /* Specifies the internal index of refraction at the interface */
            Float intIOR = lookup_ior(props, "intIOR_b", "bk7");

            /* Specifies the external index of refraction at the interface */
            Float extIOR = lookup_ior(props, "extIOR_b", "air");

            if (intIOR < 0 || extIOR < 0 || intIOR == extIOR)
                Throw("The interior and exterior indices of "
                      "refraction must be positive and differ!");

            m_eta_b = Spectrum(intIOR / extIOR);

            m_kd_b = props.get<float>("kd_b", 1.f);
        }

        m_beta = props.get<float>("beta", 1.f);
        m_beta = dr::clamp(m_beta, 0.001f, 1.f);

        // materialB为none时alpha参数失效
        m_alpha = props.get<float>("alpha", 1.f);

        m_tau_0 = props.get<float>("tau0", 0.5f);
        m_tau_0 = dr::clamp(m_tau_0, 0.001f, 0.999f);

        /**
         * 设置m_flags和m_components
         */
        m_flags = BSDFFlags::GlossyReflection | BSDFFlags::FrontSide;
        dr::set_attr(this, "flags", m_flags);

        m_components.clear();
        m_components.push_back(m_flags);
    }

    Float D_ggx(Float alpha_sqr, Float cos_theta) const {
        Float cos2_theta = cos_theta * cos_theta;
        Float tan2_theta = (1.f - cos2_theta) / cos2_theta;

        Float denom = M_PI * cos2_theta * cos2_theta *
                      (alpha_sqr + tan2_theta) * (alpha_sqr + tan2_theta);

        return alpha_sqr / denom;
    }

    Float lambda_ggx(Float alpha_sqr, Float tan_theta) const {
        return (-1. + sqrt(1. + alpha_sqr * tan_theta * tan_theta)) / 2.;
    }

    Float G1_ggx(Float alpha_sqr, Float cos_theta) const {
        Float tan_theta = sqrt(1. - cos_theta * cos_theta) / cos_theta;
        return 1. / (1. + lambda_ggx(alpha_sqr, tan_theta));
    }

    Float G_ggx(Float alpha_sqr, Float cos_theta_i, Float cos_theta_o) const {
        return G1_ggx(alpha_sqr, cos_theta_i) * G1_ggx(alpha_sqr, cos_theta_o);
    }

    Spectrum ggx_conductor_brdf(Float alpha_sqr, Float cos_theta_i,
                                Float cos_theta_o, Float cos_theta_h,
                                Float cos_theta_d) const {
        Float D = D_ggx(alpha_sqr, cos_theta_h);
        Float G = G_ggx(alpha_sqr, cos_theta_i, cos_theta_o);
        // Spectrum F = FresnelDielectricDielectric(m_eta_b, cos_theta_d);
        dr::Complex<UnpolarizedSpectrum> eta_c(m_eta_b, m_k_b);
        Spectrum F = fresnel_conductor(UnpolarizedSpectrum(cos_theta_d), eta_c);
        return D * G * F / (4. * cos_theta_i * cos_theta_o);
    }

    Spectrum ggx_plastic_brdf(Float alpha_sqr, Float kd, Float cos_theta_i,
                              Float cos_theta_o, Float cos_theta_h,
                              Float cos_theta_d) const {
        Float D       = D_ggx(alpha_sqr, cos_theta_h);
        Float G       = G_ggx(alpha_sqr, cos_theta_i, cos_theta_o);
        Spectrum F    = FresnelDielectricDielectric(m_eta_b, cos_theta_d);
        Spectrum spec = D * G * F / (4. * cos_theta_i * cos_theta_o);

        Spectrum Ti =
            Spectrum(1.f) - FresnelDielectricDielectric(m_eta_b, cos_theta_i);
        Spectrum To =
            Spectrum(1.f) - FresnelDielectricDielectric(m_eta_b, cos_theta_o);
        Spectrum diff = To * Ti * kd / M_PI;

        return spec + diff;
    }

    // Eq 18.
    Float alpha2beta(Float alpha, Float tau_0) const {
        Float fac = sqrt(-tau_0 / log(1. - tau_0));
        return alpha / fac;
    }

    // Eq 18.
    Float beta2alpha(Float beta, Float tau_0) const {
        Float fac = sqrt(-tau_0 / log(1. - tau_0));
        return beta * fac;
    }

    // Eq. in section visible filling factor
    Float gamma_beta(Float beta_sqr, Float cos_theta) const {
        Float cos2_theta = cos_theta * cos_theta;
        Float sin2_theta = 1. - cos2_theta;
        return sqrt(beta_sqr * sin2_theta + cos2_theta);
    }

    // Eq. in section Visible filling factor
    Float gamma_beta_plus(Float beta_sqr, Float cos_theta) const {
        return 0.5 * (cos_theta + gamma_beta(beta_sqr, cos_theta));
    }

    // Eq. 21
    Float tau_theta(Float tau_0, Float beta_sqr, Float cos_theta) const {
        return 1. -
               pow((1. - tau_0), (gamma_beta(beta_sqr, cos_theta) / cos_theta));
    }

    // Eq. 22
    Float tau_theta_plus(Float tau_0, Float beta_sqr, Float cos_theta) const {
        return 1. - sqrt((1. - tau_theta(tau_0, beta_sqr, cos_theta)) *
                         (1. - tau_0));
    }

    // Eq. in supplemental
    Float G1_our(Float tau_0, Float beta_sqr, Float cos_theta) const {
        Float pi_gamma               = -log(1. - tau_0);
        Float exp_pi_gamma_minus_one = exp(pi_gamma) - 1.;

        cos_theta = dr::clamp(cos_theta, 0.00001f, 0.99999f);
        Float mu  = cos_theta / dr::safe_sqrt(1. - cos_theta * cos_theta);

        Float beta2  = beta_sqr;
        Float beta4  = beta2 * beta2;
        Float beta6  = beta4 * beta2;
        Float beta8  = beta6 * beta2;
        Float beta10 = beta8 * beta2;
        Float beta12 = beta10 * beta2;

        Float mu2  = mu * mu;
        Float mu4  = mu2 * mu2;
        Float mu6  = mu4 * mu2;
        Float mu8  = mu6 * mu2;
        Float mu10 = mu8 * mu2;
        Float mu12 = mu10 * mu2;

        Float beta2_mu2      = beta2 + mu2;
        Float sqrt_beta2_mu2 = sqrt(beta2_mu2);

        Float F0 = pi_gamma * (-mu + sqrt_beta2_mu2) / (2. * mu);

        Float F1 = pow(pi_gamma, 2.) *
                   (beta2 + 2. * mu * (mu - sqrt_beta2_mu2)) /
                   (8. * mu * sqrt_beta2_mu2);

        Float F2 = pow(pi_gamma, 3.) *
                   (3. * beta4 + 12. * beta2 * mu2 + 8. * mu4 -
                    8. * mu * pow(beta2_mu2, 3. / 2.)) /
                   (96. * mu * pow(beta2_mu2, 3. / 2.));

        Float F3 = pow(pi_gamma, 4.) *
                   (5. * beta6 + 30. * beta4 * mu2 + 40. * beta2 * mu4 +
                    16. * mu6 - 16. * mu * pow(beta2_mu2, 5. / 2.)) /
                   (768. * mu * pow(beta2_mu2, 5. / 2.));

        Float F4 = pow(pi_gamma, 5.) *
                   (35. * beta8 + 280. * beta6 * mu2 + 560. * beta4 * mu4 +
                    448. * beta2 * mu6 + 128. * mu8 -
                    128. * mu * pow(beta2_mu2, 7. / 2.)) /
                   (30720. * mu * pow(beta2_mu2, 7. / 2.));

        Float F5 = pow(pi_gamma, 6.) *
                   (63. * beta10 + 630. * beta8 * mu2 + 1680. * beta6 * mu4 +
                    2016. * beta4 * mu6 + 1152. * beta2 * mu8 + 256. * mu10 -
                    256. * mu * pow(beta2_mu2, 9. / 2.)) /
                   (368640. * mu * pow(beta2_mu2, 9. / 2.));

        Float F6 = pow(pi_gamma, 7.) *
                   (231. * beta12 + 2772. * beta10 * mu2 + 9240. * beta8 * mu4 +
                    14784. * beta6 * mu6 + 12672. * beta4 * mu8 +
                    5632. * beta2 * mu10 + 1024. * mu12 -
                    1024. * mu * pow(beta2_mu2, 11. / 2.)) /
                   (10321920. * mu * pow(beta2_mu2, 11. / 2.));

        Float lambda_ =
            (F0 + F1 + F2 + F3 + F4 + F5 + F6) / exp_pi_gamma_minus_one;

        return 1. / (1. + lambda_);
    }

    Float G_our(Float tau_0, Float beta_sqr, Float alpha_sqr, Float cos_theta_i,
                Float cos_theta_o) const {
        return G1_our(tau_0, beta_sqr, cos_theta_i) *
               G1_our(tau_0, beta_sqr, cos_theta_o);
    }

    // Eq. 17
    Float D_our(Float tau_0, Float beta_sqr, Float cos_theta_m) const {
        Float cos2_theta_m = cos_theta_m * cos_theta_m;
        Float tan2_theta_m = (1. - cos2_theta_m) / cos2_theta_m;
        Float tmp          = beta_sqr + tan2_theta_m;
        Float num =
            beta_sqr * log(1. - tau_0) * pow(1. - tau_0, tan2_theta_m / tmp);
        Float denum = tau_0 * M_PI * tmp * tmp * cos2_theta_m * cos2_theta_m;
        return -num / denum;
    }

    // Eq. 23
    Float visibility_weight(Float tau_0, Float beta_sqr, Float cos_theta_i,
                            Float cos_theta_o) const {
        Float cos_theta_i_ = dr::clamp(std::abs(cos_theta_i), 0.00001f, 1.f);
        Float cos_theta_o_ = dr::clamp(std::abs(cos_theta_o), 0.00001f, 1.f);
        return 1. - ((1. - tau_theta_plus(tau_0, beta_sqr, cos_theta_i_)) *
                     (1. - tau_theta_plus(tau_0, beta_sqr, cos_theta_o_)) /
                     (1. - tau_0));
    }

    // Eq. 1
    Spectrum visibility_blend_our(Float tau_0, Float beta_sqr,
                                  Float cos_theta_i, Float cos_theta_o,
                                  Spectrum brdf_s, Spectrum brdf_b) const {
        Spectrum weight(
            visibility_weight(tau_0, beta_sqr, cos_theta_i, cos_theta_o));
        return dr::lerp(brdf_b, brdf_s, weight);
    }

    Spectrum micrograin_conductor_bsdf(Float tau_0, Float beta_sqr,
                                       Float alpha_sqr, Float cos_theta_i,
                                       Float cos_theta_o, Float cos_theta_h,
                                       Float cos_theta_d) const {
        Float D = D_our(tau_0, beta_sqr, cos_theta_h);
        Float G = G_our(tau_0, beta_sqr, alpha_sqr, cos_theta_i, cos_theta_o);
        Spectrum F = FresnelDielectricDielectric(m_eta_s, cos_theta_d);
        // Spectrum F = FresnelDielectricConductor(eta,kappa,cos_theta_d);
        return D * G * F / (4. * cos_theta_i * cos_theta_o);
    }

    /**
     * @brief
     *
     * @param tau_0
     * @param beta_sqr
     * @param alpha_sqr
     * @param R0 从法向入射的反射率
     * @param kd
     * @param cos_theta_i
     * @param cos_theta_o
     * @param cos_theta_h
     * @param cos_theta_d
     * @return
     */
    Spectrum micrograin_plastic_bsdf(Float tau_0, Float beta_sqr,
                                     Float alpha_sqr, Float kd,
                                     Float cos_theta_i, Float cos_theta_o,
                                     Float cos_theta_h,
                                     Float cos_theta_d) const {
        Float D = D_our(tau_0, beta_sqr, cos_theta_h);
        Float G = G_our(tau_0, beta_sqr, alpha_sqr, cos_theta_i, cos_theta_o);
        Spectrum F    = FresnelDielectricDielectric(m_eta_s, cos_theta_d);
        Spectrum spec = D * G * F / (4. * cos_theta_i * cos_theta_o);

        Spectrum Ti =
            Spectrum(1.) - FresnelDielectricDielectric(m_eta_s, cos_theta_i);
        Spectrum To =
            Spectrum(1.) - FresnelDielectricDielectric(m_eta_s, cos_theta_o);
        Spectrum diff = To * Ti * kd / M_PI;

        return spec + diff;
    }

    // https://seblagarde.wordpress.com/2013/04/29/memo-on-fresnel-equations/
    Spectrum FresnelDielectricConductor(Spectrum Eta, Spectrum Etak,
                                        Float CosTheta) const {
        Float CosTheta2 = CosTheta * CosTheta;
        Float SinTheta2 = 1. - CosTheta2;
        Spectrum Eta2   = Eta * Eta;
        Spectrum Etak2  = Etak * Etak;

        Spectrum t0       = Eta2 - Etak2 - Spectrum(SinTheta2);
        Spectrum a2plusb2 = dr::safe_sqrt(t0 * t0 + 4. * Eta2 * Etak2);
        Spectrum t1       = a2plusb2 + Spectrum(CosTheta2);
        Spectrum a        = dr::safe_sqrt(0.5f * (a2plusb2 + t0));
        Spectrum t2       = 2. * a * CosTheta;
        Spectrum Rs       = (t1 - t2) / (t1 + t2);

        Spectrum t3 = CosTheta2 * a2plusb2 + Spectrum(SinTheta2 * SinTheta2);
        Spectrum t4 = t2 * SinTheta2;
        Spectrum Rp = Rs * (t3 - t4) / (t3 + t4);

        return 0.5 * (Rs * Rs + Rp * Rp);
    }

    // https://seblagarde.wordpress.com/2013/04/29/memo-on-fresnel-equations/
    /**
     * @brief
     *
     * @param Eta 出射方向折射率/入射方向折射率
     * @param CosTheta [0, 1]的一个值
     * @return Spectrum
     */
    Spectrum FresnelDielectricDielectric(Spectrum Eta, Float CosTheta) const {
        Float SinTheta2 = 1. - CosTheta * CosTheta;

        // t0 = cos_theta_t > 0
        Spectrum t0 = dr::safe_sqrt(Spectrum(1.f) - (SinTheta2 / (Eta * Eta)));
        Spectrum t1 = Eta * t0;
        Spectrum t2 = Eta * CosTheta;

        Spectrum rs = (Spectrum(CosTheta) - t1) / (Spectrum(CosTheta) + t1);
        Spectrum rp = (t0 - t2) / (t0 + t2);
        return 0.5 * (rs * rs + rp * rp);
    }

    inline Vector3f reflect(const Vector3f &wi, const Normal3f &m) const {
        return 2 * dot(wi, m) * Vector3f(m) - wi;
    }

    Spectrum eval(const BSDFContext &ctx, const SurfaceInteraction3f &si,
                  const Vector3f &wo, Mask active) const override {
        MI_MASKED_FUNCTION(ProfilerPhase::BSDFEvaluate, active);

        Float cos_theta_i = Frame3f::cos_theta(si.wi),
              cos_theta_o = Frame3f::cos_theta(wo);

        if (cos_theta_i < 0.f || cos_theta_o < 0.f ||
            !ctx.is_enabled(BSDFFlags::GlossyReflection))
            return 0.f;

        Vector3f wh       = normalize(wo + si.wi);
        Float cos_theta_h = dr::clamp(Frame3f::cos_theta(wh), 0.0f, 1.0f);
        Float cos_theta_d = dr::clamp(dot(wh, si.wi), 0.0f, 1.0f);
        Float beta_sqr    = m_beta * m_beta;
        Float alpha_sqr   = m_alpha * m_alpha;

        Spectrum brdf_s;
        if (m_is_conductor_s) {
            brdf_s = micrograin_conductor_bsdf(m_tau_0, beta_sqr, alpha_sqr,
                                               cos_theta_i, cos_theta_o,
                                               cos_theta_h, cos_theta_d);
        } else {
            brdf_s = micrograin_plastic_bsdf(m_tau_0, beta_sqr, alpha_sqr,
                                             m_kd_s, cos_theta_i, cos_theta_o,
                                             cos_theta_h, cos_theta_d);
        }

        Spectrum brdf_b;
        if (m_is_conductor_b) {
            brdf_b = ggx_conductor_brdf(alpha_sqr, cos_theta_i, cos_theta_o,
                                        cos_theta_h, cos_theta_d);
        } else {
            brdf_b = ggx_plastic_brdf(alpha_sqr, m_kd_b, cos_theta_i,
                                      cos_theta_o, cos_theta_h, cos_theta_d);
        }

        Spectrum col;
        if (m_linear_blend) {
            col = dr::lerp(brdf_b, brdf_s, m_tau_0);
        } else {
            col = visibility_blend_our(m_tau_0, beta_sqr, cos_theta_i,
                                       cos_theta_o, brdf_s, brdf_b);
        }

        return col * cos_theta_o;
    }

    Float pdf(const BSDFContext &ctx, const SurfaceInteraction3f &si,
              const Vector3f &wo, Mask active) const override {
        MI_MASKED_FUNCTION(ProfilerPhase::BSDFEvaluate, active);

        Float cos_theta_i = Frame3f::cos_theta(si.wi),
              cos_theta_o = Frame3f::cos_theta(wo);

        Vector3f wh = dr::normalize(wo + si.wi);
        if (!(cos_theta_i > 0.f && cos_theta_o > 0.f &&
              dr::dot(si.wi, wh) > 0.f && dr::dot(wo, wh) > 0.f) ||
            !ctx.is_enabled(BSDFFlags::GlossyReflection))
            return 0.f;

        Float cos_theta_h = dr::clamp(Frame3f::cos_theta(wh), 0.0f, 1.0f);
        Float beta_sqr    = m_beta * m_beta;
        Float alpha_sqr   = m_alpha * m_alpha;

        // 太小了，一般都可以约等于零
        Float pdf_s = D_our(m_tau_0, beta_sqr, cos_theta_h) * cos_theta_h /
                      (4 * dr::abs_dot(wo, wh));

        MicrofacetDistribution distr(MicrofacetType::GGX, m_alpha);
        Float pdf_b = distr.eval(wh) * distr.smith_g1(si.wi, wh) /
                      (4.0f * Frame3f::cos_theta(si.wi));

        if (m_linear_blend)
            return dr::lerp(pdf_b, pdf_s, m_tau_0);
        else {
            Float weight =
                visibility_weight(m_tau_0, beta_sqr, cos_theta_i, cos_theta_o);
            return dr::lerp(pdf_b, pdf_s, weight);
        }
    }

    std::pair<BSDFSample3f, Spectrum> sample(const BSDFContext &ctx,
                                             const SurfaceInteraction3f &si,
                                             Float /* sample1 */,
                                             const Point2f &_sample2,
                                             Mask active) const override {
        MI_MASKED_FUNCTION(ProfilerPhase::BSDFSample, active);

        BSDFSample3f bs = dr::zeros<BSDFSample3f>();
        if (!ctx.is_enabled(BSDFFlags::GlossyReflection))
            return { bs, 0.f };

        Point2f sample(_sample2);

        /**
         * 采样不考虑非linear采样的情况
         * 下面的所有采样都仅考虑specular分量，不考虑diffuse分量
         */
        Float weights[2];
        weights[0] = 1.f - m_tau_0;
        weights[1] = m_tau_0;

        size_t entry;
        if (sample.x() < weights[0]) // 采样base层
        {
            entry = 0;
            sample.x() /= weights[0];
        } else // 采样porous层
        {
            entry      = 1;
            sample.x() = (sample.x() - weights[0]) / weights[1];
        }

        if (entry == 0) {
            // 采样base层
            Normal3f m;
            Float pdf_b;
            MicrofacetDistribution distr(MicrofacetType::GGX, m_alpha);
            std::tie(m, pdf_b) = distr.sample(si.wi, sample);

            bs.wo = reflect(si.wi, m);
        } else // 采样porous层
        {      // [-pi/2, pi/2]
            Float theta_m = std::atan(
                m_beta * dr::safe_sqrt(-std::logf(1.f - sample.x() * m_tau_0) /
                                       (std::logf(1.f - sample.x() * m_tau_0) -
                                        std::logf(1.f - m_tau_0))));
            if (theta_m < 0)
                theta_m += M_PI;
            Float phi_m                 = 2 * M_PI * sample.y();
            auto [sinThetaM, cosThetaM] = dr::sincos(theta_m);
            auto [sinPhiM, cosPhiM]     = dr::sincos(phi_m);
            Normal3f m(
                Vector3f(sinThetaM * cosPhiM, sinThetaM * sinPhiM, cosThetaM));
            bs.wo = reflect(si.wi, m);
        }

        /* Side check */
        if (Frame3f::cos_theta(bs.wo) <= 0)
            return { bs, 0.f };

        Spectrum numerator(this->eval(ctx, si, bs.wo, true));
        Float pdf = this->pdf(ctx, si, bs.wo, true);
        if (pdf == 0.f)
            return { bs, 0.f };

        bs.eta               = 1.0f;
        bs.sampled_component = 0;
        bs.sampled_type      = +BSDFFlags::GlossyReflection;
        bs.pdf               = pdf;
        
        Spectrum res = numerator / pdf;
        return { bs, res };
    }

    std::string to_string() const override {
        std::ostringstream oss;
        oss << "Micrograin[" << std::endl << std::endl;
        oss << "  porous beta = " << string::indent(m_beta) << "," << std::endl;
        oss << "  porous tau0 = " << string::indent(m_tau_0) << ","
            << std::endl;
        oss << "  base alpha = " << string::indent(m_alpha) << "," << std::endl;
        oss << "  porous conductor = " << string::indent(m_is_conductor_s)
            << "," << std::endl;
        oss << "  base conductor = " << string::indent(m_is_conductor_b) << ", "
            << std::endl
            << "]";

        return oss.str();
    }

    MI_DECLARE_CLASS()
private:
    ref<Texture> m_specularReflectance;

    // porous层和dielectric层是否做linear blend？
    bool m_linear_blend;

    // porous层是conductor/dielectric?
    // 如果是conductor，只有镜面反射；如果是dielectric，包含镜面反射和漫反射
    bool m_is_conductor_s;
    Spectrum m_eta_s;
    Spectrum m_k_s; // is_conductor_s为true时有效

    // base层是conductor/dielectric?
    // 如果是conductor，只有镜面反射；如果是dielectric，包含镜面反射和漫反射
    bool m_is_conductor_b;
    Spectrum m_eta_b;
    Spectrum m_k_b; // is_conductor_b为true时有效

    // porous层的beta参数，用于控制粗糙度
    Float m_beta;
    // porous层参数，用于控制porous层的micrograin密度
    Float m_tau_0;
    // porous层参数，用于控制porous层的diffuse系数
    Float m_kd_s;

    // base层的alpha参数，用于控制粗糙度，即GGX中的alpha
    /* consider the following approximate classification
    a value of *$\alpha = 0.001 - 0.01 corresponds to a material with slight
    imperfections on an otherwise smooth surface finish, alpha = 0.1 is
    relatively rough, and alpha = 0.3 - 0.7 is extremely rough (e.g.an etched or
    ground). */
    Float m_alpha;

    // base层参数，用于控制base层的diffuse系数
    Float m_kd_b;
};

MI_IMPLEMENT_CLASS_VARIANT(Micrograin, BSDF)
MI_EXPORT_PLUGIN(Micrograin, "micrograin bsdf");
NAMESPACE_END(mitsuba)
