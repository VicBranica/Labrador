# Domain 4 — Fluidic

[← Course 03 index](../index.md) · [← Domain 3 — Mechanical](../03-mechanical/README.md) · [Domain 5 — Thermal →](../05-thermal/README.md)

**Effort:** Pressure (P) · **Flow:** Volumetric flow (Q) · **Power:** P × Q

**Lesson:** [course01 Lesson 4](../../course01/Lesson4.md) · **Theory:** [course01 Module 4](../../course01/index.md#module-4--fluidic-domain) · **Bench:** [course04 Bench 4](../../course04/04-bench-fluidic.md)

> Hands on first (A–C), then the six layers from the bottom of the stack up (1–6), then back to the bench (D–E).

## A. What you're looking at

A hydraulic cylinder from a tractor. A pneumatic cylinder from a factory. A pressure gauge. A syringe.

## B. The one thing to understand

Hydraulics is water. Pneumatics is air. Water is nearly incompressible — press on it and the far end moves immediately. Air compresses — press on it and the far end moves eventually. That one difference changes everything about how the two are used.

## C. This pile on the three pillars

| Pillar | At this pile |
|---|---|
| [1 · Arrows between piles](../p1-arrows-between-piles.md) | Hydraulic cylinder: fluidic → mechanical |
| [2 · Material + technique](../p2-material-and-technique.md) | See [4. Material](#4-material) and [5. Technique](#5-technique) below |
| [3 · Bandwidth](../p3-bandwidth-and-ceiling.md) | Pneumatic 10–100 Hz (compressibility) · hydraulic 10–1000 Hz (fluid inertia, bulk modulus) |
| [3 · Ceiling (energy density)](../p3-bandwidth-and-ceiling.md) | Hydraulic: high (oil + honed steel) · pneumatic: medium (air + alloy) |
| Role | Highest force density (hydraulic); fast and compliant (pneumatic). |
| As sensor input / actuator output | Common / Common |
| Characteristic effects | Bernoulli, Navier–Stokes, Reynolds number, compressibility, cavitation. |

## 1. Vocabulary

*The terms that let you reason about everything below.*

| Term | Meaning |
|---|---|
| Pressure (P) | Force per unit area. Unit: pascal, bar, psi. |
| Gauge / absolute / differential pressure | Reference choice for the measurement. |
| Volumetric flow (Q) | Volume per time. Unit: L/min, m³/s. |
| Mass flow (ṁ) | Mass per time. Unit: kg/s. |
| Density (ρ) / viscosity (μ) | Fluid properties. |
| Reynolds number (Re) | Ratio of inertial to viscous forces; sets laminar vs. turbulent. |
| Bernoulli's principle | Trade-off between pressure, velocity, and height along a streamline. |
| Head | Pressure expressed as fluid column height. |
| Compressibility | Pneumatic systems have it; hydraulic systems (mostly) don't. |
| Bulk modulus (K) | Fluid stiffness; sets hydraulic bandwidth. |
| Cavitation | Vapor bubbles forming in low-pressure zones; destructive. |
| Hydraulic circuit | Pump + reservoir + valves + actuators, analogous to an electrical circuit. |
| Servo valve | Precision proportional flow-control valve. |
| Accumulator | Fluidic "capacitor" (stores pressurized fluid). |
| Orifice / restrictor | Fluidic "resistor." |

| Electrical | Fluidic |
|---|---|
| Voltage | Pressure |
| Current | Volumetric flow |
| Resistance | Orifice restriction |
| Capacitance | Accumulator |
| Inductance | Fluid column inertia |

## 2. Measurement

*The instruments that first saw each effect.*

| Year | Discoverer | What was measured | Equipment used |
|---|---|---|---|
| 1647 | Pascal | Pressure transmission; altitude variation | Torricellian barometers, hydraulic vessels |
| 1738 | Bernoulli | Velocity vs. pressure in constrictions | Manometers, calibrated orifices |
| 1795 | Bramah | Force multiplication | Hydraulic press with pressure gauge |
| 1883 | Reynolds | Dye streaklines at varied velocity | Glass pipe with dye injection |
| 1951 | Tinsley / Moog | Spool position, flow response | LVDTs, pressure transducers, flow bench |

## 3. Discovery

*The physical effects themselves.*

| Year | Effect / law | Discoverer |
|---|---|---|
| 1647 | Pressure transmission (Pascal's principle) | Pascal |
| 1738 | Flow equation (Bernoulli) | Bernoulli |
| 1795 | Hydraulic press | Bramah |
| 1883 | Reynolds number — laminar/turbulent transition | Reynolds |
| 1951 | Two-stage servo valve | Tinsley/Moog |

### Who to know

Pascal (pressure transmission), Bernoulli (flow and pressure), Bramah (the hydraulic press, 1795), Reynolds (laminar vs. turbulent), Vickers and Moog (modern servo valves — Moog valves still fly on everything from F-16s to the Shuttle).

## 4. Material

*What carries the effect.*

Steel (cylinders), hardened steel ground to <1 µm (servo valve spools), aluminum (lightweight applications), bronze (bushings). Seals: NBR for general use, Viton for heat, PTFE for chemicals, polyurethane for dynamic rod seals. Fluids: mineral oil for most things; phosphate ester (Skydrol) for aircraft because it doesn't burn when the hydraulic line gets hit.

## 5. Technique

*How the material becomes a device.*

- Honing a cylinder bore to a precise diameter and finish.
- Chrome plating of rods for hardness and corrosion resistance.
- Lapping and matched-pair fitting of servo-valve spools to the bore. Hand-selected pairs. <1 µm clearance.
- Flapper-nozzle amplification — tiny torque motor positions a flapper, which modulates a hydraulic bridge, which drives a spool, which drives a cylinder. That's how a pilot's finger moves a 737's flight control.

### The clever trick

**The two-stage servo valve.** A torque motor you could blow over positions a vane the size of a fingernail. That vane throttles a tiny flow of hydraulic oil, which in turn moves a large spool, which drives thousands of pounds of force at the actuator. Four orders of magnitude of power amplification, with precision maintained end to end.

### Signature techniques

Lapping & matched-pair fitting, DRIE of silicon MEMS, chrome plating of rods, flapper-nozzle amplification.

## 6. Features

*What the material + technique combination gives you.*

| Function | Material | Technique | Features |
|---|---|---|---|
| Cylinders & valve bodies | Steel, cast iron, aluminum, bronze | Casting, honing, chrome plating | High pressure, long life |
| Spools & pistons | Hardened steel | Grinding, lapping, matched-pair fitting | <1 µm clearance for servo valves |
| Static seals | NBR, Viton, EPDM, PTFE | Molding, O-ring design | Pressure containment |
| Dynamic seals | PTFE-bronze, polyurethane, HNBR | Molding, loading-ring design | Low friction, long stroke life |
| Hydraulic fluids | Mineral oil, synthetic ester, water-glycol, phosphate ester | Refining, additive blending | Lubricity, fire resistance |
| Pressure diaphragms | 316 SS, Hastelloy, silicon (MEMS) | Diffusion bonding, DRIE, EB welding | Chemical resistance |

| Property | Hydraulic | Pneumatic |
|---|---|---|
| Compressibility | Low | High |
| Bandwidth | 10–1000 Hz | 10–100 Hz |
| Force density | Very high | Medium |
| Compliance | Stiff | Soft |
| Typical use | Heavy machinery, aircraft | Automation, grippers |

Two-stage flapper-nozzle servo valves give precision force/position control up to ~500 Hz.

## D. What to build

1. Fill a syringe with water. Cap it. Push. It doesn't move. That's bulk modulus.
2. Fill it with air. Push. It compresses. That's compressibility.
3. Rig two syringes with a tube. Push one, the other extends. That's a hydraulic circuit.
4. Measure pressure by hanging the syringe vertically with weight on top and reading travel.

Full BOM and build steps: [course04 Bench 4](../../course04/04-bench-fluidic.md).

## E. The example everyone should work

Two syringes joined by a tube and filled with water — a hydraulic press on the kitchen table (Bench 4, build 1):

1. Bores (typical): 10 mL syringe ≈ 14.5 mm, 60 mL syringe ≈ 26.7 mm.
2. Piston areas: A₁ = π(7.25 mm)² = 165 mm², A₂ = π(13.35 mm)² = 560 mm².
3. Push the small plunger with 20 N. Pressure in the water: P = F / A₁ = 20 N / 165 mm² = 121 kPa (about 1.2 bar).
4. The same pressure acts on the big piston: F₂ = P · A₂ = 121 kPa · 560 mm² = 68 N — 3.4× the input force (the area ratio).
5. Nothing is free: push the small plunger 30 mm and it displaces 165 × 30 = 4,950 mm³. The big piston moves 4,950 / 560 = 8.8 mm.
6. Check energy: 20 N × 30 mm = 600 N·mm in; 68 N × 8.8 mm = 598 N·mm out. Force went up, travel went down, work stayed the same.

Bonus — laminar or turbulent? Water at 1 m/s in a 10 mm pipe: Re = ρvD/μ = 1000 · 1 · 0.01 / 0.001 = 10,000. Well above ~2,300, so turbulent.

That's Pascal and Bramah: an excavator arm and an aircraft flight-control actuator run on exactly this area ratio, at 200–300 bar instead of 1.2.

## F. What to read later

- [Merritt, *Hydraulic Control Systems*](../../course02/05-merritt-hydraulic-control-systems/) — the fluidic classic.

## G. Related in other courses

- **Lesson:** [course01 — Lesson 4: Fluidic](../../course01/Lesson4.md)
- **Course:** [course01 — Module 4: Fluidic Domain](../../course01/index.md#module-4--fluidic-domain)
- **Bench:** [course04 — Bench 4: Fluidic](../../course04/04-bench-fluidic.md)
- **Manufacturers:** [course05 — Manufacturers & Brands](../../course05/index.md)
