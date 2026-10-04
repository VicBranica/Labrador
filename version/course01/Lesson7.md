# Lesson 7 — Radiant

[← Lesson 6 — Chemical](Lesson6.md) · [All lessons](index.md#lessons) · [course01 index →](index.md)

> Domain 7 of 7, in nine steps: start with something you can hold, get one mental model, build it, then learn what it's made of, how it's made, what trick unlocked it, and who got there first.

## Lesson structure

```
1.  What you're looking at         ← start concrete
2.  The one thing to understand    ← give the mental model
3.  What to build                  ← hands on the bench
4.  Key materials                  ← what it's made of
5.  Key techniques                 ← how it's made
6.  The clever trick               ← what unlocked the industry
7.  Who to know                    ← short lineage of names
8.  The example everyone should work   (optional)
9.  What to read later             (optional)
```

| Step | Section | Purpose |
|---|---|---|
| 1 | [What you're looking at](#1-what-youre-looking-at) | Start concrete. |
| 2 | [The one thing to understand](#2-the-one-thing-to-understand) | Give the mental model. |
| 3 | [What to build](#3-what-to-build) | Hands on the bench. |
| 4 | [Key materials](#4-key-materials) | What it's made of. |
| 5 | [Key techniques](#5-key-techniques) | How it's made. |
| 6 | [The clever trick](#6-the-clever-trick) | What unlocked the industry. |
| 7 | [Who to know](#7-who-to-know) | Short lineage of names. |
| 8 | [The example everyone should work](#8-the-example-everyone-should-work) | Optional — work it with pencil and paper. |
| 9 | [What to read later](#9-what-to-read-later) | Optional — where to go deeper. |

**Theory:** [Module 7](index.md#module-7--radiant-domain) · **Stack:** [course03/07-radiant](../course03/07-radiant/README.md) · **Bench:** [course04/07-bench-radiant](../course04/07-bench-radiant.md) · **Pile:** [course05/07-radiant](../course05/07-radiant.md)

## 1. What you're looking at

*← start concrete*

A photodiode. An LED. A laser pointer. A CCD from an old digital camera. A pair of mirrors and a glass of water (interference, refraction).

## 2. The one thing to understand

*← give the mental model*

Light is both a wave (diffraction, interference, wavelength) and a particle (energy = hν, photoelectric effect). You need both pictures. Every optical device uses one or the other, often in the same sentence.

Photons with energy above a material's bandgap get absorbed and knock out electrons. Silicon's bandgap sets its spectral range (400–1100 nm). Smaller bandgaps see further into the infrared. Bigger bandgaps work in UV.

## 3. What to build

*← hands on the bench*

1. Shine a laser pointer through a double slit cut in foil. Watch fringes on a wall. You've reproduced Young's experiment from 1801 for the cost of a laser pointer.
2. Hook a photodiode to a scope. Wave a hand over it. See the shadow in volts.
3. Open a Blu-ray drive. The laser is a GaN diode. The optics are plastic. The sensor is a photodiode array. All assembly done by machines.
4. Image a fluorescent tube with a cheap CMOS camera at a short shutter. See the stripes from the 60 Hz flicker.

Full BOM and build steps: [course04 Bench 7](../course04/07-bench-radiant.md).

## 4. Key materials

*← what it's made of*

- **Photodetectors:** silicon (visible), InGaAs (telecom), Ge (near-IR), HgCdTe (mid/long IR, cryogenic), InSb (mid-IR), GaN (UV).
- **Emitters:** GaN/InGaN (blue, green, white LEDs; Blu-ray lasers), AlGaInP (red/amber), GaAs/AlGaAs (near-IR lasers).
- **Lenses and windows:** fused silica (broad), sapphire (rugged), ZnSe and Ge (IR), CaF₂ (UV).
- **Mirrors:** aluminum (broad), silver (visible), dielectric stacks (laser-grade).
- **Fiber:** fused silica. One meter of preform draws into tens of kilometers of fiber.

## 5. Key techniques

*← how it's made*

- **MOCVD epitaxy** — atomic-layer growth of semiconductors. Enables every modern LED and semiconductor laser.
- **Diamond turning** — single-point cutting of optics with nanometer finish; aspheric and freeform shapes no polisher can make.
- **Magnetorheological finishing (MRF)** — polishing with a magnetically-shaped slurry. Finishes to a fraction of a wavelength.
- **Preform drawing of fiber** — one of the most dramatic manufacturing processes in existence; a glass log becomes 50 km of fiber in hours.

## 6. The clever trick

*← what unlocked the industry*

**MOCVD growth of GaN.** For decades, nobody could make a bright blue LED — the materials wouldn't cooperate. Nakamura, Akasaki, and Amano got it to work in the early 1990s. The payoff: blue LEDs enabled white LEDs (blue + yellow phosphor), which replaced incandescent lighting worldwide; also Blu-ray, UV sources, modern displays. Nobel in 2014.

## 7. Who to know

*← short lineage of names*

Young (interference), Michelson (interferometry), Einstein (photoelectric effect), Maiman (first laser, 1960), Holonyak (first visible LED, 1962), Boyle and Smith (CCD, 1969), Nakamura/Akasaki/Amano (GaN blue LED), Ashkin (optical tweezers).

Year-by-year table of what each one measured and with which equipment: [course05 Pile 7](../course05/07-radiant.md#discoverers--measurement-and-equipment).

## 8. The example everyone should work

*← optional — work it with pencil and paper*

Will this detector see this light, and how much current will it give? (Bench 7, build 2):

1. Photon energy: E = hc/λ, or in practical units E[eV] = 1240 / λ[nm].
2. Red laser, 650 nm: E = 1.91 eV. Telecom, 1550 nm: E = 0.80 eV.
3. Silicon's bandgap is 1.12 eV, so its cutoff is 1240 / 1.12 = 1,107 nm. It sees 650 nm easily and is blind to 1550 nm. InGaAs (≈ 0.75 eV, cutoff ≈ 1,650 nm) is what you need there.
4. Responsivity of a photodiode: R = QE · λ[nm] / 1240 A/W. A silicon BPW34 with QE ≈ 0.8 at 650 nm: R = 0.8 × 650 / 1240 = 0.42 A/W.
5. All of a 1 mW red laser spot on the diode: I = 0.42 A/W × 1 mW = 0.42 mA.
6. Into a transimpedance amplifier with a 10 kΩ feedback resistor: V = I · R_f = 0.42 mA × 10 kΩ = 4.2 V. For dim room light (nanoamps to microamps), raise R_f to 1–10 MΩ.

Bandgap decides *whether* you see the light; responsivity decides *how much* signal you get. Every camera, encoder, lidar and fiber receiver is sized with these two numbers.

More practice: the "Try it" exercises in [Module 7](index.md#module-7--radiant-domain).

## 9. What to read later

*← optional — where to go deeper*

[Hecht, *Optics*; Saleh & Teich, *Fundamentals of Photonics*](../course02/08-hecht-saleh-teich-optics-photonics/)
