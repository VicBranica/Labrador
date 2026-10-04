# Bench 1 — Electrical

[← Course 04 index](index.md) · [← Starter kit](00-starter-kit.md) · [Bench 2 →](02-bench-magnetic.md)

**Theory:** [course03/01-electrical](../course03/01-electrical/README.md) · **Shared tools:** [Universal Starter Kit](00-starter-kit.md)

## What's on it

Resistors, capacitors, inductors, diodes, LEDs, op-amps, transistors, a battery, a motor driver. The vocabulary of signals and power.

## BOM structure

```
1  Bench 1 — Electrical  ($101)
├── 1.1  Passive components  ($38)
│   ├── 1.1.1  Resistor assortment (1/4 W, 1% metal film, 10 Ω to 10 MΩ)
│   ├── 1.1.2  Capacitor assortment (ceramic 10 pF–1 µF, electrolytic 1–...
│   └── 1.1.3  Potentiometers (10 kΩ linear, 100 kΩ log)
├── 1.2  Semiconductors  ($38)
│   ├── 1.2.1  LED assortment (red, green, blue, white, 3 mm & 5 mm)
│   ├── 1.2.2  Diodes (1N4148, 1N4007, 1N5819)
│   ├── 1.2.3  Op-amps (LM358, TL072, MCP6002)
│   ├── 1.2.4  NPN/PNP transistors (2N3904, 2N3906, BC547)
│   └── 1.2.5  MOSFETs (IRLZ44N logic-level, 2N7000)
├── 1.3  Power  ($10)
│   └── 1.3.1  9 V battery + clip, 4×AA holder
├── 1.4  Interface & prototyping  ($15)
│   ├── 1.4.1  USB-to-serial adapter (CP2102 or CH340)
│   └── 1.4.2  Prototype PCB (perfboard)
└── 1.5  Teardown targets (free)  ($0)
    ├── 1.5.1  An old TV remote
    ├── 1.5.2  A dead phone charger
    └── 1.5.3  A broken toy
```

## Multilevel BOM

| Level | Item | Description | Qty | Cost (USD) | Notes |
|---|---|---|---|---|---|
| **0** | **1** | **Bench 1 — Electrical** | 1 | **101** | |
| **1** | **1.1** | **Passive components** | — | **38** | |
| 2 | 1.1.1 | Resistor assortment (1/4 W, 1% metal film, 10 Ω to 10 MΩ) | 1 kit | 15 | E12 or E24 series, at least 10 of each |
| 2 | 1.1.2 | Capacitor assortment (ceramic 10 pF–1 µF, electrolytic 1–470 µF) | 1 kit | 15 | Mixed |
| 2 | 1.1.3 | Potentiometers (10 kΩ linear, 100 kΩ log) | 5 each | 8 |  |
| **1** | **1.2** | **Semiconductors** | — | **38** | |
| 2 | 1.2.1 | LED assortment (red, green, blue, white, 3 mm & 5 mm) | 50 | 8 |  |
| 2 | 1.2.2 | Diodes (1N4148, 1N4007, 1N5819) | 20 each | 5 | Signal, power, Schottky |
| 2 | 1.2.3 | Op-amps (LM358, TL072, MCP6002) | 5 each | 10 | Rail-to-rail options |
| 2 | 1.2.4 | NPN/PNP transistors (2N3904, 2N3906, BC547) | 10 each | 5 |  |
| 2 | 1.2.5 | MOSFETs (IRLZ44N logic-level, 2N7000) | 5 each | 10 | For switching motors, heaters |
| **1** | **1.3** | **Power** | — | **10** | |
| 2 | 1.3.1 | 9 V battery + clip, 4×AA holder | 2 ea | 10 |  |
| **1** | **1.4** | **Interface & prototyping** | — | **15** | |
| 2 | 1.4.1 | USB-to-serial adapter (CP2102 or CH340) | 1 | 5 |  |
| 2 | 1.4.2 | Prototype PCB (perfboard) | 5 | 10 | For permanent circuits |
| **1** | **1.5** | **Teardown targets (free)** | — | **0** | |
| 2 | 1.5.1 | An old TV remote | 1 | 0 | → look at the IR LED and the carbon-film PCB. |
| 2 | 1.5.2 | A dead phone charger | 1 | 0 | → see the rectifier, filter cap, and switching transformer. |
| 2 | 1.5.3 | A broken toy | 1 | 0 | → trace the circuit from battery to motor driver. |

**Bench 1 — Electrical total: $101** for components (reuse the starter tools) — the course states ~$100.

## Three builds

### Build 1 — LED with current-limiting resistor

Pick R for a 20 mA LED on a 9 V source.

| Uses | |
|---|---|
| This bench | `1.2.1` LED assortment · `1.1.1` Resistor assortment · `1.3.1` 9 V battery + clip, 4×AA holder |
| Starter kit | `S.2.1` [Breadboard, solderless](00-starter-kit.md) · `S.1.1` [Digital multimeter](00-starter-kit.md) |

### Build 2 — RC low-pass filter

1 kHz corner, feed it a square wave, scope the output.

| Uses | |
|---|---|
| This bench | `1.1.1` Resistor assortment · `1.1.2` Capacitor assortment |
| Starter kit | `S.2.1` [Breadboard, solderless](00-starter-kit.md) · `S.5.3` [Function generator](00-starter-kit.md) · `S.5.1` [USB oscilloscope](00-starter-kit.md) |

### Build 3 — Non-inverting op-amp with gain 10

Verify gain with a function generator.

| Uses | |
|---|---|
| This bench | `1.2.3` Op-amps · `1.1.1` Resistor assortment · `1.3.1` 9 V battery + clip, 4×AA holder |
| Starter kit | `S.2.1` [Breadboard, solderless](00-starter-kit.md) · `S.5.3` [Function generator](00-starter-kit.md) · `S.5.1` [USB oscilloscope](00-starter-kit.md) |

## Measurement wins

- You can read voltage and current anywhere in a circuit.
- You can predict RC behavior from component values alone.
