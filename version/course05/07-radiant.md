# Domain 7 — Radiant

[← Course 05 index](index.md) · [← Domain 6 — Chemical](06-chemical.md) · [Cross-Domain Term Patterns →](08-cross-domain-term-patterns.md)

**Theory:** [course03/07-radiant](../course03/07-radiant/README.md) · **Bench:** [course04/07-bench-radiant](../course04/07-bench-radiant.md)

## Important terms

| Term | Meaning |
|---|---|
| Photon | Quantum of EM radiation; energy = hν. |
| Wavelength (λ) / frequency (ν) | λν = c; defines spectral region. |
| Intensity / irradiance | Power per area. Unit: W/m². |
| Radiance / luminance | Power or luminous flux per solid angle per area. |
| Spectrum | Intensity vs. wavelength. |
| Polarization | Orientation of E-field oscillation. |
| Coherence | Phase correlation across time/space (lasers). |
| Diffraction / interference | Wave superposition phenomena. |
| Refraction / refractive index (n) | Bending of light; n sets lens behavior. |
| Reflection / absorption / transmission | Fates of incident light. |
| Beer–Lambert law | Absorbance ∝ concentration × path length. |
| Quantum efficiency (QE) | Electrons per incident photon. |
| Responsivity | Output signal per watt of incident light. |
| Dark current / noise-equivalent power (NEP) | Detector noise floor. |
| Bandgap (Eg) | Minimum photon energy for photo-generation; sets cutoff wavelength. |
| Blackbody / emissivity | Radiation framework. |
| Interferometry | Phase-difference measurement for nm-level distance. |

## Role

Very common in sensing (vision, encoders, interferometers, LIDAR); specialty in actuation (laser cutting, trapping).

## Characteristic effects

Diffraction, interference, polarization, Beer–Lambert, blackbody radiation, Doppler.

## Discoverers — measurement and equipment

| Year | Discoverer | What was measured | Equipment used |
|---|---|---|---|
| 1801 | Young | Fringe spacing in double-slit | Sunlight, pinhole, hand-cut slits, screen |
| 1887 | Michelson | Fringe shift with Earth's motion | Michelson interferometer, sodium light, mercury float |
| 1905 | Einstein | Photoelectric threshold frequency | Lenard's photoelectric tube, electrometer |
| 1960 | Maiman | 694 nm pulse from ruby | Ruby rod, xenon flashlamp, oscilloscope + photodiode |
| 1962 | Holonyak | Red light from GaAsP junction | GaAsP crystal, probe station, spectrometer |
| 1966 | Kao | Attenuation in different glasses | White-light source, monochromator, PMT |
| 1969 | Boyle & Smith | Charge shift across MOS capacitors | Probe station, pulse generators, oscilloscope |
| 1986 | Ashkin | Trapping force on dielectric particles | Ar-ion / Nd:YAG lasers, high-NA microscope, quadrant PD |
| 1990s | Nakamura, Akasaki, Amano | Electroluminescence of GaN | MOCVD reactors, Hall stations, spectrometers |

## Materials, techniques, features

| Function | Material | Technique | Features |
|---|---|---|---|
| Photodetectors | Si, InGaAs, Ge, HgCdTe, InSb, GaN | Epitaxy (MOCVD, MBE), implantation, ROIC bonding | Spectral range, QE |
| Image sensors | Si + color filters + microlenses | CMOS fab, filter lithography, microlens reflow | Megapixel, HDR |
| LEDs | GaN/InGaN, AlGaInP, GaAs | MOCVD, mesa etching, phosphor coating | High efficiency, tunable color |
| Laser diodes | GaAs/AlGaAs, InGaAsP, GaN | Heterostructure epitaxy, cleaved facets | Narrow spectrum, GHz modulation |
| Solid-state lasers | Nd:YAG, Yb:YAG, Ti:sapphire | Crystal growth, diode pumping, Q-switch, mode-lock | High peak power, ultrashort pulses |
| Fiber optics | Fused silica, ZBLAN, polymer | Preform drawing, MCVD | Low loss, long reach |
| Optics | Fused silica, sapphire, ZnSe, Ge, CaF₂ | Grinding, polishing, MRF, diamond turning | Broad spectral coverage |
| Mirrors & coatings | Al, protected Ag, dielectric stacks | Vacuum deposition | High reflectivity, damage threshold |

## Signature techniques

MOCVD epitaxy, diamond turning, MRF, ion-beam figuring, preform drawing of fiber.
