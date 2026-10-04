# Course 03 — Domain Stack: Seven Piles, Six Layers

> **Course 03 of 05 — Domain stack** · [← course02](../course02/index.md) · [Project map](../../index.md) · [course04 →](../course04/index.md)
>
> Every domain as a hands-on pile and as a six-layer stack, in one file per domain — plus the three pillars that explain every device and the integration pile where domains meet.
>
> **Builds on:** course01 (Modules 0–9 and Lessons 1–10), course02 (sources)  
> **Feeds into:** course04 (each bench puts a domain on the table), course05 (who makes the parts)

## The six-layer stack

Each domain file climbs the stack from the bottom up:

```
         FEATURES
            ↑
         TECHNIQUE      ← how the material becomes a device
            ↑
         MATERIAL       ← what carries the effect
            ↑
         DISCOVERY      ← the physical effect itself
            ↑
         MEASUREMENT    ← the instrument that first saw the effect
            ↑
         VOCABULARY     ← the terms that let you reason about all of the above
```

## The three pillars

```
   Any sensor or actuator
   is one or more arrows
   between two piles.

   The material + technique
   on each arrow is what
   makes the device possible.

   The slowest domain
   sets the bandwidth.
   The material family
   sets the ceiling.
```

| Pillar | Statement | File |
|---|---|---|
| 1 | Any sensor or actuator is one or more arrows between two piles. | [p1-arrows-between-piles.md](p1-arrows-between-piles.md) |
| 2 | The material + technique on each arrow is what makes the device possible. | [p2-material-and-technique.md](p2-material-and-technique.md) |
| 3 | The slowest domain sets the bandwidth. The material family sets the ceiling. | [p3-bandwidth-and-ceiling.md](p3-bandwidth-and-ceiling.md) |

## The seven piles on the bench

Every sensor and every actuator is one of seven things, or a combination. Lay them out on a bench:

1. Something [electrical](01-electrical/README.md) — a resistor, a capacitor, an op-amp.
2. Something [magnetic](02-magnetic/README.md) — a motor, a Hall sensor, a chunk of NdFeB that pulls your screwdriver off the table.
3. Something [mechanical](03-mechanical/README.md) — a spring, a bearing, a strain gauge glued to a ruler.
4. Something [fluidic](04-fluidic/README.md) — a hydraulic cylinder, a pressure gauge, a syringe.
5. Something [thermal](05-thermal/README.md) — a thermocouple, a Peltier module, a bimetal strip from an old thermostat.
6. Something [chemical](06-chemical/README.md) — a pH probe, a smoke detector cell, a glucose test strip.
7. Something [radiant](07-radiant/README.md) — a photodiode, a laser pointer, an LED, a CCD out of an old camera.

Spend a weekend buying or scrounging these. Total cost: under $100. This is the real curriculum. Everything that follows is just a map through what's on the bench.

→ The full bench, with a BOM for each pile: [course04](../course04/index.md).

## How to work through a pile

For each pile:

1. Pick one device from the bench.
2. Take it apart, or look at a cutaway. Draw what's inside on a piece of paper.
3. Name the materials. Just name them. Copper. Ferrite. Steel. Rubber. If you don't know, cut it, scratch it, weigh it — the material tells you about itself.
4. Figure out what the material is doing. Carrying current. Carrying flux. Stretching. Sealing. Insulating. Converting light to electrons.
5. Build a kitchen-table version. It doesn't have to work well. It has to work.
6. Measure it. Multimeter, scale, ruler, phone camera. Compare to the real thing.
7. Then look up the equation. Now it means something.

If you can do steps 1 through 6 for every pile, you know this discipline better than most people with a degree in it.

## Domains

| # | Domain | Effort × flow | File | Lesson | Bench |
|---|---|---|---|---|---|
| 1 | Electrical | Effort: Voltage (V) · Flow: Current (I) · Power: V × I | [01-electrical](01-electrical/README.md) | [Lesson 1](../course01/Lesson1.md) | [Bench 1](../course04/01-bench-electrical.md) |
| 2 | Magnetic | Effort: MMF (N·I) · Flow: dΦ/dt · Circuit law: MMF = ℛΦ, with ℛ = l / (μA) | [02-magnetic](02-magnetic/README.md) | [Lesson 2](../course01/Lesson2.md) | [Bench 2](../course04/02-bench-magnetic.md) |
| 3 | Mechanical | Effort: Force (F) / Torque (τ) · Flow: Velocity (v) / Angular velocity (ω) · Power: F × v, τ × ω | [03-mechanical](03-mechanical/README.md) | [Lesson 3](../course01/Lesson3.md) | [Bench 3](../course04/03-bench-mechanical.md) |
| 4 | Fluidic | Effort: Pressure (P) · Flow: Volumetric flow (Q) · Power: P × Q | [04-fluidic](04-fluidic/README.md) | [Lesson 4](../course01/Lesson4.md) | [Bench 4](../course04/04-bench-fluidic.md) |
| 5 | Thermal | Effort: Temperature (T) · Flow: Heat flow (dQ/dt) · Note: first-order and irreversible — no thermal inductance | [05-thermal](05-thermal/README.md) | [Lesson 5](../course01/Lesson5.md) | [Bench 5](../course04/05-bench-thermal.md) |
| 6 | Chemical | State variable: Concentration / activity · Note: does not fit the clean effort × flow pattern | [06-chemical](06-chemical/README.md) | [Lesson 6](../course01/Lesson6.md) | [Bench 6](../course04/06-bench-chemical.md) |
| 7 | Radiant | State variable: Photon flux · Note: does not fit the clean effort × flow pattern | [07-radiant](07-radiant/README.md) | [Lesson 7](../course01/Lesson7.md) | [Bench 7](../course04/07-bench-radiant.md) |

## How each domain file is organized

| Part | Sections | Purpose |
|---|---|---|
| Hands on | A. What you're looking at · B. The one thing to understand (+ key relations) · C. This pile on the three pillars | Start concrete, get the mental model, place the pile |
| Six layers | 1. Vocabulary · 2. Measurement · 3. Discovery · 4. Material · 5. Technique (clever trick, signature techniques) · 6. Features | Climb the stack from terms to features |
| Back to the bench | D. What to build · E. The example everyone should work | Build it, then work the numbers |
| Further | F. What to read later · G. Related in other courses | Books, lesson, module, bench, manufacturers |

## Course map

| Order | File | What it covers |
|---|---|---|
| 1 | [p1-arrows-between-piles.md](p1-arrows-between-piles.md) | Pillar 1 — devices as crossings; the same roles on every arrow |
| 2 | [p2-material-and-technique.md](p2-material-and-technique.md) | Pillar 2 — material and technique families; the clever trick on each pile |
| 3 | [p3-bandwidth-and-ceiling.md](p3-bandwidth-and-ceiling.md) | Pillar 3 — sensor vs. actuator use, energy density, bandwidth |
| 4 | [01-electrical/README.md](01-electrical/README.md) | Domain 1 — Electrical |
| 5 | [02-magnetic/README.md](02-magnetic/README.md) | Domain 2 — Magnetic |
| 6 | [03-mechanical/README.md](03-mechanical/README.md) | Domain 3 — Mechanical |
| 7 | [04-fluidic/README.md](04-fluidic/README.md) | Domain 4 — Fluidic |
| 8 | [05-thermal/README.md](05-thermal/README.md) | Domain 5 — Thermal |
| 9 | [06-chemical/README.md](06-chemical/README.md) | Domain 6 — Chemical |
| 10 | [07-radiant/README.md](07-radiant/README.md) | Domain 7 — Radiant |
| 11 | [08-integration.md](08-integration.md) | The integration pile: real devices, how to design one, heuristics, one-page map |

## Seven Primary Domains at a Glance

| Domain | State variables | "Effort" × "Flow" | Energy form |
|---|---|---|---|
| Electrical | Voltage, current, charge | V × I | Electric field, current flow |
| Magnetic | Flux, MMF | MMF × dΦ/dt | Magnetic field |
| Mechanical (translational) | Force, velocity, position | F × v | Kinetic + elastic |
| Mechanical (rotational) | Torque, angular velocity, angle | τ × ω | Kinetic + elastic |
| Fluidic | Pressure, volumetric flow | P × Q | Pressure–volume |
| Thermal | Temperature, heat flow | T × dQ/dt | Internal energy |
| Chemical / Radiant | Concentration, photon flux | — | Chemical bonds, EM radiation |

## Sources

- [course01 — Physical Domains in Sensors & Actuators](../course01/index.md): Modules 1–7 and Appendices A, C, D, F, G.
- [course02 — Reading list](../course02/index.md): the books and videos cited in each domain file.
- [Design heuristics](../course02/09-gelbart-videos/design.md): applies across all seven domains.
