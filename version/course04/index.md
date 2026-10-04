# Course 04 — Build Your Own Sensors & Actuators Lab

> **Goal:** build your own sensors & actuators lab, one bench per physical domain. Each bench has its own file with a multilevel bill of materials (BOM).

## Files

| File | Bench | Domain | Theory | BOM sum (USD) | Course states |
|---|---|---|---|---|---|
| [00-starter-kit.md](00-starter-kit.md) | Universal Starter Kit | All | — | 165–265 | ~160–250 |
| [01-bench-electrical.md](01-bench-electrical.md) | Bench 1 | Electrical | [course03/01-electrical](../course03/01-electrical/README.md) | 101 | ~100 |
| [02-bench-magnetic.md](02-bench-magnetic.md) | Bench 2 | Magnetic | [course03/02-magnetic](../course03/02-magnetic/README.md) | 95 | ~95 |
| [03-bench-mechanical.md](03-bench-mechanical.md) | Bench 3 | Mechanical | [course03/03-mechanical](../course03/03-mechanical/README.md) | 114 | ~115 |
| [04-bench-fluidic.md](04-bench-fluidic.md) | Bench 4 | Fluidic | [course03/04-fluidic](../course03/04-fluidic/README.md) | 113 | ~115 |
| [05-bench-thermal.md](05-bench-thermal.md) | Bench 5 | Thermal | [course03/05-thermal](../course03/05-thermal/README.md) | 116 | ~115 |
| [06-bench-chemical.md](06-bench-chemical.md) | Bench 6 | Chemical | [course03/06-chemical](../course03/06-chemical/README.md) | 137 | ~135 |
| [07-bench-radiant.md](07-bench-radiant.md) | Bench 7 | Radiant | [course03/07-radiant](../course03/07-radiant/README.md) | 100 | ~100 |
| | **Grand total** | | | **941–1041** | **~935** |

The nice-to-have instruments in the starter kit (oscilloscope, power supply, function generator, microcontroller, thermal camera, USB microscope) add $395–610 and are not in the totals above.

**Total (one weekend of teardowns + minimal buys): ~$500**

## How the BOMs are structured

Every BOM has three levels:

| Level | What it is | Numbering | Example |
|---|---|---|---|
| 0 | The bench (or the starter kit) | `<bench>` | `3` — Bench 3 — Mechanical |
| 1 | A category within the bench | `<bench>.<category>` | `3.1` — Strain & force measurement |
| 2 | A single purchasable or free item | `<bench>.<category>.<item>` | `3.1.3` — HX711 load-cell amplifier breakout |

- The starter kit uses `S` in place of a bench number (`S.1.1` is the multimeter).
- The last category on every bench is **Teardown targets (free)**, at cost 0.
- Each build lists the item numbers it uses — from its own bench, other benches, and the starter kit — plus anything it needs that isn't in any BOM.
- Level 0 and level 1 costs are computed sums of the level 2 items below them.

```
Lab
├── S  Universal Starter Kit      (tools shared by every bench)
├── 1  Bench 1 — Electrical   (4 categories + teardown)
├── 2  Bench 2 — Magnetic     (5 categories + teardown)
├── 3  Bench 3 — Mechanical   (5 categories + teardown)
├── 4  Bench 4 — Fluidic      (5 categories + teardown)
├── 5  Bench 5 — Thermal      (5 categories + teardown)
├── 6  Bench 6 — Chemical     (5 categories + teardown)
└── 7  Bench 7 — Radiant      (5 categories + teardown)
```

## Grand total — as stated in the course

| Bench | Cost |
|---|---|
| Universal starter kit | 160–250 |
| Bench 1 — Electrical | 100 |
| Bench 2 — Magnetic | 95 |
| Bench 3 — Mechanical | 115 |
| Bench 4 — Fluidic | 115 |
| Bench 5 — Thermal | 115 |
| Bench 6 — Chemical | 135 |
| Bench 7 — Radiant | 100 |
| **Total (budget)** | **~$935** |
| **Total (one weekend of teardowns + minimal buys)** | **~$500** |

Most of what makes this work isn't on the shopping list — it's on the free side: broken electronics from recycling bins, defunct printers, old speakers, hard drives, kitchen scales. Every one of those is a working example of two or three domains at once, and taking them apart teaches more than any purchased kit.

## Where to buy

- **Electronics:** DigiKey, Mouser (new, authoritative), Adafruit, SparkFun (hobby-friendly), AliExpress (cheap, slow, caveat emptor).
- **Magnets:** K&J Magnetics (US), supermagnete.de (EU) — avoid random Amazon listings for serious work.
- **Mechanical:** McMaster-Carr (US gold standard, same-day), Misumi (modular hardware), MSC Direct.
- **Chemicals / probes:** Cole-Parmer, Thermo Fisher, Hanna Instruments (consumer pH meters).
- **Optics:** Thorlabs, Edmund Optics (serious), AliExpress (teardown-grade).
- **Teardown stock:** your own recycling bin, eBay "untested" lots, local repair shops that would otherwise bin the broken stuff.

## How to use these benches

1. **One bench at a time.** Set it up on a card table or in a drawer. Clear it when done. Rotate.
2. **Start with teardowns, not purchases.** You'll know what to buy once you've seen what's inside the free stuff.
3. **Build the three listed exercises on each bench before moving on.** Not three like the ones listed — those three.
4. **Measure before, during, after.** The whole point is to turn invisible phenomena into numbers on a meter.
5. **Keep a notebook per bench.** Date every entry. Sketch every teardown. Write down what surprised you.
