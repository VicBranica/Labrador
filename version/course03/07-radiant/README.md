# Domain 7 — Radiant

[← Course 03 index](../index.md) · [← Domain 6 — Chemical](../06-chemical/README.md) · [Integration pile →](../08-integration.md)

**State variable:** Photon flux · **Note:** does not fit the clean effort × flow pattern

**Lesson:** [course01 Lesson 7](../../course01/Lesson7.md) · **Theory:** [course01 Module 7](../../course01/index.md#module-7--radiant-domain) · **Bench:** [course04 Bench 7](../../course04/07-bench-radiant.md)

> Hands on first (A–C), then the six layers from the bottom of the stack up (1–6), then back to the bench (D–E).

## A. What you're looking at

A photodiode. An LED. A laser pointer. A CCD from an old digital camera. A pair of mirrors and a glass of water (interference, refraction).

## B. The one thing to understand

Light is both a wave (diffraction, interference, wavelength) and a particle (energy = hν, photoelectric effect). You need both pictures. Every optical device uses one or the other, often in the same sentence.

Photons with energy above a material's bandgap get absorbed and knock out electrons. Silicon's bandgap sets its spectral range (400–1100 nm). Smaller bandgaps see further into the infrared. Bigger bandgaps work in UV.

**Key relations:** E_photon = hν = hc/λ · a detector responds when E ≥ E_g (bandgap); longer wavelengths need smaller bandgaps (Si → Ge → InGaAs → HgCdTe).

## C. This pile on the three pillars

| Pillar | At this pile |
|---|---|
| [1 · Arrows between piles](../p1-arrows-between-piles.md) | Camera: radiant → electrical |
| [2 · Material + technique](../p2-material-and-technique.md) | See [4. Material](#4-material) and [5. Technique](#5-technique) below |
| [3 · Bandwidth](../p3-bandwidth-and-ceiling.md) | GHz+ — limited by detector response, electronics |
| [3 · Ceiling (energy density)](../p3-bandwidth-and-ceiling.md) | — |
| Role | Very common in sensing (vision, encoders, interferometers, LIDAR); specialty in actuation (laser cutting, trapping). |
| As sensor input / actuator output | Very common / Specialty |
| Characteristic effects | Diffraction, interference, polarization, Beer–Lambert, blackbody radiation, Doppler. |

## 1. Vocabulary

*The terms that let you reason about everything below.*

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

## 2. Measurement

*The instruments that first saw each effect.*

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

## 3. Discovery

*The physical effects themselves.*

| Year | Effect / law | Discoverer |
|---|---|---|
| 1801 | Interference (double-slit) | Young |
| 1887 | Interferometry | Michelson |
| 1905 | Photoelectric effect | Einstein |
| 1960 | First laser | Maiman |
| 1962 | Visible LED | Holonyak |
| 1969 | CCD | Boyle, Smith |
| 1986 | Optical tweezers | Ashkin |
| 1990s | GaN blue LED | Nakamura, Akasaki, Amano |

### Who to know

Young (interference), Michelson (interferometry), Einstein (photoelectric effect), Maiman (first laser, 1960), Holonyak (first visible LED, 1962), Boyle and Smith (CCD, 1969), Nakamura/Akasaki/Amano (GaN blue LED), Ashkin (optical tweezers).

## 4. Material

*What carries the effect.*

- **Photodetectors:** silicon (visible), InGaAs (telecom), Ge (near-IR), HgCdTe (mid/long IR, cryogenic), InSb (mid-IR), GaN (UV).
- **Emitters:** GaN/InGaN (blue, green, white LEDs; Blu-ray lasers), AlGaInP (red/amber), GaAs/AlGaAs (near-IR lasers).
- **Lenses and windows:** fused silica (broad), sapphire (rugged), ZnSe and Ge (IR), CaF₂ (UV).
- **Mirrors:** aluminum (broad), silver (visible), dielectric stacks (laser-grade).
- **Fiber:** fused silica. One meter of preform draws into tens of kilometers of fiber.

## 5. Technique

*How the material becomes a device.*

- **MOCVD epitaxy** — atomic-layer growth of semiconductors. Enables every modern LED and semiconductor laser.
- **Diamond turning** — single-point cutting of optics with nanometer finish; aspheric and freeform shapes no polisher can make.
- **Magnetorheological finishing (MRF)** — polishing with a magnetically-shaped slurry. Finishes to a fraction of a wavelength.
- **Preform drawing of fiber** — one of the most dramatic manufacturing processes in existence; a glass log becomes 50 km of fiber in hours.

### The clever trick

**MOCVD growth of GaN.** For decades, nobody could make a bright blue LED — the materials wouldn't cooperate. Nakamura, Akasaki, and Amano got it to work in the early 1990s. The payoff: blue LEDs enabled white LEDs (blue + yellow phosphor), which replaced incandescent lighting worldwide; also Blu-ray, UV sources, modern displays. Nobel in 2014.

### Signature techniques

MOCVD epitaxy, diamond turning, MRF, ion-beam figuring, preform drawing of fiber.

## 6. Features

*What the material + technique combination gives you.*

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

| Detector | Material | Spectral range |
|---|---|---|
| Silicon photodiode | Si | 400–1100 nm |
| InGaAs | InGaAs | 900–1700 nm |
| Ge | Ge | 800–1800 nm |
| HgCdTe (MCT) | HgCdTe | 1–25 µm (cryogenic) |
| Pyroelectric | LiTaO₃ | Broadband IR |
| Bolometer | VOx on MEMS | Broadband IR (uncooled) |

## D. What to build

1. Shine a laser pointer through a double slit cut in foil. Watch fringes on a wall. You've reproduced Young's experiment from 1801 for the cost of a laser pointer.
2. Hook a photodiode to a scope. Wave a hand over it. See the shadow in volts.
3. Open a Blu-ray drive. The laser is a GaN diode. The optics are plastic. The sensor is a photodiode array. All assembly done by machines.
4. Image a fluorescent tube with a cheap CMOS camera at a short shutter. See the stripes from the 60 Hz flicker.

Full BOM and build steps: [course04 Bench 7](../../course04/07-bench-radiant.md).

## E. The example everyone should work

Will this detector see this light, and how much current will it give? (Bench 7, build 2):

1. Photon energy: E = hc/λ, or in practical units E[eV] = 1240 / λ[nm].
2. Red laser, 650 nm: E = 1.91 eV. Telecom, 1550 nm: E = 0.80 eV.
3. Silicon's bandgap is 1.12 eV, so its cutoff is 1240 / 1.12 = 1,107 nm. It sees 650 nm easily and is blind to 1550 nm. InGaAs (≈ 0.75 eV, cutoff ≈ 1,650 nm) is what you need there.
4. Responsivity of a photodiode: R = QE · λ[nm] / 1240 A/W. A silicon BPW34 with QE ≈ 0.8 at 650 nm: R = 0.8 × 650 / 1240 = 0.42 A/W.
5. All of a 1 mW red laser spot on the diode: I = 0.42 A/W × 1 mW = 0.42 mA.
6. Into a transimpedance amplifier with a 10 kΩ feedback resistor: V = I · R_f = 0.42 mA × 10 kΩ = 4.2 V. For dim room light (nanoamps to microamps), raise R_f to 1–10 MΩ.

Bandgap decides *whether* you see the light; responsivity decides *how much* signal you get. Every camera, encoder, lidar and fiber receiver is sized with these two numbers.

## F. What to read later

- [Hecht, *Optics*; Saleh & Teich, *Fundamentals of Photonics*](../../course02/08-hecht-saleh-teich-optics-photonics/) — the radiant pile.

## G. Related in other courses

- **Lesson:** [course01 — Lesson 7: Radiant](../../course01/Lesson7.md)
- **Course:** [course01 — Module 7: Radiant Domain](../../course01/index.md#module-7--radiant-domain)
- **Bench:** [course04 — Bench 7: Radiant](../../course04/07-bench-radiant.md)
- **Manufacturers:** [course05 — Manufacturers & Brands](../../course05/index.md)
