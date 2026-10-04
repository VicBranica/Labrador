# Course 05 — The Seven Piles

> **Course 05 of 06 — Seven piles, three pillars** · [← course04](../course04/index.md) · [Project map](../../index.md) · [course06 →](../course06/index.md)
>
> A bench-first map of the discipline: seven piles of hardware, three pillars that explain every device, and the terms and tables to go with them.
>
> **Builds on:** course01 (Modules 0 and 8), course04 (the bench itself)  
> **Feeds into:** course03 and course04 (each pile links its theory and bench)

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

1. Something [electrical](01-electrical.md) — a resistor, a capacitor, an op-amp.
2. Something [magnetic](02-magnetic.md) — a motor, a Hall sensor, a chunk of NdFeB that pulls your screwdriver off the table.
3. Something [mechanical](03-mechanical.md) — a spring, a bearing, a strain gauge glued to a ruler.
4. Something [fluidic](04-fluidic.md) — a hydraulic cylinder, a pressure gauge, a syringe.
5. Something [thermal](05-thermal.md) — a thermocouple, a Peltier module, a bimetal strip from an old thermostat.
6. Something [chemical](06-chemical.md) — a pH probe, a smoke detector cell, a glucose test strip.
7. Something [radiant](07-radiant.md) — a photodiode, a laser pointer, an LED, a CCD out of an old camera.

Spend a weekend buying or scrounging these. Total cost: under $100. This is the real curriculum. Everything that follows is just a map through what's on the bench.

→ The full bench, with a BOM for each pile: [course04](../course04/index.md).

## How to work through the piles

For each pile:

1. Pick one device from the bench.
2. Take it apart, or look at a cutaway. Draw what's inside on a piece of paper.
3. Name the materials. Just name them. Copper. Ferrite. Steel. Rubber. If you don't know, cut it, scratch it, weigh it — the material tells you about itself.
4. Figure out what the material is doing. Carrying current. Carrying flux. Stretching. Sealing. Insulating. Converting light to electrons.
5. Build a kitchen-table version. It doesn't have to work well. It has to work.
6. Measure it. Multimeter, scale, ruler, phone camera. Compare to the real thing.
7. Then look up the equation. Now it means something.

If you can do steps 1 through 6 for every pile, you know this discipline better than most people with a degree in it.

## Course map

| Order | File | What it covers |
|---|---|---|
| 1 | [p1-arrows-between-piles.md](p1-arrows-between-piles.md) | The one idea: devices as crossings; the same roles on every arrow |
| 2 | [p2-material-and-technique.md](p2-material-and-technique.md) | Material and technique families that cut across piles; the clever trick on each pile |
| 3 | [p3-bandwidth-and-ceiling.md](p3-bandwidth-and-ceiling.md) | Sensor vs. actuator use, energy density, bandwidth |
| 4 | [01-electrical.md](01-electrical.md) | Pile 1 — Electrical |
| 5 | [02-magnetic.md](02-magnetic.md) | Pile 2 — Magnetic |
| 6 | [03-mechanical.md](03-mechanical.md) | Pile 3 — Mechanical |
| 7 | [04-fluidic.md](04-fluidic.md) | Pile 4 — Fluidic |
| 8 | [05-thermal.md](05-thermal.md) | Pile 5 — Thermal |
| 9 | [06-chemical.md](06-chemical.md) | Pile 6 — Chemical |
| 10 | [07-radiant.md](07-radiant.md) | Pile 7 — Radiant |
| 11 | [08-integration.md](08-integration.md) | The integration pile: real devices, how to design one, heuristics, one-page map |

Every pile file follows the same order:

1. What you're looking at
2. The one thing to understand
3. This pile on the three pillars
4. What to build
5. The example everyone should work
6. Material + technique — key materials, key techniques, the clever trick, materials/techniques/features table, signature techniques
7. Who to know — with the discoverers table
8. Important terms
9. What to read later (where a book is named)

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
