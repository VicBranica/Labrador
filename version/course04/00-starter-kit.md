# Universal Starter Kit

[← Course 04 index](index.md)

> Buy once, use for every bench. Before any single pile — these are the tools that make every exercise possible.

## BOM structure

```
S  Universal Starter Kit — core  ($165–265)
├── S.1  Measurement tools  ($60–110)
│   ├── S.1.1  Digital multimeter (6000-count)
│   ├── S.1.2  Digital calipers (150 mm)
│   ├── S.1.3  Kitchen scale (0.1 g resolution, 3 kg)
│   └── S.1.4  Steel ruler (300 mm)
├── S.2  Prototyping  ($20)
│   ├── S.2.1  Breadboard, solderless (830 tie-point)
│   └── S.2.2  Jumper wire kit (M-M, M-F, F-F)
├── S.3  Soldering & hand tools  ($75–125)
│   ├── S.3.1  Soldering iron (temp-controlled, 60 W)
│   ├── S.3.2  Solder (60/40 or lead-free, 0.6 mm)
│   ├── S.3.3  Flush cutters, needle-nose pliers
│   ├── S.3.4  Precision screwdriver set (Phillips, flat, Torx)
│   └── S.3.5  Hex key set (metric + imperial)
└── S.4  Safety & records  ($10)
    ├── S.4.1  Safety glasses
    └── S.4.2  Notebook + pen
```

## Multilevel BOM — core (buy first)

| Level | Item | Description | Qty | Cost (USD) | Notes |
|---|---|---|---|---|---|
| **0** | **S** | **Universal Starter Kit — core** | 1 | **165–265** | |
| **1** | **S.1** | **Measurement tools** | — | **60–110** | |
| 2 | S.1.1 | Digital multimeter (6000-count) | 1 | 25–50 | AstroAI, Fluke 101 for the budget option |
| 2 | S.1.2 | Digital calipers (150 mm) | 1 | 15–40 | Mitutoyo if you can swing it; cheap ones work |
| 2 | S.1.3 | Kitchen scale (0.1 g resolution, 3 kg) | 1 | 15 | Measures force, mass, and lots else |
| 2 | S.1.4 | Steel ruler (300 mm) | 1 | 5 |  |
| **1** | **S.2** | **Prototyping** | — | **20** | |
| 2 | S.2.1 | Breadboard, solderless (830 tie-point) | 2 | 10 | Keep one for electronics, one for sensor prototyping |
| 2 | S.2.2 | Jumper wire kit (M-M, M-F, F-F) | 1 | 10 | Pre-cut assortment |
| **1** | **S.3** | **Soldering & hand tools** | — | **75–125** | |
| 2 | S.3.1 | Soldering iron (temp-controlled, 60 W) | 1 | 30–80 | Pinecil or Hakko FX-888D if budget allows |
| 2 | S.3.2 | Solder (60/40 or lead-free, 0.6 mm) | 1 roll | 10 |  |
| 2 | S.3.3 | Flush cutters, needle-nose pliers | 1 set | 10 |  |
| 2 | S.3.4 | Precision screwdriver set (Phillips, flat, Torx) | 1 | 15 | For disassembly — the heart of this course |
| 2 | S.3.5 | Hex key set (metric + imperial) | 1 | 10 |  |
| **1** | **S.4** | **Safety & records** | — | **10** | |
| 2 | S.4.1 | Safety glasses | 1 | 5 | Non-negotiable |
| 2 | S.4.2 | Notebook + pen | 1 | 5 | Draw every teardown. Date everything. |

**Starter total (core): $165–265** — the course states ~$160–250.

## Multilevel BOM — nice-to-have (add when you need them)

| Level | Item | Description | Qty | Cost (USD) | Notes |
|---|---|---|---|---|---|
| **1** | **S.5** | **Nice-to-have (add when you need them)** | — | **395–610** | |
| 2 | S.5.1 | USB oscilloscope (Hantek 6022BE or similar) | 1 | 60 | For Bench 1, 2, 7 |
| 2 | S.5.2 | Benchtop DC power supply (0–30 V, 0–5 A) | 1 | 60 | For Bench 1, 2 |
| 2 | S.5.3 | Function generator (DDS, 0–20 MHz) | 1 | 40 | For Bench 1, 7 |
| 2 | S.5.4 | Arduino Uno or Raspberry Pi Pico | 1 | 10–25 | For all benches |
| 2 | S.5.5 | Thermal camera attachment (FLIR One or InfiRay P2) | 1 | 200–400 | For Bench 5, 7 |
| 2 | S.5.6 | USB microscope | 1 | 25 | For teardowns |

## Where used

| Item | Used by |
|---|---|
| `S.1.1` Digital multimeter | [B1.1 LED with current-limiting resistor](01-bench-electrical.md#build-1--led-with-current-limiting-resistor), [B6.1 Volta's pile](06-bench-chemical.md#build-1--voltas-pile), [B6.2 Salt-concentration cell](06-bench-chemical.md#build-2--salt-concentration-cell), [B7.2 Photodiode darkroom](07-bench-radiant.md#build-2--photodiode-darkroom) |
| `S.1.2` Digital calipers | [B2.3 Measure NdFeB vs. ferrite](02-bench-magnetic.md#build-3--measure-ndfeb-vs-ferrite), [B3.2 Monolithic flexure](03-bench-mechanical.md#build-2--monolithic-flexure) |
| `S.1.3` Kitchen scale | [B2.1 Electromagnet](02-bench-magnetic.md#build-1--electromagnet), [B2.3 Measure NdFeB vs. ferrite](02-bench-magnetic.md#build-3--measure-ndfeb-vs-ferrite), [B4.1 Syringe hydraulics](04-bench-fluidic.md#build-1--syringe-hydraulics) |
| `S.1.4` Steel ruler | General use — no specific build |
| `S.2.1` Breadboard, solderless | [B1.1 LED with current-limiting resistor](01-bench-electrical.md#build-1--led-with-current-limiting-resistor), [B1.2 RC low-pass filter](01-bench-electrical.md#build-2--rc-low-pass-filter), [B1.3 Non-inverting op-amp with gain 10](01-bench-electrical.md#build-3--non-inverting-op-amp-with-gain-10), [B7.2 Photodiode darkroom](07-bench-radiant.md#build-2--photodiode-darkroom) |
| `S.2.2` Jumper wire kit | [B3.1 Strain-gauge cantilever](03-bench-mechanical.md#build-1--strain-gauge-cantilever), [B4.3 Pressure-logger](04-bench-fluidic.md#build-3--pressure-logger), [B6.3 Lemon battery array](06-bench-chemical.md#build-3--lemon-battery-array) |
| `S.3.1` Soldering iron | General use — no specific build |
| `S.3.2` Solder | General use — no specific build |
| `S.3.3` Flush cutters, needle-nose pliers | [B5.3 Nitinol spring](05-bench-thermal.md#build-3--nitinol-spring) |
| `S.3.4` Precision screwdriver set | General use — no specific build |
| `S.3.5` Hex key set | General use — no specific build |
| `S.4.1` Safety glasses | General use — no specific build |
| `S.4.2` Notebook + pen | General use — no specific build |
| `S.5.1` USB oscilloscope | [B1.2 RC low-pass filter](01-bench-electrical.md#build-2--rc-low-pass-filter), [B1.3 Non-inverting op-amp with gain 10](01-bench-electrical.md#build-3--non-inverting-op-amp-with-gain-10) |
| `S.5.2` Benchtop DC power supply | General use — no specific build |
| `S.5.3` Function generator | [B1.2 RC low-pass filter](01-bench-electrical.md#build-2--rc-low-pass-filter), [B1.3 Non-inverting op-amp with gain 10](01-bench-electrical.md#build-3--non-inverting-op-amp-with-gain-10) |
| `S.5.4` Arduino Uno or Raspberry Pi Pico | [B3.1 Strain-gauge cantilever](03-bench-mechanical.md#build-1--strain-gauge-cantilever), [B4.3 Pressure-logger](04-bench-fluidic.md#build-3--pressure-logger), [B5.1 DIY Type K thermocouple](05-bench-thermal.md#build-1--diy-type-k-thermocouple), [B6.3 Lemon battery array](06-bench-chemical.md#build-3--lemon-battery-array) |
| `S.5.5` Thermal camera attachment | General use — no specific build |
| `S.5.6` USB microscope | General use — no specific build |
