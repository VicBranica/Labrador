# Lesson 2 — Magnetic

[← Lesson 1 — Electrical](Lesson1.md) · [All lessons](index.md#lessons) · [Lesson 3 — Mechanical →](Lesson3.md)

> Domain 2 of 7, in nine steps: start with something you can hold, get one mental model, build it, then learn what it's made of, how it's made, what trick unlocked it, and who got there first.

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

**Theory:** [Module 2](index.md#module-2--magnetic-domain) · **Stack:** [course03/02-magnetic](../course03/02-magnetic/README.md) · **Bench:** [course04/02-bench-magnetic](../course04/02-bench-magnetic.md)

## 1. What you're looking at

*← start concrete*

A motor. Open it. Count the magnets. Note the wire wrapped around iron laminations. Spin the shaft and feel the detents (that's the magnetic flux "wanting" to be in the stator teeth).

## 2. The one thing to understand

*← give the mental model*

A magnetic circuit is just an electrical circuit with different words.

| Electrical | Magnetic |
|---|---|
| Voltage | MMF (amp-turns = N × I) |
| Current | Flux Φ |
| Resistance | Reluctance ℛ |
| Ohm's law V = IR | MMF = ℛ × Φ |

Soft iron is low reluctance. Air is high reluctance. The flux follows the easy path, just like current. Everything else — motors, solenoids, loudspeakers, Hall sensors — is this one idea applied with cleverness.

## 3. What to build

*← hands on the bench*

1. Wrap 100 turns of magnet wire around a steel bolt. Hook to a battery. You've made an electromagnet. Measure the pull with a kitchen scale.
2. Pull apart a dead BLDC fan motor. Count the teeth and magnets. Guess what's inside before you look.
3. Hold a Hall sensor near a magnet and watch the output voltage change on a meter.
4. Wind a small motor by hand on a nail with a loop of wire and a battery. The ugliest motor you'll ever make. It still spins.

Full BOM and build steps: [course04 Bench 2](../course04/02-bench-magnetic.md).

## 4. Key materials

*← what it's made of*

- **Soft magnetic:** silicon steel laminations (motors), ferrite (high frequency), Mu-metal (shielding), Metglas (sensors).
- **Permanent magnets:** NdFeB (the modern miracle), SmCo (hot environments), AlNiCo (temperature-stable, weaker), ferrite (cheap, weak).
- **Windings:** copper wire with a varnish coating.

## 5. Key techniques

*← how it's made*

Laminating the steel so eddy currents can't flow (that's the whole reason motor cores are stacks of thin plates). Sintering NdFeB powder in a magnetic field so the grains line up. Winding wire around a bobbin and dunking it in varnish.

## 6. The clever trick

*← what unlocked the industry*

**NdFeB sintering, 1984.** Masato Sagawa aligned iron-neodymium-boron powder in a strong field, pressed it, sintered it. The result had ~10× the energy of ferrite magnets. Everything with a battery today — power tools, drones, EVs, servos — exists because of that one process.

## 7. Who to know

*← short lineage of names*

Ørsted (current makes magnetism), Faraday (motor principle), Hall (transverse voltage), Tesla (AC motor), Sagawa and Croat (NdFeB), Fert and Grünberg (GMR — basis of modern hard-drive read heads).

Year-by-year table of what each one measured and with which equipment: [course03 Domain 2](../course03/02-magnetic/README.md#2-measurement).

## 8. The example everyone should work

*← optional — work it with pencil and paper*

A C-shaped iron core with an air gap, coil of N turns carrying current I:

1. MMF = N·I
2. Total reluctance ≈ gap reluctance = l_gap / (μ₀ · A)
3. Flux Φ = MMF / ℛ
4. Flux density in the gap B = Φ / A
5. Force pulling the gap closed F ≈ B²A / (2μ₀)

That's a relay. That's a solenoid. That's one pole of a motor. One calculation, a hundred products.

<details><summary>Full version, with core reluctance</summary>

A simple C-core electromagnet with coil of N turns carrying current I around a ferromagnetic yoke with an air gap:

1. The coil creates an MMF = N × I (ampere-turns).
2. The yoke has high permeability (μ) and low reluctance: ℛ_core = l_core / (μA).
3. The air gap has μ₀ only, so its reluctance ℛ_gap = l_gap / (μ₀A) usually dominates.
4. Total reluctance: ℛ = ℛ_core + ℛ_gap.
5. Magnetic flux: Φ = MMF / ℛ.
6. Flux density in the gap: B = Φ / A.
7. Force of attraction across the gap: F ≈ B²A / (2μ₀) — the standard relay/solenoid equation.

This single loop is the design calculation behind every relay, solenoid, speaker, and motor pole.

</details>

## 9. What to read later

*← optional — where to go deeper*

- [Fraden, *Handbook of Modern Sensors*](../course02/06-fraden-handbook-of-modern-sensors/)
- [Jiles, *Introduction to Magnetism and Magnetic Materials*](../course02/10-jiles-magnetism-and-magnetic-materials/)
