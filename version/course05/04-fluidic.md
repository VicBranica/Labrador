# Pile 4 — Fluidic

[← Course 05 index](index.md) · [← Pile 3](03-mechanical.md) · [Pile 5 →](05-thermal.md)

**Course:** [course01 Module 4](../course01/index.md#module-4--fluidic-domain) · **Theory:** [course03/04-fluidic](../course03/04-fluidic/README.md) · **Bench:** [course04/04-bench-fluidic](../course04/04-bench-fluidic.md)

## What you're looking at

A hydraulic cylinder from a tractor. A pneumatic cylinder from a factory. A pressure gauge. A syringe.

## The one thing to understand

Hydraulics is water. Pneumatics is air. Water is nearly incompressible — press on it and the far end moves immediately. Air compresses — press on it and the far end moves eventually. That one difference changes everything about how the two are used.

## This pile on the three pillars

| Pillar | At this pile |
|---|---|
| [1 · Arrows between piles](p1-arrows-between-piles.md) | Hydraulic cylinder: fluidic → mechanical |
| [2 · Material + technique](p2-material-and-technique.md) | See [Material + technique](#material--technique) below |
| [3 · Bandwidth](p3-bandwidth-and-ceiling.md) | Pneumatic 10–100 Hz (compressibility) · hydraulic 10–1000 Hz (fluid inertia, bulk modulus) |
| [3 · Ceiling (energy density)](p3-bandwidth-and-ceiling.md) | Hydraulic: high (oil + honed steel) · pneumatic: medium (air + alloy) |
| Role | Highest force density (hydraulic); fast and compliant (pneumatic). |
| As sensor input / actuator output | Common / Common |
| Characteristic effects | Bernoulli, Navier–Stokes, Reynolds number, compressibility, cavitation. |

## What to build

1. Fill a syringe with water. Cap it. Push. It doesn't move. That's bulk modulus.
2. Fill it with air. Push. It compresses. That's compressibility.
3. Rig two syringes with a tube. Push one, the other extends. That's a hydraulic circuit.
4. Measure pressure by hanging the syringe vertically with weight on top and reading travel.

## Material + technique

### Key materials

Steel (cylinders), hardened steel ground to <1 µm (servo valve spools), aluminum (lightweight applications), bronze (bushings). Seals: NBR for general use, Viton for heat, PTFE for chemicals, polyurethane for dynamic rod seals. Fluids: mineral oil for most things; phosphate ester (Skydrol) for aircraft because it doesn't burn when the hydraulic line gets hit.

### Key techniques

- Honing a cylinder bore to a precise diameter and finish.
- Chrome plating of rods for hardness and corrosion resistance.
- Lapping and matched-pair fitting of servo-valve spools to the bore. Hand-selected pairs. <1 µm clearance.
- Flapper-nozzle amplification — tiny torque motor positions a flapper, which modulates a hydraulic bridge, which drives a spool, which drives a cylinder. That's how a pilot's finger moves a 737's flight control.

### The clever trick

**The two-stage servo valve.** A torque motor you could blow over positions a vane the size of a fingernail. That vane throttles a tiny flow of hydraulic oil, which in turn moves a large spool, which drives thousands of pounds of force at the actuator. Four orders of magnitude of power amplification, with precision maintained end to end.

### Materials, techniques, features

| Function | Material | Technique | Features |
|---|---|---|---|
| Cylinders & valve bodies | Steel, cast iron, aluminum, bronze | Casting, honing, chrome plating | High pressure, long life |
| Spools & pistons | Hardened steel | Grinding, lapping, matched-pair fitting | <1 µm clearance for servo valves |
| Static seals | NBR, Viton, EPDM, PTFE | Molding, O-ring design | Pressure containment |
| Dynamic seals | PTFE-bronze, polyurethane, HNBR | Molding, loading-ring design | Low friction, long stroke life |
| Hydraulic fluids | Mineral oil, synthetic ester, water-glycol, phosphate ester | Refining, additive blending | Lubricity, fire resistance |
| Pressure diaphragms | 316 SS, Hastelloy, silicon (MEMS) | Diffusion bonding, DRIE, EB welding | Chemical resistance |

### Signature techniques

Lapping & matched-pair fitting, DRIE of silicon MEMS, chrome plating of rods, flapper-nozzle amplification.

## Who to know

Pascal (pressure transmission), Bernoulli (flow and pressure), Bramah (the hydraulic press, 1795), Reynolds (laminar vs. turbulent), Vickers and Moog (modern servo valves — Moog valves still fly on everything from F-16s to the Shuttle).

### Discoverers — measurement and equipment

| Year | Discoverer | What was measured | Equipment used |
|---|---|---|---|
| 1647 | Pascal | Pressure transmission; altitude variation | Torricellian barometers, hydraulic vessels |
| 1738 | Bernoulli | Velocity vs. pressure in constrictions | Manometers, calibrated orifices |
| 1795 | Bramah | Force multiplication | Hydraulic press with pressure gauge |
| 1883 | Reynolds | Dye streaklines at varied velocity | Glass pipe with dye injection |
| 1951 | Tinsley / Moog | Spool position, flow response | LVDTs, pressure transducers, flow bench |

## Important terms

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

## What to read later

[Merritt, *Hydraulic Control Systems*](../course02/05-merritt-hydraulic-control-systems/)
