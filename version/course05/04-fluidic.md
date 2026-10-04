# Domain 4 — Fluidic

[← Course 05 index](index.md) · [← Domain 3 — Mechanical](03-mechanical.md) · [Domain 5 — Thermal →](05-thermal.md)

**Theory:** [course03/04-fluidic](../course03/04-fluidic/README.md) · **Bench:** [course04/04-bench-fluidic](../course04/04-bench-fluidic.md)

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

## Role

Highest force density (hydraulic); fast and compliant (pneumatic).

## Characteristic effects

Bernoulli, Navier–Stokes, Reynolds number, compressibility, cavitation.

## Discoverers — measurement and equipment

| Year | Discoverer | What was measured | Equipment used |
|---|---|---|---|
| 1647 | Pascal | Pressure transmission; altitude variation | Torricellian barometers, hydraulic vessels |
| 1738 | Bernoulli | Velocity vs. pressure in constrictions | Manometers, calibrated orifices |
| 1795 | Bramah | Force multiplication | Hydraulic press with pressure gauge |
| 1883 | Reynolds | Dye streaklines at varied velocity | Glass pipe with dye injection |
| 1951 | Tinsley / Moog | Spool position, flow response | LVDTs, pressure transducers, flow bench |

## Materials, techniques, features

| Function | Material | Technique | Features |
|---|---|---|---|
| Cylinders & valve bodies | Steel, cast iron, aluminum, bronze | Casting, honing, chrome plating | High pressure, long life |
| Spools & pistons | Hardened steel | Grinding, lapping, matched-pair fitting | <1 µm clearance for servo valves |
| Static seals | NBR, Viton, EPDM, PTFE | Molding, O-ring design | Pressure containment |
| Dynamic seals | PTFE-bronze, polyurethane, HNBR | Molding, loading-ring design | Low friction, long stroke life |
| Hydraulic fluids | Mineral oil, synthetic ester, water-glycol, phosphate ester | Refining, additive blending | Lubricity, fire resistance |
| Pressure diaphragms | 316 SS, Hastelloy, silicon (MEMS) | Diffusion bonding, DRIE, EB welding | Chemical resistance |

## Signature techniques

Lapping & matched-pair fitting, DRIE of silicon MEMS, chrome plating of rods, flapper-nozzle amplification.
