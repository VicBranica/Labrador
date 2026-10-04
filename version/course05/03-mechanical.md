# Pile 3 — Mechanical

[← Course 05 index](index.md) · [← Pile 2](02-magnetic.md) · [Pile 4 →](04-fluidic.md)

**Lesson:** [course01 Lesson 3](../course01/Lesson3.md) · **Course:** [course01 Module 3](../course01/index.md#module-3--mechanical-domain) · **Theory:** [course03/03-mechanical](../course03/03-mechanical/README.md) · **Bench:** [course04/03-bench-mechanical](../course04/03-bench-mechanical.md)

## What you're looking at

A spring, a bearing, a bolt, a strain gauge. Also: your bench itself. Mechanical engineering is the one where the thing you build is also the thing you build on.

## The one thing to understand

Stuff bends. A little, under small load, in proportion to the load (Hooke). A lot, with hysteresis and crack growth, under big load. Most of mechanical design is staying in the first regime and designing the second regime out of existence.

## This pile on the three pillars

| Pillar | At this pile |
|---|---|
| [1 · Arrows between piles](p1-arrows-between-piles.md) | Microphone: sound (mechanical) → electrical · Speaker: electrical → sound · Motor: electrical → magnetic → mechanical · Hydraulic cylinder: fluidic → mechanical |
| [2 · Material + technique](p2-material-and-technique.md) | See [Material + technique](#material--technique) below |
| [3 · Bandwidth](p3-bandwidth-and-ceiling.md) | Piezoelectric mechanical: kHz — limited by mechanical resonance |
| [3 · Ceiling (energy density)](p3-bandwidth-and-ceiling.md) | Piezoelectric: high force, tiny stroke (PZT; stack co-firing) |
| Role | Measurand of most industrial sensors; output of nearly every actuator. |
| As sensor input / actuator output | The measurand itself / The goal itself |
| Characteristic effects | Newton's laws, Hooke's law, friction, backlash, compliance, resonance. |

## What to build

1. Glue a strain gauge to an aluminum ruler. Clamp one end. Press the other. Watch the resistance change by a few milliohms per Newton.
2. Make a flexure out of a strip of spring steel cut with a nibbler. Move it with your finger. Notice there's no backlash, no stiction, no wear.
3. Build a kinematic mount from a plate with three divots, three balls, and a mating plate. Lift the top off. Put it back. Verify it returns to the same position within what you can measure.
4. Weigh a chunk of carbon fiber composite and a chunk of aluminum. Flex them. Carbon fiber feels like aluminum but weighs half. That's why satellites are made of it.

## The example everyone should work

A 100 g mass hanging from a 50 N/m spring, with 0.2 N·s/m of damping — the model behind every scale, accelerometer and motion stage:

1. Equation of motion: m·ẍ + c·ẋ + k·x = F(t).
2. Natural frequency: ωₙ = √(k/m) = √(50 / 0.1) = 22.4 rad/s, so fₙ = ωₙ / 2π = 3.56 Hz.
3. Damping ratio: ζ = c / (2√(k·m)) = 0.2 / (2√5) = 0.045.
4. Quality factor: Q = 1 / (2ζ) = 11.2.
5. Read it: ζ is far below 1, so the system is underdamped. Tap it and it rings at about 3.6 Hz for roughly Q ≈ 11 visible cycles before settling.
6. To make it settle without overshoot (critical damping, ζ = 1) you would need c = 2√(k·m) = 4.5 N·s/m — about 22× more damping.

One spring, one mass, one damper: the same three numbers (ωₙ, ζ, Q) describe a kitchen scale, a car suspension, a MEMS accelerometer and a precision stage.

## Material + technique

### Key materials

- Steel for strength, aluminum for weight, titanium for both plus corrosion resistance.
- Spring steel (17-4 PH, 17-7 PH, beryllium copper) for springs and flexures.
- 52100 steel balls for bearings; ceramic (Si₃N₄) for premium bearings.
- Granite, Zerodur, Invar, fused silica when dimensional stability matters more than anything.
- Carbon fiber composites when stiffness-to-weight is king.

### Key techniques

- **Waterjet** — cuts anything flat with no heat-affected zone. The single most useful tool for prototypes. If you only buy one machine, buy time on one.
- **Wire EDM** — spark-erodes hardened materials. The only way to make precise flexures from spring steel.
- **Grinding and lapping** — the mechanical world's lithography; sub-micron flatness.
- **Scraping** — hand-finishing of reference surfaces to <1 µm. Still done. Still unmatched.
- **Kinematic design** — six-point exact constraint. The rule: constrain each DOF exactly once, never twice.
- **Flexure design** — monolithic hinges. No bearings means no friction, no backlash, no lubrication.

### The clever trick

**Flexures.** By making a hinge from a thin section of the same material as the body, you get zero backlash, zero stiction, zero wear, and perfect repeatability — in exchange for limited range. Any precision instrument more expensive than a car has flexures somewhere.

### Materials, techniques, features

| Function | Material | Technique | Features |
|---|---|---|---|
| Structural | Steel, aluminum, titanium, cast iron | Casting, forging, machining, welding | Strength, stiffness |
| High stiffness/weight | Carbon fiber, beryllium, SiC, granite | Autoclave lay-up, HIP, lapping | Very high specific stiffness |
| Springs & flexures | Spring steel, 17-4 PH, BeCu, titanium | Heat treatment, waterjet, wire EDM | Zero backlash, long fatigue life |
| Bearings | 52100 steel, Si₃N₄, bronze | Grinding, honing, superfinishing | Low friction, long life |
| Precision reference | Granite, Zerodur, Invar, fused silica | Grinding, lapping, scraping | Dimensional stability |
| Damping | Viscoelastic polymer, lead, constrained-layer | Lamination, molding | Vibration isolation |

### Signature techniques

Precision grinding & lapping, waterjet cutting, wire EDM, scraping, kinematic design, flexure design, autoclave composite lay-up.

## Who to know

Hooke (elasticity), Newton (motion), Coulomb (friction), Guillaume (Invar — made metrology possible), Slocum and Hale (modern precision machine design — read Hale's MIT thesis for free).

### Discoverers — measurement and equipment

| Year | Discoverer | What was measured | Equipment used |
|---|---|---|---|
| 1660s | Hooke | Spring extension vs. weight | Spring, weights, ruler |
| 1687 | Newton | Pendulum motion, falling bodies | Pendulum clocks, inclined planes |
| 1750s | Coulomb | Friction force vs. normal load | Sled with pulley and weights; torsion balance |
| 1896 | Guillaume | Thermal expansion of Fe–Ni alloys | Fizeau dilatometer, Pt thermometer |
| 20th c. | Timoshenko, Den Hartog, Hale, Slocum | Mode shapes, damping, flexure stiffness | Shakers, accelerometers, strain gauges, interferometers |

## Important terms

| Term | Meaning |
|---|---|
| Force (F) / torque (τ) | The effort variable in translation / rotation. Units: N, N·m. |
| Velocity (v) / angular velocity (ω) | Flow variable in translation / rotation. |
| Displacement / angle | Integral of velocity. |
| Stiffness (k) | Force per unit displacement (Hooke's law). |
| Compliance | Inverse of stiffness. |
| Mass / moment of inertia (m, J) | Resistance to acceleration (linear / angular). |
| Damping (c) | Force per unit velocity. |
| Natural frequency (ωₙ) | √(k/m); frequency where the system wants to oscillate. |
| Damping ratio (ζ) | Describes decay vs. oscillation (underdamped, critically damped, overdamped). |
| Resonance | Peak response at ωₙ. |
| Backlash | Lost motion in gears/joints. |
| Hysteresis (mechanical) | Path-dependent force–displacement response. |
| Friction (static, Coulomb, viscous, Stribeck) | Resistance to sliding. |
| Stress / strain | Force per area / fractional deformation. |
| Young's modulus (E) | Material stiffness. |
| Fatigue | Crack growth under cyclic loading. |
| Flexure | Elastic hinge; zero-backlash motion element. |
| Kinematic constraint | Exactly constraining six DOFs; produces repeatable mounts. |

## What to read later

[Slocum](../course02/01-slocum-precision-machine-design/) · [Hale](../course02/02-hale-designing-precision-machines/) · [Ashby](../course02/03-ashby-materials-selection/) · [Gelbart's videos](../course02/09-gelbart-videos/)
