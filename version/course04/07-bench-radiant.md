# Bench 7 — Radiant

[← Course 04 index](index.md) · [← Bench 6](06-bench-chemical.md) · [Course 04 index →](index.md)

**Course:** [course01 Module 7](../course01/index.md#module-7--radiant-domain) · **Theory:** [course03/07-radiant](../course03/07-radiant/README.md) · **Shared tools:** [Universal Starter Kit](00-starter-kit.md)

## What's on it

LEDs, photodiodes, a laser pointer, lenses, a CCD out of an old camera. The pile that scales from quantum effects to everyday light.

## BOM structure

```
7  Bench 7 — Radiant  ($100)
├── 7.1  Light sources  ($20)
│   ├── 7.1.1  Laser pointers (red, green)
│   └── 7.1.2  LEDs (red, green, blue, white, IR 940 nm, UV 395 nm)
├── 7.2  Discrete detectors  ($10)
│   ├── 7.2.1  Photodiodes (BPW34 silicon, 300–1100 nm)
│   └── 7.2.2  Phototransistors (TEMT6000 ambient-light)
├── 7.3  Sensor breakouts  ($28)
│   ├── 7.3.1  TSL2591 or VEML7700 breakout (light sensor)
│   ├── 7.3.2  TCS34725 breakout (color sensor)
│   └── 7.3.3  ToF distance sensor (VL53L0X or VL53L1X)
├── 7.4  Optics  ($30)
│   ├── 7.4.1  Diffraction grating sheet (1000 lines/mm)
│   ├── 7.4.2  Lenses (biconvex 25 mm f/50; plano-convex 25 mm f/100)
│   ├── 7.4.3  Front-surface mirror (50×50 mm)
│   └── 7.4.4  Polarizing film (sheet)
├── 7.5  Consumables & teardown stock  ($12)
│   ├── 7.5.1  Index cards, foil, pins
│   └── 7.5.2  Fiber-optic patch cable (any FC/PC multimode)
└── 7.6  Teardown targets (free)  ($0)
    ├── 7.6.1  Old digital camera
    ├── 7.6.2  Blu-ray drive
    ├── 7.6.3  TV remote
    ├── 7.6.4  Dead smartphone
    └── 7.6.5  Broken fluorescent tube (handle carefully — contains merc...
```

## Multilevel BOM

| Level | Item | Description | Qty | Cost (USD) | Notes |
|---|---|---|---|---|---|
| **0** | **7** | **Bench 7 — Radiant** | 1 | **100** | |
| **1** | **7.1** | **Light sources** | — | **20** | |
| 2 | 7.1.1 | Laser pointers (red, green) | 1 each | 10 | <5 mW; eye-safe class II |
| 2 | 7.1.2 | LEDs (red, green, blue, white, IR 940 nm, UV 395 nm) | 10 each | 10 | Measure threshold voltages |
| **1** | **7.2** | **Discrete detectors** | — | **10** | |
| 2 | 7.2.1 | Photodiodes (BPW34 silicon, 300–1100 nm) | 5 | 5 |  |
| 2 | 7.2.2 | Phototransistors (TEMT6000 ambient-light) | 3 | 5 |  |
| **1** | **7.3** | **Sensor breakouts** | — | **28** | |
| 2 | 7.3.1 | TSL2591 or VEML7700 breakout (light sensor) | 1 | 10 | Calibrated lux readings |
| 2 | 7.3.2 | TCS34725 breakout (color sensor) | 1 | 8 | RGB + clear |
| 2 | 7.3.3 | ToF distance sensor (VL53L0X or VL53L1X) | 2 | 10 | Lidar in miniature |
| **1** | **7.4** | **Optics** | — | **30** | |
| 2 | 7.4.1 | Diffraction grating sheet (1000 lines/mm) | 1 | 5 |  |
| 2 | 7.4.2 | Lenses (biconvex 25 mm f/50; plano-convex 25 mm f/100) | 2 each | 10 | For hand optics bench |
| 2 | 7.4.3 | Front-surface mirror (50×50 mm) | 2 | 10 |  |
| 2 | 7.4.4 | Polarizing film (sheet) | 1 | 5 |  |
| **1** | **7.5** | **Consumables & teardown stock** | — | **12** | |
| 2 | 7.5.1 | Index cards, foil, pins | — | 2 | Hand-cut slits for Young's experiment |
| 2 | 7.5.2 | Fiber-optic patch cable (any FC/PC multimode) | 1 | 10 | Teardown target |
| **1** | **7.6** | **Teardown targets (free)** | — | **0** | |
| 2 | 7.6.1 | Old digital camera | 1 | 0 | → CCD or CMOS imager + optical stack. |
| 2 | 7.6.2 | Blu-ray drive | 1 | 0 | → GaN laser diode, pickup head optics. |
| 2 | 7.6.3 | TV remote | 1 | 0 | → IR LED (point your phone camera at it, you'll see the invisible blink). |
| 2 | 7.6.4 | Dead smartphone | 1 | 0 | → tiny lenses, image sensor, maybe a VCSEL for FaceID. |
| 2 | 7.6.5 | Broken fluorescent tube (**handle carefully — contains mercury**) | 1 | 0 | → phosphor coating. |

**Bench 7 — Radiant total: $100** for components (reuse the starter tools) — the course states ~$100.

## Three builds

### Build 1 — Young's double-slit

Foil, pin, laser pointer. Project fringes on a wall across the room.

| Uses | |
|---|---|
| This bench | `7.1.1` Laser pointers · `7.5.1` Index cards, foil, pins |

### Build 2 — Photodiode darkroom

BPW34 into an op-amp transimpedance amp. Measure your room's ambient light in nanoamps.

| Uses | |
|---|---|
| This bench | `7.2.1` Photodiodes |
| Other benches | `1.2.3` [Op-amps](01-bench-electrical.md) · `1.1.1` [Resistor assortment](01-bench-electrical.md) · `1.3.1` [9 V battery + clip, 4×AA holder](01-bench-electrical.md) |
| Starter kit | `S.2.1` [Breadboard, solderless](00-starter-kit.md) · `S.1.1` [Digital multimeter](00-starter-kit.md) |

### Build 3 — Grating spectrometer

Slit, grating, screen. Compare an incandescent bulb's spectrum to a fluorescent tube's and an LED's.

| Uses | |
|---|---|
| This bench | `7.4.1` Diffraction grating sheet · `7.5.1` Index cards, foil, pins · `7.4.2` Lenses |
| Not in any BOM | Screen · Incandescent bulb · Fluorescent tube |

## Measurement wins

- You can compute photon energy for a wavelength and match it to a detector.
- You can set up and read a Michelson interferometer conceptually.
