# Bench 3 — Mechanical

[← Course 04 index](index.md) · [← Bench 2](02-bench-magnetic.md) · [Bench 4 →](04-bench-fluidic.md)

**Course:** [course01 Module 3](../course01/index.md#module-3--mechanical-domain) · **Theory:** [course03/03-mechanical](../course03/03-mechanical/README.md) · **Shared tools:** [Universal Starter Kit](00-starter-kit.md)

## What's on it

Springs, bearings, strain gauges, a flexure cut from spring steel. The pile where "it bends a little" is a feature and "it bends a lot" is a problem.

## BOM structure

```
3  Bench 3 — Mechanical  ($149)
├── 3.1  Strain & force measurement  ($46)
│   ├── 3.1.1  Strain gauges (120 Ω foil, with leads)
│   ├── 3.1.2  Cyanoacrylate (CA) adhesive, strain-gauge grade
│   ├── 3.1.3  HX711 load-cell amplifier breakout
│   └── 3.1.4  Load cells (1 kg and 10 kg, bar type)
├── 3.2  Flexures & springs  ($20)
│   ├── 3.2.1  Spring steel strip (0.5 mm × 25 mm × 300 mm)
│   └── 3.2.2  Compression springs, assorted
├── 3.3  Bearings & kinematics  ($25)
│   ├── 3.3.1  Linear ball bearings (LM8UU)
│   ├── 3.3.2  Precision ground steel balls (6 mm)
│   └── 3.3.3  Hardened linear shafts (8 mm × 300 mm)
├── 3.4  Structure  ($25)
│   ├── 3.4.1  Aluminum extrusion (20×20, 500 mm)
│   └── 3.4.2  Carbon fiber tube (10 mm OD, 300 mm)
├── 3.5  Motion & displacement sensing  ($33)
│   ├── 3.5.1  MPU6050 breakout (accelerometer + gyro)
│   └── 3.5.2  Dial indicator (0.01 mm, 10 mm travel) + magnetic base
└── 3.6  Teardown targets (free)  ($0)
    ├── 3.6.1  Kitchen scale
    ├── 3.6.2  Dead printer
    ├── 3.6.3  Old hard-drive head stack
    └── 3.6.4  Any watch
```

## Multilevel BOM

| Level | Item | Description | Qty | Cost (USD) | Notes |
|---|---|---|---|---|---|
| **0** | **3** | **Bench 3 — Mechanical** | 1 | **149** | |
| **1** | **3.1** | **Strain & force measurement** | — | **46** | |
| 2 | 3.1.1 | Strain gauges (120 Ω foil, with leads) | 10 | 15 | Standard quarter-bridge |
| 2 | 3.1.2 | Cyanoacrylate (CA) adhesive, strain-gauge grade | 1 | 10 | Loctite 496 or equivalent |
| 2 | 3.1.3 | HX711 load-cell amplifier breakout | 2 | 6 | 24-bit ADC, Arduino-friendly |
| 2 | 3.1.4 | Load cells (1 kg and 10 kg, bar type) | 1 each | 15 | Pre-wired with strain gauges — a free teardown |
| **1** | **3.2** | **Flexures & springs** | — | **20** | |
| 2 | 3.2.1 | Spring steel strip (0.5 mm × 25 mm × 300 mm) | 1 | 10 | For hand-cut flexures |
| 2 | 3.2.2 | Compression springs, assorted | 20 | 10 |  |
| **1** | **3.3** | **Bearings & kinematics** | — | **25** | |
| 2 | 3.3.1 | Linear ball bearings (LM8UU) | 10 | 10 | 8 × 15 × 24 mm recirculating-ball bushing, double-sealed. Material: AISI 52100 bearing steel (GCr15 · 100Cr6 / 1.3505 · SUJ2). Runs on an 8 mm hardened shaft. See [3.3.1 types](#331-linear-ball-bearing-types) |
| 2 | 3.3.2 | Precision ground steel balls (6 mm) | 10 | 5 | For kinematic mounts |
| 2 | 3.3.3 | Hardened linear shafts (8 mm × 300 mm) | 2 | 10 | The running surface for the `3.3.1` LM8UU bearings — the balls roll directly on the shaft, so it must be harder than they are. Induction-hardened to about HRC 60 and hard-chrome plated, ground to h6 tolerance. Material: GCr15 bearing steel or AISI 1045 (C45) carbon steel. Cut to length, or buy 3D-printer rod pairs |
| **1** | **3.4** | **Structure** | — | **25** | |
| 2 | 3.4.1 | Aluminum extrusion (20×20, 500 mm) | 2 | 10 | For benchtop structures |
| 2 | 3.4.2 | Carbon fiber tube (10 mm OD, 300 mm) | 1 | 15 | Feel the stiffness-to-weight |
| **1** | **3.5** | **Motion & displacement sensing** | — | **33** | |
| 2 | 3.5.1 | MPU6050 breakout (accelerometer + gyro) | 2 | 8 | Measure your own motion |
| 2 | 3.5.2 | Dial indicator (0.01 mm, 10 mm travel) + magnetic base | 1 | 25 | A fixed, spring-loaded gauge for repeatability tests — calipers can't be held still enough |
| **1** | **3.6** | **Teardown targets (free)** | — | **0** | |
| 2 | 3.6.1 | Kitchen scale | 1 | 0 | → strain-gauge bridge + ADC. |
| 2 | 3.6.2 | Dead printer | 1 | 0 | → linear rails, lead screws, flexure-mounted print heads. |
| 2 | 3.6.3 | Old hard-drive head stack | 1 | 0 | → ultra-precision flexure assembly. |
| 2 | 3.6.4 | Any watch | 1 | 0 | → gears, bearings, hairspring (the perfect flexure). |

**Bench 3 — Mechanical total: $149** for components (reuse the starter tools) — the course states ~$115.

## 3.3.1 Linear ball bearing types

A linear ball bearing lets a part **slide** along a shaft or rail; balls recirculate in tracks inside the housing. It is not the same thing as a radial ball bearing (such as a 608ZZ skate bearing), which lets a shaft **spin**.

### Code key

`LM` + type letter + shaft diameter in mm + options. Example: **LM8UU** = linear motion, 8 mm shaft, sealed both ends.

| Code part | Meaning |
|---|---|
| `LM` | Linear motion ball bushing (metric) |
| `F` / `K` / `H` after `LM` | Round flange / square flange / cut (oval) flange |
| Number | Shaft diameter in mm (8 → 8 mm) |
| `L` before `UU` | Long body — about double length, two ball circuits |
| `UU` | Rubber seals at both ends |
| `-OP` | Open type — a slot along the body clears the supports of a supported shaft |
| `-AJ` | Adjustable type — a slit body lets you set clearance or preload |
| `SC…UU` | Bearing already mounted in an aluminium housing block |

### Types

| Level | Item | Type | Code (8 mm shaft) | Size d × D × L (mm) | Use |
|---|---|---|---|---|---|
| 3 | 3.3.1.1 | Standard closed bushing | **LM8UU** ← BOM choice | 8 × 15 × 24 | General purpose; the common 3D-printer bearing |
| 3 | 3.3.1.2 | Long closed bushing | LM8LUU | 8 × 15 × 45 | Higher moment load, less tilt; replaces two LM8UU |
| 3 | 3.3.1.3 | Round flange | LMF8UU | 8 × 15 × 24 body | Bolts flat to a plate |
| 3 | 3.3.1.4 | Square flange | LMK8UU | 8 × 15 × 24 body | Bolts flat to a plate; square bolt pattern |
| 3 | 3.3.1.5 | Cut (oval) flange | LMH8UU | 8 × 15 × 24 body | Flange mounting where space is tight |
| 3 | 3.3.1.6 | Housed unit | SC8UU (SCS8UU) | LM8UU in an aluminium block | Screw straight onto a carriage plate |
| 3 | 3.3.1.7 | Open type | LM◻UU-OP | Larger shaft sizes | Long travel on a supported (continuously mounted) shaft |
| 3 | 3.3.1.8 | Adjustable type | LM◻UU-AJ | Same as closed | Remove play by squeezing the housing bore |
| 3 | 3.3.1.9 | Profile-rail carriage | MGN12H on MGN12 rail | 12 mm miniature rail | Stiffer and more accurate than round shafts; needs a flat mounting surface |

All of these are made from the same bearing steel: **AISI 52100** (US), **GCr15** (China), **100Cr6 / 1.3505** (EU), **SUJ2** (Japan). Cheap versions usually have a plastic (POM) ball retainer; better ones use steel.

**For this bench:** LM8UU is the one to buy, with two 8 mm hardened shafts (`3.3.3`). Pull one apart to see the ball circuits — a free lesson in recirculation.

## Four builds

### Build 1 — Strain-gauge cantilever

Glue a gauge to an aluminum ruler, clamp one end, press the other, read the HX711 on an Arduino.

| Uses | |
|---|---|
| This bench | `3.1.1` Strain gauges · `3.1.2` Cyanoacrylate · `3.1.3` HX711 load-cell amplifier breakout |
| Starter kit | `S.5.4` [Arduino Uno or Raspberry Pi Pico](00-starter-kit.md) · `S.2.2` [Jumper wire kit](00-starter-kit.md) · `S.3.7` [Small bench vise or two 100 mm C-clamps](00-starter-kit.md) |
| Not in any BOM | Aluminum ruler |

### Build 2 — Monolithic flexure

Nibble or hacksaw a parallel-blade flexure from spring steel. Verify no backlash by hand.

| Uses | |
|---|---|
| This bench | `3.2.1` Spring steel strip |
| Starter kit | `S.1.2` [Digital calipers](00-starter-kit.md) · `S.3.8` [Mini hacksaw + metal-cutting blades](00-starter-kit.md) |

### Build 3 — Kinematic mount

Three divots, three balls. Lift and replace. Measure return position with a dial indicator (or a laser pointer bouncing off).

| Uses | |
|---|---|
| This bench | `3.3.2` Precision ground steel balls · `3.5.2` Dial indicator + magnetic base |
| Other benches | `7.1.1` [Laser pointers](07-bench-radiant.md) |
| Not in any BOM | Plate with three divots |

### Build 4 — Linear-bearing slide

Mount two hardened shafts parallel on the aluminum extrusion and run a small plate on four LM8UU bearings. Set the dial indicator against the plate and push it along: the needle shows how straight the slide runs, and rocking the plate shows the play in the bearings. Tape the accelerometer to the plate and log its tilt as it travels.

| Uses | |
|---|---|
| This bench | `3.3.1` Linear ball bearings · `3.3.3` Hardened linear shafts · `3.4.1` Aluminum extrusion · `3.5.2` Dial indicator + magnetic base · `3.5.1` MPU6050 breakout |
| Starter kit | `S.5.4` [Arduino Uno or Raspberry Pi Pico](00-starter-kit.md) · `S.2.2` [Jumper wire kit](00-starter-kit.md) · `S.3.5` [Hex key set](00-starter-kit.md) |
| Not in any BOM | Shaft end supports · Carriage plate · M5 screws and T-nuts |

## Measurement wins

- You can wire a Wheatstone bridge from memory.
- You know what "exact constraint" means and can draw a six-point kinematic mount.
