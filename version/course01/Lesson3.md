# Lesson 3 — Mechanical

[← Lesson 2 — Magnetic](Lesson2.md) · [All lessons](index.md#lessons) · [Lesson 4 — Fluidic →](Lesson4.md)

> Domain 3 of 7, in nine steps: start with something you can hold, get one mental model, build it, then learn what it's made of, how it's made, what trick unlocked it, and who got there first.

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

**Theory:** [Module 3](index.md#module-3--mechanical-domain) · **Stack:** [course03/03-mechanical](../course03/03-mechanical/README.md) · **Bench:** [course04/03-bench-mechanical](../course04/03-bench-mechanical.md) · **Pile:** [course05/03-mechanical](../course05/03-mechanical.md)

## 1. What you're looking at

*← start concrete*

A spring, a bearing, a bolt, a strain gauge. Also: your bench itself. Mechanical engineering is the one where the thing you build is also the thing you build on.

## 2. The one thing to understand

*← give the mental model*

Stuff bends. A little, under small load, in proportion to the load (Hooke). A lot, with hysteresis and crack growth, under big load. Most of mechanical design is staying in the first regime and designing the second regime out of existence.

## 3. What to build

*← hands on the bench*

1. Glue a strain gauge to an aluminum ruler. Clamp one end. Press the other. Watch the resistance change by a few milliohms per Newton.
2. Make a flexure out of a strip of spring steel cut with a nibbler. Move it with your finger. Notice there's no backlash, no stiction, no wear.
3. Build a kinematic mount from a plate with three divots, three balls, and a mating plate. Lift the top off. Put it back. Verify it returns to the same position within what you can measure.
4. Weigh a chunk of carbon fiber composite and a chunk of aluminum. Flex them. Carbon fiber feels like aluminum but weighs half. That's why satellites are made of it.

Full BOM and build steps: [course04 Bench 3](../course04/03-bench-mechanical.md).

## 4. Key materials

*← what it's made of*

- Steel for strength, aluminum for weight, titanium for both plus corrosion resistance.
- Spring steel (17-4 PH, 17-7 PH, beryllium copper) for springs and flexures.
- 52100 steel balls for bearings; ceramic (Si₃N₄) for premium bearings.
- Granite, Zerodur, Invar, fused silica when dimensional stability matters more than anything.
- Carbon fiber composites when stiffness-to-weight is king.

## 5. Key techniques

*← how it's made*

- **Waterjet** — cuts anything flat with no heat-affected zone. The single most useful tool for prototypes. If you only buy one machine, buy time on one.
- **Wire EDM** — spark-erodes hardened materials. The only way to make precise flexures from spring steel.
- **Grinding and lapping** — the mechanical world's lithography; sub-micron flatness.
- **Scraping** — hand-finishing of reference surfaces to <1 µm. Still done. Still unmatched.
- **Kinematic design** — six-point exact constraint. The rule: constrain each DOF exactly once, never twice.
- **Flexure design** — monolithic hinges. No bearings means no friction, no backlash, no lubrication.

## 6. The clever trick

*← what unlocked the industry*

**Flexures.** By making a hinge from a thin section of the same material as the body, you get zero backlash, zero stiction, zero wear, and perfect repeatability — in exchange for limited range. Any precision instrument more expensive than a car has flexures somewhere.

## 7. Who to know

*← short lineage of names*

Hooke (elasticity), Newton (motion), Coulomb (friction), Guillaume (Invar — made metrology possible), Slocum and Hale (modern precision machine design — read Hale's MIT thesis for free).

Year-by-year table of what each one measured and with which equipment: [course05 Pile 3](../course05/03-mechanical.md#discoverers--measurement-and-equipment).

## 8. The example everyone should work

*← optional — work it with pencil and paper*

A 100 g mass hanging from a 50 N/m spring, with 0.2 N·s/m of damping — the model behind every scale, accelerometer and motion stage:

1. Equation of motion: m·ẍ + c·ẋ + k·x = F(t).
2. Natural frequency: ωₙ = √(k/m) = √(50 / 0.1) = 22.4 rad/s, so fₙ = ωₙ / 2π = 3.56 Hz.
3. Damping ratio: ζ = c / (2√(k·m)) = 0.2 / (2√5) = 0.045.
4. Quality factor: Q = 1 / (2ζ) = 11.2.
5. Read it: ζ is far below 1, so the system is underdamped. Tap it and it rings at about 3.6 Hz for roughly Q ≈ 11 visible cycles before settling.
6. To make it settle without overshoot (critical damping, ζ = 1) you would need c = 2√(k·m) = 4.5 N·s/m — about 22× more damping.

One spring, one mass, one damper: the same three numbers (ωₙ, ζ, Q) describe a kitchen scale, a car suspension, a MEMS accelerometer and a precision stage.

More practice: the "Try it" exercises in [Module 3](index.md#module-3--mechanical-domain).

## 9. What to read later

*← optional — where to go deeper*

[Slocum](../course02/01-slocum-precision-machine-design/) · [Hale](../course02/02-hale-designing-precision-machines/) · [Ashby](../course02/03-ashby-materials-selection/) · [Gelbart's videos](../course02/09-gelbart-videos/)
