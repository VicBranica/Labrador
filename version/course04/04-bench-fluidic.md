# Bench 4 — Fluidic

[← Course 04 index](index.md) · [← Bench 3](03-bench-mechanical.md) · [Bench 5 →](05-bench-thermal.md)

**Course:** [course01 Module 4](../course01/index.md#module-4--fluidic-domain) · **Theory:** [course03/04-fluidic](../course03/04-fluidic/README.md) · **Shared tools:** [Universal Starter Kit](00-starter-kit.md)

## What's on it

Syringes, tubes, pressure gauges, a hand pump. Hydraulic and pneumatic principles, kitchen-table scale.

## BOM structure

```
4  Bench 4 — Fluidic  ($129)
├── 4.1  Fluid handling  ($26)
│   ├── 4.1.1  Syringes (10 mL, 60 mL, no needle)
│   ├── 4.1.2  Silicone tubing (3 mm ID, 5 m)
│   └── 4.1.3  Luer-lock fittings assortment
├── 4.2  Pressure sources  ($40)
│   ├── 4.2.1  Hand vacuum pump (brake-bleeder type)
│   └── 4.2.2  Bicycle pump with gauge
├── 4.3  Pressure & flow sensing  ($28)
│   ├── 4.3.1  Pressure sensors (BMP280 breakout, 0–110 kPa absolute)
│   ├── 4.3.2  Differential pressure sensor (MPX5010DP)
│   └── 4.3.3  Turbine flow sensor (Hall-effect, 0.3–6 L/min)
├── 4.4  Actuators, pumps & valves  ($33)
│   ├── 4.4.1  Pneumatic cylinder (small, 10 mm bore, 25 mm stroke)
│   ├── 4.4.2  Micro peristaltic pump (12 V DC)
│   └── 4.4.3  Solenoid valve (12 V DC, normally closed)
├── 4.5  Consumables  ($2)
│   └── 4.5.1  Food coloring
└── 4.6  Teardown targets (free)  ($0)
    ├── 4.6.1  A broken coffee machine
    ├── 4.6.2  Old sphygmomanometer
    └── 4.6.3  Dead pneumatic nail gun (if you can scrounge one)
```

## Multilevel BOM

| Level | Item | Description | Qty | Cost (USD) | Notes |
|---|---|---|---|---|---|
| **0** | **4** | **Bench 4 — Fluidic** | 1 | **129** | |
| **1** | **4.1** | **Fluid handling** | — | **26** | |
| 2 | 4.1.1 | Syringes (10 mL, 60 mL, no needle) | 5 each | 8 | Clear plastic, Luer-lock preferred |
| 2 | 4.1.2 | Silicone tubing (3 mm ID, 5 m) | 1 | 8 |  |
| 2 | 4.1.3 | Luer-lock fittings assortment | 1 kit | 10 | Tees, barbs, valves |
| **1** | **4.2** | **Pressure sources** | — | **40** | |
| 2 | 4.2.1 | Hand vacuum pump (brake-bleeder type) | 1 | 25 | Pulls to ~−25 inHg |
| 2 | 4.2.2 | Bicycle pump with gauge | 1 | 15 | Positive-pressure side |
| **1** | **4.3** | **Pressure & flow sensing** | — | **28** | |
| 2 | 4.3.1 | Pressure sensors (BMP280 breakout, 0–110 kPa absolute) | 2 | 5 | Also measures altitude |
| 2 | 4.3.2 | Differential pressure sensor (MPX5010DP) | 1 | 15 | For flow calculations |
| 2 | 4.3.3 | Turbine flow sensor (Hall-effect, 0.3–6 L/min) | 1 | 8 | Measures flow Q directly — the fluidic flow variable. Pulse output; read with the Arduino. Barb adapters to the `4.1.2` tubing |
| **1** | **4.4** | **Actuators, pumps & valves** | — | **33** | |
| 2 | 4.4.1 | Pneumatic cylinder (small, 10 mm bore, 25 mm stroke) | 1 | 10 | 1/8" NPT fittings |
| 2 | 4.4.2 | Micro peristaltic pump (12 V DC) | 1 | 15 | Dose-pumping, no cross-contamination |
| 2 | 4.4.3 | Solenoid valve (12 V DC, normally closed) | 1 | 8 | Elec → Fluid on/off control; switch it with a `1.2.5` MOSFET and a flyback diode. Buy a direct-acting (zero-pressure) type: pilot-operated valves need line pressure to open |
| **1** | **4.5** | **Consumables** | — | **2** | |
| 2 | 4.5.1 | Food coloring | 1 bottle | 2 | For Reynolds-number visualization |
| **1** | **4.6** | **Teardown targets (free)** | — | **0** | |
| 2 | 4.6.1 | A broken coffee machine | 1 | 0 | → peristaltic pump + solenoid valve + pressure switch. |
| 2 | 4.6.2 | Old sphygmomanometer | 1 | 0 | → aneroid pressure gauge mechanism. |
| 2 | 4.6.3 | Dead pneumatic nail gun (if you can scrounge one) | 1 | 0 | → piston, O-rings, trigger valve. |

**Bench 4 — Fluidic total: $129** for components (reuse the starter tools) — the course states ~$115.

## Four builds

### Build 1 — Syringe hydraulics

Connect two syringes with tubing. Fill with water (no air). Verify force multiplication.

| Uses | |
|---|---|
| This bench | `4.1.1` Syringes · `4.1.2` Silicone tubing · `4.1.3` Luer-lock fittings assortment |
| Starter kit | `S.1.3` [Kitchen scale](00-starter-kit.md) |
| Not in any BOM | Water |

### Build 2 — Reynolds-number demo

Slowly inject dye into clear tube flow. Watch transition from laminar to turbulent.

| Uses | |
|---|---|
| This bench | `4.5.1` Food coloring · `4.1.1` Syringes |
| Not in any BOM | Clear tube with steady water flow |

### Build 3 — Pressure-logger

BMP280 + Arduino + laptop. Log pressure for a day; see your weather on a graph.

| Uses | |
|---|---|
| This bench | `4.3.1` Pressure sensors |
| Starter kit | `S.5.4` [Arduino Uno or Raspberry Pi Pico](00-starter-kit.md) · `S.2.2` [Jumper wire kit](00-starter-kit.md) |
| Not in any BOM | Laptop |

### Build 4 — Gravity-fed flow loop

Raise a bucket of water about 1 m above a second one and siphon it down through the tubing, the solenoid valve and the flow sensor. Open the valve from the Arduino through a MOSFET, count the flow sensor's pulses to get Q, and read the pressure drop across a length of tubing with the differential sensor. ΔP / Q is the tube's hydraulic resistance — Ohm's law in the fluidic domain. Change the tube length and measure again. If the flow sensor reads nothing, raise the bucket.

| Uses | |
|---|---|
| This bench | `4.1.2` Silicone tubing · `4.1.3` Luer-lock fittings assortment · `4.3.2` Differential pressure sensor · `4.3.3` Turbine flow sensor · `4.4.3` Solenoid valve |
| Other benches | `1.2.5` [MOSFETs](01-bench-electrical.md) · `1.2.2` [Diodes](01-bench-electrical.md) |
| Starter kit | `S.5.4` [Arduino Uno or Raspberry Pi Pico](00-starter-kit.md) · `S.5.2` [Benchtop DC power supply](00-starter-kit.md) · `S.2.2` [Jumper wire kit](00-starter-kit.md) |
| Not in any BOM | Two buckets · Water |

## Measurement wins

- You feel the difference between compressible and incompressible media.
- You can predict a hydraulic lift's force from piston area and input pressure.
