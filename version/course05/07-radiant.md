# Pile 7 — Radiant

[← Course 05 index](index.md) · [← Pile 6](06-chemical.md) · [Integration pile →](08-integration.md)

**Course:** [course01 Module 7](../course01/index.md#module-7--radiant-domain) · **Theory:** [course03/07-radiant](../course03/07-radiant/README.md) · **Bench:** [course04/07-bench-radiant](../course04/07-bench-radiant.md)

## What you're looking at

A photodiode. An LED. A laser pointer. A CCD from an old digital camera. A pair of mirrors and a glass of water (interference, refraction).

## The one thing to understand

Light is both a wave (diffraction, interference, wavelength) and a particle (energy = hν, photoelectric effect). You need both pictures. Every optical device uses one or the other, often in the same sentence.

Photons with energy above a material's bandgap get absorbed and knock out electrons. Silicon's bandgap sets its spectral range (400–1100 nm). Smaller bandgaps see further into the infrared. Bigger bandgaps work in UV.

## This pile on the three pillars

| Pillar | At this pile |
|---|---|
| [1 · Arrows between piles](p1-arrows-between-piles.md) | Camera: radiant → electrical |
| [2 · Material + technique](p2-material-and-technique.md) | See [Material + technique](#material--technique) below |
| [3 · Bandwidth](p3-bandwidth-and-ceiling.md) | GHz+ — limited by detector response, electronics |
| [3 · Ceiling (energy density)](p3-bandwidth-and-ceiling.md) | — |
| Role | Very common in sensing (vision, encoders, interferometers, LIDAR); specialty in actuation (laser cutting, trapping). |
| As sensor input / actuator output | Very common / Specialty |
| Characteristic effects | Diffraction, interference, polarization, Beer–Lambert, blackbody radiation, Doppler. |

## What to build

1. Shine a laser pointer through a double slit cut in foil. Watch fringes on a wall. You've reproduced Young's experiment from 1801 for the cost of a laser pointer.
2. Hook a photodiode to a scope. Wave a hand over it. See the shadow in volts.
3. Open a Blu-ray drive. The laser is a GaN diode. The optics are plastic. The sensor is a photodiode array. All assembly done by machines.
4. Image a fluorescent tube with a cheap CMOS camera at a short shutter. See the stripes from the 60 Hz flicker.

## Material + technique

### Key materials

- **Photodetectors:** silicon (visible), InGaAs (telecom), Ge (near-IR), HgCdTe (mid/long IR, cryogenic), InSb (mid-IR), GaN (UV).
- **Emitters:** GaN/InGaN (blue, green, white LEDs; Blu-ray lasers), AlGaInP (red/amber), GaAs/AlGaAs (near-IR lasers).
- **Lenses and windows:** fused silica (broad), sapphire (rugged), ZnSe and Ge (IR), CaF₂ (UV).
- **Mirrors:** aluminum (broad), silver (visible), dielectric stacks (laser-grade).
- **Fiber:** fused silica. One meter of preform draws into tens of kilometers of fiber.

### Key techniques

- **MOCVD epitaxy** — atomic-layer growth of semiconductors. Enables every modern LED and semiconductor laser.
- **Diamond turning** — single-point cutting of optics with nanometer finish; aspheric and freeform shapes no polisher can make.
- **Magnetorheological finishing (MRF)** — polishing with a magnetically-shaped slurry. Finishes to a fraction of a wavelength.
- **Preform drawing of fiber** — one of the most dramatic manufacturing processes in existence; a glass log becomes 50 km of fiber in hours.

### The clever trick

**MOCVD growth of GaN.** For decades, nobody could make a bright blue LED — the materials wouldn't cooperate. Nakamura, Akasaki, and Amano got it to work in the early 1990s. The payoff: blue LEDs enabled white LEDs (blue + yellow phosphor), which replaced incandescent lighting worldwide; also Blu-ray, UV sources, modern displays. Nobel in 2014.

### Materials, techniques, features

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

### Signature techniques

MOCVD epitaxy, diamond turning, MRF, ion-beam figuring, preform drawing of fiber.

## Who to know

Young (interference), Michelson (interferometry), Einstein (photoelectric effect), Maiman (first laser, 1960), Holonyak (first visible LED, 1962), Boyle and Smith (CCD, 1969), Nakamura/Akasaki/Amano (GaN blue LED), Ashkin (optical tweezers).

### Discoverers — measurement and equipment

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

## What to read later

[Hecht, *Optics*; Saleh & Teich, *Fundamentals of Photonics*](../course02/08-hecht-saleh-teich-optics-photonics/)
