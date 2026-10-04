# Bench 6 — Chemical

[← Course 04 index](index.md) · [← Bench 5](05-bench-thermal.md) · [Bench 7 →](07-bench-radiant.md)

**Course:** [course01 Module 6](../course01/index.md#module-6--chemical-domain) · **Theory:** [course03/06-chemical](../course03/06-chemical/README.md) · **Shared tools:** [Universal Starter Kit](00-starter-kit.md)

## What's on it

Electrodes, a pH meter, a glucose test strip, two different metals in salt water. The pile where millivolts mean concentration.

## BOM structure

```
6  Bench 6 — Chemical  ($137)
├── 6.1  Electrodes  ($45)
│   ├── 6.1.1  Zinc and copper strips (hobby-shop)
│   ├── 6.1.2  Silver wire + silver chloride (or SMD Ag/AgCl pellet)
│   └── 6.1.3  Platinum wire (0.2 mm, 100 mm)
├── 6.2  pH measurement  ($45)
│   ├── 6.2.1  pH meter (digital, pocket)
│   ├── 6.2.2  pH buffer solutions (pH 4, 7, 10)
│   └── 6.2.3  pH probe (BNC-type replacement)
├── 6.3  Electrolytes & cells  ($7)
│   ├── 6.3.1  Electrolyte salts (NaCl, KCl, CuSO₄, lemon juice)
│   └── 6.3.2  Lemons, potatoes
├── 6.4  Gas & humidity sensors  ($25)
│   ├── 6.4.1  CO/CO₂/smoke sensor module (MQ-series, MH-Z19)
│   └── 6.4.2  Humidity + temp sensor (DHT22 or SHT31)
├── 6.5  Biosensor stock  ($15)
│   └── 6.5.1  Glucose test strips + lancet (any pharmacy meter)
└── 6.6  Teardown targets (free)  ($0)
    ├── 6.6.1  Any disposable glucose meter + strip
    ├── 6.6.2  Old smoke detector (ionization type — handle carefully, h...
    └── 6.6.3  Dead alkaline battery
```

## Multilevel BOM

| Level | Item | Description | Qty | Cost (USD) | Notes |
|---|---|---|---|---|---|
| **0** | **6** | **Bench 6 — Chemical** | 1 | **137** | |
| **1** | **6.1** | **Electrodes** | — | **45** | |
| 2 | 6.1.1 | Zinc and copper strips (hobby-shop) | 5 each | 10 | For Volta cells |
| 2 | 6.1.2 | Silver wire + silver chloride (or SMD Ag/AgCl pellet) | 1 each | 10 | Reference electrode |
| 2 | 6.1.3 | Platinum wire (0.2 mm, 100 mm) | 1 | 25 | Expensive but essential |
| **1** | **6.2** | **pH measurement** | — | **45** | |
| 2 | 6.2.1 | pH meter (digital, pocket) | 1 | 15 | With calibration buffers |
| 2 | 6.2.2 | pH buffer solutions (pH 4, 7, 10) | 1 set | 10 |  |
| 2 | 6.2.3 | pH probe (BNC-type replacement) | 1 | 20 | Open it (gently) to see the glass bulb and reference |
| **1** | **6.3** | **Electrolytes & cells** | — | **7** | |
| 2 | 6.3.1 | Electrolyte salts (NaCl, KCl, CuSO₄, lemon juice) | 1 each | 5 | Household + hardware store |
| 2 | 6.3.2 | Lemons, potatoes | — | 2 | Classic batteries |
| **1** | **6.4** | **Gas & humidity sensors** | — | **25** | |
| 2 | 6.4.1 | CO/CO₂/smoke sensor module (MQ-series, MH-Z19) | 2 | 15 | Metal-oxide and NDIR |
| 2 | 6.4.2 | Humidity + temp sensor (DHT22 or SHT31) | 2 | 10 | Capacitive humidity |
| **1** | **6.5** | **Biosensor stock** | — | **15** | |
| 2 | 6.5.1 | Glucose test strips + lancet (any pharmacy meter) | 1 kit | 15 | For teardown; disposable |
| **1** | **6.6** | **Teardown targets (free)** | — | **0** | |
| 2 | 6.6.1 | Any disposable glucose meter + strip | 1 | 0 | → platinum trace, enzyme spot, reference line. |
| 2 | 6.6.2 | Old smoke detector (ionization type — **handle carefully, has small Am-241 source**) OR photoelectric detector | 1 | 0 | → IR LED + photodiode. |
| 2 | 6.6.3 | Dead alkaline battery | 1 | 0 | → zinc anode, MnO₂ cathode, KOH electrolyte. |

**Bench 6 — Chemical total: $137** for components (reuse the starter tools) — the course states ~$135.

## Four builds

### Build 1 — Volta's pile

Alternate copper and zinc coins with brine-soaked cardboard. Light an LED with a stack of 10.

| Uses | |
|---|---|
| This bench | `6.1.1` Zinc and copper strips · `6.3.1` Electrolyte salts |
| Other benches | `1.2.1` [LED assortment](01-bench-electrical.md) |
| Starter kit | `S.1.1` [Digital multimeter](00-starter-kit.md) |
| Not in any BOM | Cardboard |

### Build 2 — Salt-concentration cell

Two copper strips in CuSO₄ solutions of different concentrations. Measure the Nernst voltage — about 30 mV per decade for the Cu²⁺/Cu couple.

| Uses | |
|---|---|
| This bench | `6.1.1` Zinc and copper strips · `6.3.1` Electrolyte salts |
| Starter kit | `S.1.1` [Digital multimeter](00-starter-kit.md) · `S.4.3` [Nitrile gloves](00-starter-kit.md) |
| Not in any BOM | Two containers |

### Build 3 — Lemon battery array

Four lemons in series will blink an Arduino's LED.

| Uses | |
|---|---|
| This bench | `6.3.2` Lemons, potatoes · `6.1.1` Zinc and copper strips |
| Starter kit | `S.5.4` [Arduino Uno or Raspberry Pi Pico](00-starter-kit.md) · `S.2.2` [Jumper wire kit](00-starter-kit.md) |

### Build 4 — pH of a weak acid

Calibrate the pH meter in the buffers (pH 7 first, then pH 4). Make a tenfold dilution series of vinegar with distilled water — full strength, 1/10, 1/100 — and read each one. A weak acid's pH rises by only about 0.5 per tenfold dilution, not by 1 as a strong acid's would: you're watching an equilibrium shift, not just a concentration fall.

| Uses | |
|---|---|
| This bench | `6.2.1` pH meter · `6.2.2` pH buffer solutions |
| Other benches | `4.1.1` [Syringes](04-bench-fluidic.md) |
| Starter kit | `S.4.3` [Nitrile gloves](00-starter-kit.md) · `S.4.1` [Safety glasses](00-starter-kit.md) |
| Not in any BOM | Vinegar · Distilled water · Cups |

## Measurement wins

- You can apply the Nernst equation to a half-cell.
- You can distinguish amperometric from potentiometric sensing by looking at the signal.
