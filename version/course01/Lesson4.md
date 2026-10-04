# Lesson 4 — Fluidic

[← Lesson 3 — Mechanical](Lesson3.md) · [All lessons](index.md#lessons) · [Lesson 5 — Thermal →](Lesson5.md)

> Domain 4 of 7, in nine steps: start with something you can hold, get one mental model, build it, then learn what it's made of, how it's made, what trick unlocked it, and who got there first.

<details><summary>Lesson structure</summary>

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

</details>

**Theory:** [Module 4](index.md#module-4--fluidic-domain) · **Stack:** [course03/04-fluidic](../course03/04-fluidic/README.md) · **Bench:** [course04/04-bench-fluidic](../course04/04-bench-fluidic.md) · **Pile:** [course05/04-fluidic](../course05/04-fluidic.md)

## 1. What you're looking at

A hydraulic cylinder from a tractor. A pneumatic cylinder from a factory. A pressure gauge. A syringe.

## 2. The one thing to understand

Hydraulics is water. Pneumatics is air. Water is nearly incompressible — press on it and the far end moves immediately. Air compresses — press on it and the far end moves eventually. That one difference changes everything about how the two are used.

## 3. What to build

1. Fill a syringe with water. Cap it. Push. It doesn't move. That's bulk modulus.
2. Fill it with air. Push. It compresses. That's compressibility.
3. Rig two syringes with a tube. Push one, the other extends. That's a hydraulic circuit.
4. Measure pressure by hanging the syringe vertically with weight on top and reading travel.

Full BOM and build steps: [course04 Bench 4](../course04/04-bench-fluidic.md).

## 4. Key materials

Steel (cylinders), hardened steel ground to <1 µm (servo valve spools), aluminum (lightweight applications), bronze (bushings). Seals: NBR for general use, Viton for heat, PTFE for chemicals, polyurethane for dynamic rod seals. Fluids: mineral oil for most things; phosphate ester (Skydrol) for aircraft because it doesn't burn when the hydraulic line gets hit.

## 5. Key techniques

- Honing a cylinder bore to a precise diameter and finish.
- Chrome plating of rods for hardness and corrosion resistance.
- Lapping and matched-pair fitting of servo-valve spools to the bore. Hand-selected pairs. <1 µm clearance.
- Flapper-nozzle amplification — tiny torque motor positions a flapper, which modulates a hydraulic bridge, which drives a spool, which drives a cylinder. That's how a pilot's finger moves a 737's flight control.

## 6. The clever trick

**The two-stage servo valve.** A torque motor you could blow over positions a vane the size of a fingernail. That vane throttles a tiny flow of hydraulic oil, which in turn moves a large spool, which drives thousands of pounds of force at the actuator. Four orders of magnitude of power amplification, with precision maintained end to end.

## 7. Who to know

Pascal (pressure transmission), Bernoulli (flow and pressure), Bramah (the hydraulic press, 1795), Reynolds (laminar vs. turbulent), Vickers and Moog (modern servo valves — Moog valves still fly on everything from F-16s to the Shuttle).

Year-by-year table of what each one measured and with which equipment: [course05 Pile 4](../course05/04-fluidic.md#discoverers--measurement-and-equipment).

## 8. The example everyone should work *(optional)*

Two syringes joined by a tube and filled with water — a hydraulic press on the kitchen table (Bench 4, build 1):

1. Bores (typical): 10 mL syringe ≈ 14.5 mm, 60 mL syringe ≈ 26.7 mm.
2. Piston areas: A₁ = π(7.25 mm)² = 165 mm², A₂ = π(13.35 mm)² = 560 mm².
3. Push the small plunger with 20 N. Pressure in the water: P = F / A₁ = 20 N / 165 mm² = 121 kPa (about 1.2 bar).
4. The same pressure acts on the big piston: F₂ = P · A₂ = 121 kPa · 560 mm² = 68 N — 3.4× the input force (the area ratio).
5. Nothing is free: push the small plunger 30 mm and it displaces 165 × 30 = 4,950 mm³. The big piston moves 4,950 / 560 = 8.8 mm.
6. Check energy: 20 N × 30 mm = 600 N·mm in; 68 N × 8.8 mm = 598 N·mm out. Force went up, travel went down, work stayed the same.

Bonus — laminar or turbulent? Water at 1 m/s in a 10 mm pipe: Re = ρvD/μ = 1000 · 1 · 0.01 / 0.001 = 10,000. Well above ~2,300, so turbulent.

That's Pascal and Bramah: an excavator arm and an aircraft flight-control actuator run on exactly this area ratio, at 200–300 bar instead of 1.2.

More practice: the "Try it" exercises in [Module 4](index.md#module-4--fluidic-domain).

## 9. What to read later *(optional)*

[Merritt, *Hydraulic Control Systems*](../course02/05-merritt-hydraulic-control-systems/)
