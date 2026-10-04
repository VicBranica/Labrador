# Bench 2 — Magnetic

[← Course 04 index](index.md) · [← Bench 1](01-bench-electrical.md) · [Bench 3 →](03-bench-mechanical.md)

**Theory:** [course03/02-magnetic](../course03/02-magnetic/README.md) · **Shared tools:** [Universal Starter Kit](00-starter-kit.md)

## What's on it

Motors to disassemble, magnets to feel, coils to wind, Hall sensors to probe. The physical home of flux, reluctance, and force.

## BOM structure

```
2  Bench 2 — Magnetic  ($95)
├── 2.1  Magnets  ($20)
│   ├── 2.1.1  Neodymium (NdFeB) magnets, assorted (5–20 mm disc/block)
│   └── 2.1.2  Ferrite ring + bar magnets
├── 2.2  Coil & core materials  ($15)
│   ├── 2.2.1  Magnet wire (0.3 mm enameled copper, 100 m spool)
│   └── 2.2.2  Steel bolts, assorted M4–M8
├── 2.3  Magnetic sensors  ($21)
│   ├── 2.3.1  Hall effect sensor breakout (A3144 digital, A1324 linear)
│   ├── 2.3.2  Reed switch
│   └── 2.3.3  Rotary encoder breakout (incremental, with button)
├── 2.4  Motors & drivers  ($34)
│   ├── 2.4.1  Small DC brushed motor (6 V hobby)
│   ├── 2.4.2  BLDC fan (12 V, 80 mm, dead or alive)
│   ├── 2.4.3  Stepper motor (NEMA 17, 1.8°)
│   └── 2.4.4  Motor driver (L298N or DRV8833 breakout)
├── 2.5  Reference instruments  ($5)
│   └── 2.5.1  Compass, pocket
└── 2.6  Teardown targets (free)  ($0)
    ├── 2.6.1  Dead cordless-drill motor
    ├── 2.6.2  Hard-drive voice coil
    ├── 2.6.3  Microwave oven transformer (unplugged, discharged, DANGER...
    └── 2.6.4  Old speaker
```

## Multilevel BOM

| Level | Item | Description | Qty | Cost (USD) | Notes |
|---|---|---|---|---|---|
| **0** | **2** | **Bench 2 — Magnetic** | 1 | **95** | |
| **1** | **2.1** | **Magnets** | — | **20** | |
| 2 | 2.1.1 | Neodymium (NdFeB) magnets, assorted (5–20 mm disc/block) | 20 | 15 | N42 or N52 grade |
| 2 | 2.1.2 | Ferrite ring + bar magnets | 5 | 5 | For comparison with NdFeB |
| **1** | **2.2** | **Coil & core materials** | — | **15** | |
| 2 | 2.2.1 | Magnet wire (0.3 mm enameled copper, 100 m spool) | 1 | 10 | For winding your own coils |
| 2 | 2.2.2 | Steel bolts, assorted M4–M8 | 10 | 5 | Cores for homemade electromagnets |
| **1** | **2.3** | **Magnetic sensors** | — | **21** | |
| 2 | 2.3.1 | Hall effect sensor breakout (A3144 digital, A1324 linear) | 3 each | 10 |  |
| 2 | 2.3.2 | Reed switch | 5 | 3 |  |
| 2 | 2.3.3 | Rotary encoder breakout (incremental, with button) | 2 | 8 |  |
| **1** | **2.4** | **Motors & drivers** | — | **34** | |
| 2 | 2.4.1 | Small DC brushed motor (6 V hobby) | 2 | 6 | For teardown and drive practice |
| 2 | 2.4.2 | BLDC fan (12 V, 80 mm, dead or alive) | 1 | 5 | Teardown — count stator teeth and magnets |
| 2 | 2.4.3 | Stepper motor (NEMA 17, 1.8°) | 1 | 15 | Drives everything in 3D printers |
| 2 | 2.4.4 | Motor driver (L298N or DRV8833 breakout) | 2 | 8 |  |
| **1** | **2.5** | **Reference instruments** | — | **5** | |
| 2 | 2.5.1 | Compass, pocket | 1 | 5 | Ørsted's experiment |
| **1** | **2.6** | **Teardown targets (free)** | — | **0** | |
| 2 | 2.6.1 | Dead cordless-drill motor | 1 | 0 | → BLDC with NdFeB rotor magnets. |
| 2 | 2.6.2 | Hard-drive voice coil | 1 | 0 | → the strongest magnet most people have handled. |
| 2 | 2.6.3 | Microwave oven transformer (unplugged, discharged, **DANGEROUS unless you know what you're doing**) | 1 | 0 | → silicon-steel laminations. |
| 2 | 2.6.4 | Old speaker | 1 | 0 | → magnet + voice coil + diaphragm. |

**Bench 2 — Magnetic total: $95** for components (reuse the starter tools) — the course states ~$95.

## Three builds

### Build 1 — Electromagnet

Wind 100 turns on a steel bolt. Measure pull on a scale.

| Uses | |
|---|---|
| This bench | `2.2.1` Magnet wire · `2.2.2` Steel bolts, assorted M4–M8 |
| Other benches | `1.3.1` [9 V battery + clip, 4×AA holder](01-bench-electrical.md) |
| Starter kit | `S.1.3` [Kitchen scale](00-starter-kit.md) |

### Build 2 — Hand-wound motor

Nail, battery, loop of wire with insulation scraped off one side. Ugly, works.

| Uses | |
|---|---|
| This bench | `2.2.1` Magnet wire · `2.1.1` Neodymium |
| Other benches | `1.3.1` [9 V battery + clip, 4×AA holder](01-bench-electrical.md) |
| Not in any BOM | Nail |

### Build 3 — Measure NdFeB vs. ferrite

Same geometry, compare force on a steel washer.

| Uses | |
|---|---|
| This bench | `2.1.1` Neodymium · `2.1.2` Ferrite ring + bar magnets |
| Starter kit | `S.1.3` [Kitchen scale](00-starter-kit.md) · `S.1.2` [Digital calipers](00-starter-kit.md) |
| Not in any BOM | Steel washer |

## Measurement wins

- You can hold a C-core electromagnet calculation in your head.
- You can read a motor spec sheet (torque constant, Kv, resistance) and know what each number does.
