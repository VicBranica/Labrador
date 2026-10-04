# Lesson 10 — Integration & system design

[← Lesson 9 — Cross-domain transducers](Lesson9.md) · [All lessons](index.md#lessons) · [course01 index →](index.md)

> Across domains, 3 of 3, in nine steps: start with something you can hold, get one mental model, build it, then learn what it's made of, how it's made, what trick unlocked it, and who got there first.

## Lesson structure

```
1.  What you're looking at         ← start concrete
2.  The one thing to understand    ← give the mental model
3.  What to build                  ← hands on the bench
4.  Key materials                  ← what it's made of
5.  Key techniques                 ← how it's made
6.  The clever trick               ← what unlocked the industry
7.  Who to know                    ← short lineage of names
8.  The example everyone should work   (optional)
9.  What to read later             (optional)
```

| Step | Section | Purpose |
|---|---|---|
| 1 | [What you're looking at](#1-what-youre-looking-at) | Start concrete. |
| 2 | [The one thing to understand](#2-the-one-thing-to-understand) | Give the mental model. |
| 3 | [What to build](#3-what-to-build) | Hands on the bench. |
| 4 | [Key materials](#4-key-materials) | What it's made of. |
| 5 | [Key techniques](#5-key-techniques) | How it's made. |
| 6 | [The clever trick](#6-the-clever-trick) | What unlocked the industry. |
| 7 | [Who to know](#7-who-to-know) | Short lineage of names. |
| 8 | [The example everyone should work](#8-the-example-everyone-should-work) | Optional — work it with pencil and paper. |
| 9 | [What to read later](#9-what-to-read-later) | Optional — where to go deeper. |

**Theory:** [Module 9](index.md#module-9--integration--system-design) · **Stack:** [The integration pile](../course03/08-integration.md) and [Pillar 3 — Bandwidth and ceiling](../course03/p3-bandwidth-and-ceiling.md) · **Bench:** all of them — this build uses [Bench 1](../course04/01-bench-electrical.md), [Bench 5](../course04/05-bench-thermal.md) and the [Starter kit](../course04/00-starter-kit.md)

## 1. What you're looking at

*← start concrete*

A thermostat, a hard-drive head arm, a hobby servo, a 3D-printer hot end. Each one is a sensor, a controller and an actuator wired into a loop. Take the sensor away and each becomes a crude, drifting actuator.

## 2. The one thing to understand

*← give the mental model*

A closed loop is only as **accurate** as its sensor and only as **fast** as its slowest domain. Feedback moves the burden of precision from the actuator to the sensor, so spend on the sensor, put it next to the actuator, and make it faster than the loop. Then specify only what matters and loosen everything else.

The closed-loop checklist and the capstone options: [Module 9](index.md#module-9--integration--system-design). The design heuristics: [course02 design.md](../course02/09-gelbart-videos/design.md).

## 3. What to build

*← hands on the bench*

A temperature controller, built entirely from bench parts:

1. Clamp the `5.3.1` Peltier module to the `5.3.2` heatsink and fan with `5.3.3` thermal paste. Bond a `5.2.1` RTD to the top face and read it through the `5.2.2` RTD breakout on the Arduino (`S.5.4`).
2. Switch the Peltier from the bench supply (`S.5.2`, about 5 V) through a `1.2.5` logic-level MOSFET driven by an Arduino pin. Check the supply's current limit first.
3. Write an on/off controller with 1 °C of hysteresis that holds the top face at 40 °C. Log temperature every second and plot it. You'll see a sawtooth.
4. Switch to proportional control with PWM. The sawtooth shrinks to a steady offset. Add integral action and the offset goes away.
5. Move the RTD off the Peltier, onto the far edge of a coin sitting on top of it. Run the same controller. The lag between actuator and sensor makes it overshoot and oscillate. That's what "collocate sensor and actuator" means.
6. Walk the [closed-loop checklist](index.md#closed-loop-design-checklist) item by item for your build and write down which items pass.

Full BOMs: [Bench 1](../course04/01-bench-electrical.md), [Bench 5](../course04/05-bench-thermal.md), [Starter kit](../course04/00-starter-kit.md).

## 4. Key materials

*← what it's made of*

At the system level, materials are chosen for the paths *between* parts:

- **Heat paths:** aluminum heat sinks, copper spreaders, thermal paste and pads — every actuator turns some power into heat, and it has to go somewhere.
- **Insulation:** foam, air gaps and polymer standoffs to keep heat (and drift) away from sensors.
- **Signal integrity:** twisted pair, shielded cable, ground planes on the PCB — keeping actuator current out of sensor signals.
- **Mounting:** stiff, stable structure (aluminum, steel, granite) where the sensor references the actuator; compliant mounts (rubber, flexures) where vibration has to stop.
- **Rugged environments:** pick the material first — Hastelloy, sapphire, Viton, platinum.

## 5. Key techniques

*← how it's made*

- **Closed-loop design checklist** — sensor resolution, sensor and actuator bandwidth, collocation, anti-aliasing, heat path, EMI, safe state. See [Module 9](index.md#closed-loop-design-checklist).
- **Error budget** — list every error source, size each one, and add them up before you build.
- **Sampling** — sample at least twice the highest frequency present (in practice 5–10×), and filter out everything above half the sample rate first.
- **PID tuning** — proportional for speed, integral to remove offset, derivative (carefully) for damping.
- **FMEA** — for each part, ask how it fails, what that does to the system, and how you'd notice.
- **Design for debug** — log everything, expose test points, flag faults, keep data you can replay.

## 6. The clever trick

*← what unlocked the industry*

**Negative feedback.** In 1927 Harold Black, at Bell Labs, worked out that an amplifier built from drifting, nonlinear vacuum tubes could be made precise by feeding part of its output back to subtract from its input: high gain plus feedback trades away gain for accuracy. The same idea makes a stage with a sticky, nonlinear motor position to nanometers, as long as the sensor is precise. A precise sensor and a crude actuator make a precise system.

## 7. Who to know

*← short lineage of names*

Watt (centrifugal governor on the steam engine, 1788), Maxwell ("On Governors", 1868 — the first stability analysis), Black (negative-feedback amplifier, 1927), Nyquist (sampling, 1928; stability criterion, 1932), Bode (frequency-response design, 1940s), Shannon (sampling theorem, 1949), Slocum and Hale (precision machine design), Gelbart (prototype-first design practice).

Timeline and people index: [Appendix A](index.md#appendix-a--timeline-of-key-discoveries) · [Appendix B](index.md#appendix-b--people-index).

## 8. The example everyone should work

*← optional — work it with pencil and paper*

Capstone Option B: a chamber that cycles a 100 g sample between −20 °C and +100 °C with ±0.5 °C stability, in a 20 °C room. Model the sample and its aluminum plate as 0.5 kg of aluminum (c = 900 J/(kg·K)), insulated to R_θ = 2 K/W from the room:

1. Thermal capacitance: C_θ = 0.5 × 900 = 450 J/K. Time constant: τ = R_θ · C_θ = 2 × 450 = 900 s = 15 min.
2. Holding +100 °C: the heater must replace the leak, P = ΔT / R_θ = 80 / 2 = 40 W.
3. Holding −20 °C: 40 / 2 = 20 W leaks in and must be pumped out. A Peltier with a coefficient of performance of about 0.5 needs about 40 W of electrical input for that, and its hot side must shed 20 + 40 = 60 W — that sizes the heat sink and fan.
4. Ramping at 10 K/min: P = C_θ · dT/dt = 450 × (10 / 60) = 75 W on top of the leak, so the heater needs at least 40 + 75 = 115 W at the hot end.
5. Sensor resolution: the checklist asks for 10× better than ±0.5 °C, so 0.05 °C. A Type K thermocouple read at 0.25 °C fails. A Pt100 RTD on a 15-bit RTD converter (about 0.03 °C) passes.
6. Sensor speed and placement: bond a small RTD directly to the sample, not in the air. A probe that sits in the air, or a heavy sheathed probe with a response time of tens of seconds, adds the lag you saw in step 5 of the build.

Read it: every number that sizes this design — heater power, cooler power, heat-sink load, sensor choice — comes from the thermal mass and the insulation. The electronics are the easy part. Bandwidth lives in the slowest domain.

More practice: the capstone in [Module 9](index.md#capstone-project).

## 9. What to read later

*← optional — where to go deeper*

[Slocum](../course02/01-slocum-precision-machine-design/) · [Hale](../course02/02-hale-designing-precision-machines/) · [Gelbart's videos](../course02/09-gelbart-videos/) and [design.md](../course02/09-gelbart-videos/design.md) · [Horowitz & Hill](../course02/04-horowitz-hill-art-of-electronics/) (feedback and op-amps) · [The integration pile](../course03/08-integration.md). Not in course02: Åström & Murray, *Feedback Systems* (free online).
