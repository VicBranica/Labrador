# Domain 2 — Magnetic

[← Course 03 index](../index.md) · [← Domain 1 — Electrical](../01-electrical/README.md) · [Domain 3 — Mechanical →](../03-mechanical/README.md)

**Effort:** MMF (N·I) · **Flow:** dΦ/dt · **Circuit law:** MMF = ℛΦ, with ℛ = l / (μA)

**Lesson:** [course01 Lesson 2](../../course01/Lesson2.md) · **Theory:** [course01 Module 2](../../course01/index.md#module-2--magnetic-domain) · **Bench:** [course04 Bench 2](../../course04/02-bench-magnetic.md)

> Hands on first (A–C), then the six layers from the bottom of the stack up (1–6), then back to the bench (D–E).

## A. What you're looking at

A motor. Open it. Count the magnets. Note the wire wrapped around iron laminations. Spin the shaft and feel the detents (that's the magnetic flux "wanting" to be in the stator teeth).

## B. The one thing to understand

A magnetic circuit is just an electrical circuit with different words.

| Electrical | Magnetic |
|---|---|
| Voltage | MMF (amp-turns = N × I) |
| Current | Flux Φ |
| Resistance | Reluctance ℛ |
| Ohm's law V = IR | MMF = ℛ × Φ |

Soft iron is low reluctance. Air is high reluctance. The flux follows the easy path, just like current. Everything else — motors, solenoids, loudspeakers, Hall sensors — is this one idea applied with cleverness.

## C. This pile on the three pillars

| Pillar | At this pile |
|---|---|
| [1 · Arrows between piles](../p1-arrows-between-piles.md) | Motor: electrical → magnetic → mechanical |
| [2 · Material + technique](../p2-material-and-technique.md) | See [4. Material](#4-material) and [5. Technique](#5-technique) below |
| [3 · Bandwidth](../p3-bandwidth-and-ceiling.md) | kHz–MHz — limited by core losses, eddy currents |
| [3 · Ceiling (energy density)](../p3-bandwidth-and-ceiling.md) | Electromagnetic: medium (copper + NdFeB + silicon steel) |
| Role | Dominant actuation domain; core sensing domain for rugged, non-contact measurement. |
| As sensor input / actuator output | Very common / Dominant |
| Characteristic effects | Lorentz force, saturation, hysteresis, eddy currents. |

## 1. Vocabulary

*The terms that let you reason about everything below.*

| Term | Meaning |
|---|---|
| Magnetic field (H) | Field strength from currents and magnets. Unit: A/m. |
| Magnetic flux (Φ) | Total "amount" of magnetic field through a surface. Unit: weber (Wb). |
| Flux density (B) | Flux per unit area; what the material "sees." Unit: tesla (T). |
| Permeability (μ) | How easily a material carries flux. μ = μ₀μᵣ. |
| Relative permeability (μᵣ) | Material's permeability compared to vacuum. |
| Reluctance (ℛ) | Magnetic analog of resistance; "resistance to flux." |
| Magnetomotive force (MMF) | Driver of flux in a magnetic circuit; MMF = N × I. Unit: ampere-turn. |
| Magnetic circuit | Closed loop that carries flux, analyzed like an electrical circuit (MMF = ℛΦ, analogous to V = IR). |
| Electromagnet | Coil + ferromagnetic core; flux produced only while current flows. |
| Permanent magnet | Material that retains magnetization without external current. |
| B-H curve | Flux density vs. applied field — nonlinear, hysteretic for ferromagnets. |
| Hysteresis | Lag of B behind H; area of the loop = loss per cycle. |
| Saturation | Point where further H no longer increases B meaningfully. |
| Remanence (Bᵣ) | B remaining after H returns to zero. |
| Coercivity (Hc) | H needed to drive B back to zero. |
| Energy product (BHmax) | Figure of merit for permanent magnets. |
| Eddy currents | Induced circulating currents in conductive cores; loss mechanism. |
| Lorentz force | Force on a current-carrying conductor in a field: F = IL × B. |
| Hall effect | Transverse voltage across a conductor in a perpendicular field. |
| GMR / TMR | Giant / tunnel magnetoresistance; large resistance changes in multilayers. |
| Air gap | Non-magnetic break in a magnetic circuit; dominates reluctance. |

| Electrical | Magnetic |
|---|---|
| Voltage (V) | MMF (N·I) |
| Current (I) | Flux (Φ) |
| Resistance (R) | Reluctance (ℛ) |
| V = IR | MMF = ℛΦ |

## 2. Measurement

*The instruments that first saw each effect.*

| Year | Discoverer | What was measured | Equipment used |
|---|---|---|---|
| 1820 | Ørsted | Compass deflection beside current | Voltaic pile, platinum wire, compass |
| 1821 | Faraday | Continuous rotation of wire around a magnet | Mercury bath, bar magnet, suspended wire |
| 1879 | Edwin Hall | Transverse voltage across gold leaf in a field | Thin gold leaf, electromagnet, galvanometer |
| 1882 | Ferraris / Tesla | Torque from phase-shifted AC coils | AC source, two-phase stator, copper rotor |
| 1888 | Tesla | Torque–speed of polyphase induction motor | Polyphase alternator, squirrel cage, prony brake |
| 1984 | Sagawa / Croat | Hysteresis loop of Nd₂Fe₁₄B | Vibrating-sample magnetometer, hysteresisgraph |
| 1988 | Fert & Grünberg | ~50% resistance drop in Fe/Cr multilayers | MBE chambers, cryostats, superconducting magnets |

## 3. Discovery

*The physical effects themselves.*

| Year | Effect / law | Discoverer |
|---|---|---|
| 1820 | Current ↔ magnetism | Ørsted |
| 1821 | Motor principle | Faraday |
| 1879 | Hall effect | Hall |
| 1888 | AC induction motor | Tesla |
| 1984 | NdFeB magnet | Sagawa, Croat |
| 1988 | Giant magnetoresistance (GMR) | Fert, Grünberg |

### Who to know

Ørsted (current makes magnetism), Faraday (motor principle), Hall (transverse voltage), Tesla (AC motor), Sagawa and Croat (NdFeB), Fert and Grünberg (GMR — basis of modern hard-drive read heads).

## 4. Material

*What carries the effect.*

- **Soft magnetic:** silicon steel laminations (motors), ferrite (high frequency), Mu-metal (shielding), Metglas (sensors).
- **Permanent magnets:** NdFeB (the modern miracle), SmCo (hot environments), AlNiCo (temperature-stable, weaker), ferrite (cheap, weak).
- **Windings:** copper wire with a varnish coating.

## 5. Technique

*How the material becomes a device.*

Laminating the steel so eddy currents can't flow (that's the whole reason motor cores are stacks of thin plates). Sintering NdFeB powder in a magnetic field so the grains line up. Winding wire around a bobbin and dunking it in varnish.

### The clever trick

**NdFeB sintering, 1984.** Masato Sagawa aligned iron-neodymium-boron powder in a strong field, pressed it, sintered it. The result had ~10× the energy of ferrite magnets. Everything with a battery today — power tools, drones, EVs, servos — exists because of that one process.

### Signature techniques

Lamination of silicon steel (breaks eddy-current paths); aligned-sintering of NdFeB; thin-film multilayer deposition; rotor skewing.

## 6. Features

*What the material + technique combination gives you.*

| Function | Material | Technique | Features |
|---|---|---|---|
| Soft magnetic cores | Silicon steel, permalloy, Mu-metal, ferrite, Metglas | Lamination, sintering, ribbon casting, annealing | High μᵣ, low hysteresis loss, low eddy loss |
| Permanent magnets | NdFeB, SmCo, AlNiCo, ferrite | Powder metallurgy, aligned-field pressing, sintering | High Bᵣ, high Hc, high BHmax |
| Hall & MR sensors | InSb, GaAs, Si (Hall); permalloy (AMR); Co/Cu, Fe/Cr (GMR); MgO (TMR) | Thin-film deposition, epitaxy, lithography | Non-contact, small, sensitive |
| Electromagnets / coils | Copper magnet wire + soft core | Winding, varnish impregnation | Controllable force, high MMF per cm³ |
| Fluxgate cores | Permalloy, Vitrovac | Thin-ribbon winding, field annealing | Senses geomagnetic-level fields |

Device families: DC brushed motor · BLDC · AC induction · stepper · voice coil · solenoid / electromagnet · Hall sensor · GMR / TMR · LVDT, RVDT, resolver.

Gap force: F ≈ B²A / (2μ₀) — the calculation behind every solenoid, relay, loudspeaker, and motor pole.

## D. What to build

1. Wrap 100 turns of magnet wire around a steel bolt. Hook to a battery. You've made an electromagnet. Measure the pull with a kitchen scale.
2. Pull apart a dead BLDC fan motor. Count the teeth and magnets. Guess what's inside before you look.
3. Hold a Hall sensor near a magnet and watch the output voltage change on a meter.
4. Wind a small motor by hand on a nail with a loop of wire and a battery. The ugliest motor you'll ever make. It still spins.

Full BOM and build steps: [course04 Bench 2](../../course04/02-bench-magnetic.md).

## E. The example everyone should work

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

## F. What to read later

- [Fraden, *Handbook of Modern Sensors*](../../course02/06-fraden-handbook-of-modern-sensors/)
- [Jiles, *Introduction to Magnetism and Magnetic Materials*](../../course02/10-jiles-magnetism-and-magnetic-materials/) — the magnetic pile.

## G. Related in other courses

- **Lesson:** [course01 — Lesson 2: Magnetic](../../course01/Lesson2.md)
- **Course:** [course01 — Module 2: Magnetic Domain](../../course01/index.md#module-2--magnetic-domain)
- **Bench:** [course04 — Bench 2: Magnetic](../../course04/02-bench-magnetic.md)
- **Manufacturers:** [course05 — Manufacturers & Brands](../../course05/index.md)
