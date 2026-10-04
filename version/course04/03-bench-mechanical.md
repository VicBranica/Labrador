# Bench 3 — Mechanical

[← Course 04 index](index.md) · [← Bench 2](02-bench-magnetic.md) · [Bench 4 →](04-bench-fluidic.md)

**Theory:** [course03/03-mechanical](../course03/03-mechanical/README.md) · **Shared tools:** [Universal Starter Kit](00-starter-kit.md)

## What's on it

Springs, bearings, strain gauges, a flexure cut from spring steel. The pile where "it bends a little" is a feature and "it bends a lot" is a problem.

## BOM structure

```
3  Bench 3 — Mechanical  ($114)
├── 3.1  Strain & force measurement  ($46)
│   ├── 3.1.1  Strain gauges (120 Ω foil, with leads)
│   ├── 3.1.2  Cyanoacrylate (CA) adhesive, strain-gauge grade
│   ├── 3.1.3  HX711 load-cell amplifier breakout
│   └── 3.1.4  Load cells (1 kg and 10 kg, bar type)
├── 3.2  Flexures & springs  ($20)
│   ├── 3.2.1  Spring steel strip (0.5 mm × 25 mm × 300 mm)
│   └── 3.2.2  Compression springs, assorted
├── 3.3  Bearings & kinematics  ($15)
│   ├── 3.3.1  Linear ball bearings (608ZZ skate bearings)
│   └── 3.3.2  Precision ground steel balls (6 mm)
├── 3.4  Structure  ($25)
│   ├── 3.4.1  Aluminum extrusion (20×20, 500 mm)
│   └── 3.4.2  Carbon fiber tube (10 mm OD, 300 mm)
├── 3.5  Motion sensing  ($8)
│   └── 3.5.1  MPU6050 breakout (accelerometer + gyro)
└── 3.6  Teardown targets (free)  ($0)
    ├── 3.6.1  Kitchen scale
    ├── 3.6.2  Dead printer
    ├── 3.6.3  Old hard-drive head stack
    └── 3.6.4  Any watch
```

## Multilevel BOM

| Level | Item | Description | Qty | Cost (USD) | Notes |
|---|---|---|---|---|---|
| **0** | **3** | **Bench 3 — Mechanical** | 1 | **114** | |
| **1** | **3.1** | **Strain & force measurement** | — | **46** | |
| 2 | 3.1.1 | Strain gauges (120 Ω foil, with leads) | 10 | 15 | Standard quarter-bridge |
| 2 | 3.1.2 | Cyanoacrylate (CA) adhesive, strain-gauge grade | 1 | 10 | Loctite 496 or equivalent |
| 2 | 3.1.3 | HX711 load-cell amplifier breakout | 2 | 6 | 24-bit ADC, Arduino-friendly |
| 2 | 3.1.4 | Load cells (1 kg and 10 kg, bar type) | 1 each | 15 | Pre-wired with strain gauges — a free teardown |
| **1** | **3.2** | **Flexures & springs** | — | **20** | |
| 2 | 3.2.1 | Spring steel strip (0.5 mm × 25 mm × 300 mm) | 1 | 10 | For hand-cut flexures |
| 2 | 3.2.2 | Compression springs, assorted | 20 | 10 |  |
| **1** | **3.3** | **Bearings & kinematics** | — | **15** | |
| 2 | 3.3.1 | Linear ball bearings (608ZZ skate bearings) | 10 | 10 | Universal precision bearing |
| 2 | 3.3.2 | Precision ground steel balls (6 mm) | 10 | 5 | For kinematic mounts |
| **1** | **3.4** | **Structure** | — | **25** | |
| 2 | 3.4.1 | Aluminum extrusion (20×20, 500 mm) | 2 | 10 | For benchtop structures |
| 2 | 3.4.2 | Carbon fiber tube (10 mm OD, 300 mm) | 1 | 15 | Feel the stiffness-to-weight |
| **1** | **3.5** | **Motion sensing** | — | **8** | |
| 2 | 3.5.1 | MPU6050 breakout (accelerometer + gyro) | 2 | 8 | Measure your own motion |
| **1** | **3.6** | **Teardown targets (free)** | — | **0** | |
| 2 | 3.6.1 | Kitchen scale | 1 | 0 | → strain-gauge bridge + ADC. |
| 2 | 3.6.2 | Dead printer | 1 | 0 | → linear rails, lead screws, flexure-mounted print heads. |
| 2 | 3.6.3 | Old hard-drive head stack | 1 | 0 | → ultra-precision flexure assembly. |
| 2 | 3.6.4 | Any watch | 1 | 0 | → gears, bearings, hairspring (the perfect flexure). |

**Bench 3 — Mechanical total: $114** for components (reuse the starter tools) — the course states ~$115.

## Three builds

### Build 1 — Strain-gauge cantilever

Glue a gauge to an aluminum ruler, clamp one end, press the other, read the HX711 on an Arduino.

| Uses | |
|---|---|
| This bench | `3.1.1` Strain gauges · `3.1.2` Cyanoacrylate · `3.1.3` HX711 load-cell amplifier breakout |
| Starter kit | `S.5.4` [Arduino Uno or Raspberry Pi Pico](00-starter-kit.md) · `S.2.2` [Jumper wire kit](00-starter-kit.md) |
| Not in any BOM | Aluminum ruler · Clamp |

### Build 2 — Monolithic flexure

Nibble or hacksaw a parallel-blade flexure from spring steel. Verify no backlash by hand.

| Uses | |
|---|---|
| This bench | `3.2.1` Spring steel strip |
| Starter kit | `S.1.2` [Digital calipers](00-starter-kit.md) |
| Not in any BOM | Nibbler or hacksaw |

### Build 3 — Kinematic mount

Three divots, three balls. Lift and replace. Measure return position with a dial indicator (or a laser pointer bouncing off).

| Uses | |
|---|---|
| This bench | `3.3.2` Precision ground steel balls |
| Other benches | `7.1.1` [Laser pointers](07-bench-radiant.md) |
| Not in any BOM | Plate with three divots · Dial indicator (optional) |

## Measurement wins

- You can wire a Wheatstone bridge from memory.
- You know what "exact constraint" means and can draw a six-point kinematic mount.
