# Bench 5 — Thermal

[← Course 04 index](index.md) · [← Bench 4](04-bench-fluidic.md) · [Bench 6 →](06-bench-chemical.md)

**Course:** [course01 Module 5](../course01/index.md#module-5--thermal-domain) · **Theory:** [course03/05-thermal](../course03/05-thermal/README.md) · **Shared tools:** [Universal Starter Kit](00-starter-kit.md)

## What's on it

Thermocouples, RTDs, a Peltier module, Nitinol wire, a bimetal strip. The pile where everything is slow.

## BOM structure

```
5  Bench 5 — Thermal  ($146)
├── 5.1  Thermocouples  ($23)
│   ├── 5.1.1  Thermocouple wire (Type K, chromel-alumel, 10 m each)
│   └── 5.1.2  MAX6675 or MAX31855 breakout (Type K reader)
├── 5.2  Resistive temperature sensors  ($25)
│   ├── 5.2.1  RTD (Pt100, 2-wire + Pt1000, surface-mount)
│   ├── 5.2.2  MAX31865 breakout (RTD reader)
│   └── 5.2.3  NTC thermistor assortment (10 kΩ @ 25 °C, bead)
├── 5.3  Thermoelectric stack  ($23)
│   ├── 5.3.1  Peltier module (TEC1-12706, 40×40 mm)
│   ├── 5.3.2  CPU heatsink + fan (for Peltier hot side)
│   └── 5.3.3  Thermal paste (1 g syringe)
├── 5.4  Thermal actuators  ($20)
│   ├── 5.4.1  Nitinol wire (0.5 mm, 1 m, body-temperature actuation)
│   └── 5.4.2  Bimetal strip (or snap-disc thermostat)
├── 5.5  Reference & heat sources  ($55)
│   ├── 5.5.1  IR non-contact thermometer
│   ├── 5.5.2  Candle, matches
│   ├── 5.5.3  Nichrome wire (Ni80Cr20, 0.3 mm, 5 m)
│   └── 5.5.4  Propane torch (hand-held)
└── 5.6  Teardown targets (free)  ($0)
    ├── 5.6.1  Old mercury thermostat
    ├── 5.6.2  USB mini-fridge
    ├── 5.6.3  Hairdryer
    └── 5.6.4  Old iron
```

## Multilevel BOM

| Level | Item | Description | Qty | Cost (USD) | Notes |
|---|---|---|---|---|---|
| **0** | **5** | **Bench 5 — Thermal** | 1 | **146** | |
| **1** | **5.1** | **Thermocouples** | — | **23** | |
| 2 | 5.1.1 | Thermocouple wire (Type K, chromel-alumel, 10 m each) | 1 | 15 | Make your own junctions |
| 2 | 5.1.2 | MAX6675 or MAX31855 breakout (Type K reader) | 2 | 8 | SPI output |
| **1** | **5.2** | **Resistive temperature sensors** | — | **25** | |
| 2 | 5.2.1 | RTD (Pt100, 2-wire + Pt1000, surface-mount) | 2 each | 10 |  |
| 2 | 5.2.2 | MAX31865 breakout (RTD reader) | 1 | 10 |  |
| 2 | 5.2.3 | NTC thermistor assortment (10 kΩ @ 25 °C, bead) | 10 | 5 |  |
| **1** | **5.3** | **Thermoelectric stack** | — | **23** | |
| 2 | 5.3.1 | Peltier module (TEC1-12706, 40×40 mm) | 2 | 10 | 60 W each |
| 2 | 5.3.2 | CPU heatsink + fan (for Peltier hot side) | 1 | 10 |  |
| 2 | 5.3.3 | Thermal paste (1 g syringe) | 1 | 3 |  |
| **1** | **5.4** | **Thermal actuators** | — | **20** | |
| 2 | 5.4.1 | Nitinol wire (0.5 mm, 1 m, body-temperature actuation) | 1 | 15 | Shape-settable |
| 2 | 5.4.2 | Bimetal strip (or snap-disc thermostat) | 2 | 5 |  |
| **1** | **5.5** | **Reference & heat sources** | — | **55** | |
| 2 | 5.5.1 | IR non-contact thermometer | 1 | 20 | Verify your thermocouple readings |
| 2 | 5.5.2 | Candle, matches | — | 5 | Cheap variable heat source |
| 2 | 5.5.3 | Nichrome wire (Ni80Cr20, 0.3 mm, 5 m) | 1 | 5 | About 15 Ω/m — cut a length to make a resistive heater of the resistance you need (Elec → Therm) |
| 2 | 5.5.4 | Propane torch (hand-held) | 1 | 25 | Welds the B5.1 thermocouple, shape-sets the B5.3 Nitinol. Safety glasses; work over a non-flammable surface |
| **1** | **5.6** | **Teardown targets (free)** | — | **0** | |
| 2 | 5.6.1 | Old mercury thermostat | 1 | 0 | → bimetal coil, mercury switch (now illegal but you may still have one). |
| 2 | 5.6.2 | USB mini-fridge | 1 | 0 | → Peltier module + heatsink stack. |
| 2 | 5.6.3 | Hairdryer | 1 | 0 | → nichrome heater coil + bimetal cutoff. |
| 2 | 5.6.4 | Old iron | 1 | 0 | → thermostat with bimetal + adjustment screw. |

**Bench 5 — Thermal total: $146** for components (reuse the starter tools) — the course states ~$115.

## Three builds

### Build 1 — DIY Type K thermocouple

Twist-weld chromel and alumel with a propane torch. Compare to IR thermometer.

| Uses | |
|---|---|
| This bench | `5.1.1` Thermocouple wire · `5.1.2` MAX6675 or MAX31855 breakout · `5.5.1` IR non-contact thermometer · `5.5.4` Propane torch |
| Starter kit | `S.5.4` [Arduino Uno or Raspberry Pi Pico](00-starter-kit.md) |

### Build 2 — Peltier swap

Hook to a battery, feel cold/hot. Flip polarity, sides swap.

| Uses | |
|---|---|
| This bench | `5.3.1` Peltier module · `5.3.2` CPU heatsink + fan · `5.3.3` Thermal paste |
| Other benches | `1.3.1` [9 V battery + clip, 4×AA holder](01-bench-electrical.md) |

### Build 3 — Nitinol spring

Wrap wire around a pencil, hold with pliers in a torch flame to shape-set at ~500 °C. Deform cold, drop in hot water, watch it spring back.

| Uses | |
|---|---|
| This bench | `5.4.1` Nitinol wire · `5.5.4` Propane torch |
| Starter kit | `S.3.3` [Flush cutters, needle-nose pliers](00-starter-kit.md) |
| Not in any BOM | Pencil · Hot water |

## Measurement wins

- You can estimate a thermal time constant from mass and surface area.
- You know why thermal systems set bandwidth in a sensor + actuator chain.
