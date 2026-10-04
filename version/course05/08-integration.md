# The Integration Pile — Putting It Together

[← Course 05 index](index.md) · [← Pile 7](07-radiant.md)

**Course:** [course01 Module 8](../course01/index.md#module-8--cross-domain-transducers) and [Module 9](../course01/index.md#module-9--integration--system-design) · **Heuristics:** [course02 design.md](../course02/09-gelbart-videos/design.md)

You've looked at seven piles. Real devices live between them.

A **servo motor** = electrical (drive) → magnetic (coil + magnet) → mechanical (shaft) → with an electrical sensor (encoder, Hall) measuring the mechanical output. Four crossings in one object.

A **smartphone** has every pile: electrical (SoC), magnetic (speaker, haptic motor, compass), mechanical (buttons, MEMS), fluidic (pressure sensor), thermal (temperature, management), chemical (battery, humidity), radiant (camera, display, laser rangefinder on recent models).

## How to design one

1. Start with what has to be true at the output. How much force, how fast, how accurate.
2. Pick the output domain and its material + technique. This usually settles half the design.
3. Pick a sensor whose resolution is 10× better than the required control resolution, and whose bandwidth is 5–10× the closed-loop bandwidth.
4. Pick an actuator whose bandwidth exceeds the closed-loop bandwidth.
5. Put the sensor and actuator at the same mechanical location if you can (collocated). It makes control stable.
6. Specify what matters, loosen what doesn't. Tolerances cost money.
7. Design for debug. Logs, test points, diagnostic LEDs, feature flags. Prototypes that silently fail waste the most time.

## Design heuristics (Gelbart-style)

The full list, with the reasoning behind each rule, is in [course02 — Design Heuristics](../course02/09-gelbart-videos/design.md):

1. Stay in one domain if you can.
2. Match impedances across boundaries.
3. Pick the domain and material naturally matched to the measurand.
4. Bandwidth lives in the slowest domain.
5. Energy density determines size.
6. Rugged environment = pick the material first.
7. Build it yourself.
8. The second one is always better than the first.
9. Simplicity over cleverness.

## The one-page map

```
          THE SEVEN PILES
          ───────────────
   Electrical ─┬───────── Magnetic
               │             │
               │             │
          Mechanical ────────┤
               │             │
               │             │
          Fluidic ───────────┤
               │             │
               │             │
          Thermal ───────────┤
               │             │
               │             │
          Chemical ──────────┤
               │             │
               │             │
          Radiant ───────────┘
```

```
   Any sensor or actuator
   is one or more arrows
   between two piles.

   The material + technique
   on each arrow is what
   makes the device possible.

   The slowest domain
   sets the bandwidth.
   The material family
   sets the ceiling.
```
