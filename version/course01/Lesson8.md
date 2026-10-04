# Lesson 8 — Foundations

[← course01 index](index.md) · [All lessons](index.md#lessons) · [Lesson 1 — Electrical →](Lesson1.md)

> Across domains, 1 of 3 — **work this lesson first**, before Lesson 1. Nine steps: start with something you can hold, get one mental model, build it, then learn what it's made of, how it's made, what trick unlocked it, and who got there first.

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

**Theory:** [Module 0](index.md#module-0--foundations) · **Stack:** [course03 index](../course03/index.md) and [Pillar 1 — Arrows between piles](../course03/p1-arrows-between-piles.md) · **Bench:** [course04 Starter kit](../course04/00-starter-kit.md)

## 1. What you're looking at

*← start concrete*

Three things on your desk: a resistor and capacitor on a breadboard, a weight hanging from a spring, and a mug of coffee going cold. One is electrical, one is mechanical, one is thermal. They obey the same equation.

## 2. The one thing to understand

*← give the mental model*

Every domain has an **effort** (something that pushes: voltage, force, pressure, temperature) and a **flow** (something that moves: current, velocity, volume flow, heat flow). Effort × flow is power. And every domain has the same three building blocks: something that **resists** flow, something that **stores** it, and something that keeps it **moving**. Learn them once in circuits — R, C, L — and you can read a motor, a pump or a heat sink as a circuit.

The seven domains, their efforts and flows, and the analogy table: [Module 0](index.md#module-0--foundations). Chemical and radiant don't fit the pattern cleanly; that's part of the lesson.

## 3. What to build

*← hands on the bench*

1. Build the RC low-pass filter from [Bench 1, Build 2](../course04/01-bench-electrical.md#build-2--rc-low-pass-filter). Feed it a square wave and read the time constant off the scope: the time to reach 63% of the step.
2. Fill a mug with hot water. Log its temperature every 5 minutes for an hour with any Bench 5 thermometer (the [B5.1 thermocouple](../course04/05-bench-thermal.md#build-1--diy-type-k-thermocouple) or the `5.5.1` IR thermometer). Plot ln(T − T_room) against time: a straight line, whose slope is −1/τ. Put a lid on and repeat. You just raised R_θ.
3. Hang a mass from a spring or rubber band. Time ten oscillations. That's an LC circuit: mass is the capacitor, spring is the inductor (in the mass–capacitance analogy of Module 0).
4. In your notebook (`S.4.2`), draw all three as circuits. Same symbols, different units.

Full BOM: [course04 Starter kit](../course04/00-starter-kit.md) — the tools every bench uses.

## 4. Key materials

*← what it's made of*

The same three roles, played by different materials in each domain:

- **Resistance:** metal-film resistor (electrical), damper oil (mechanical), a narrow orifice (fluidic), foam and air gaps (thermal).
- **Capacitance (storage):** a dielectric film (electrical), a mass (mechanical), a gas-charged accumulator (fluidic), water — the highest specific heat of any common material (thermal).
- **Inductance (momentum):** copper wound on a ferrite core (electrical), spring steel (mechanical), a long column of fluid (fluidic). Thermal has none — heat never overshoots on its own.

## 5. Key techniques

*← how it's made*

- **Lumped modeling** — chop the object into a few R, C and L elements. Good enough for almost every first answer.
- **Translate by analogy** — rewrite a Kirchhoff loop as a force balance, a pressure balance or a heat balance.
- **Time constants** — τ = RC in every domain. If you know τ, you know how fast the thing can respond.
- **Order-of-magnitude estimates** — get the power, the energy and the time constant within 10× before calculating anything precisely.
- **The six-layer question list** — vocabulary, discovery, measurement, material, technique, features — asked of any device you pick up.
- **Teardown and draw** — open it, draw it, label every domain it touches.

## 6. The clever trick

*← what unlocked the industry*

**The analogy itself.** Once engineers noticed that springs, pipes and heat sinks follow the same equations as circuits, every circuit tool became a tool for every domain. Thermal engineers still model heat sinks as resistor networks and simulate them in circuit software. Bond graphs later made the bookkeeping rigorous: one diagram, every domain, power conserved at every junction.

## 7. Who to know

*← short lineage of names*

Fourier (heat conduction, 1807 — Ohm modeled his law on it), Ohm (1827), Kirchhoff (circuit laws, 1845), Maxwell (built mechanical analogies for electromagnetism), Firestone (mobility analogy, 1933), Olson (*Dynamical Analogies*, 1943), Paynter (bond graphs, 1959).

Timeline and people index: [Appendix A](index.md#appendix-a--timeline-of-key-discoveries) · [Appendix B](index.md#appendix-b--people-index).

## 8. The example everyone should work

*← optional — work it with pencil and paper*

A 300 mL mug of coffee at 80 °C on a desk in a 20 °C room — the thermal RC circuit behind every heat sink, oven and thermostat:

1. Thermal capacitance: C_θ = m·c = 0.3 kg × 4186 J/(kg·K) = 1256 J/K.
2. Thermal resistance to the room: about 10 W/(m²·K) of combined convection and radiation over 0.02 m² of mug surface, so R_θ = 1 / (h·A) = 1 / (10 × 0.02) = 5 K/W.
3. Time constant: τ = R_θ·C_θ = 5 × 1256 = 6280 s ≈ 105 min.
4. Initial heat loss: dQ/dt = ΔT / R_θ = 60 / 5 = 12 W.
5. Time to cool to a drinkable 60 °C: ΔT falls from 60 K to 40 K, so t = τ · ln(60/40) = 6280 × 0.405 ≈ 2550 s ≈ 42 min.
6. Read it as a circuit: a 1256 F capacitor charged to 60 V, discharging through 5 Ω. The RC filter from step 3 has τ = 1 / (2π × 1 kHz) = 159 µs. Same equation, about 40 million times slower.

One equation, two domains, eight orders of magnitude apart. That gap is the first hint of [Pillar 3](../course03/p3-bandwidth-and-ceiling.md): the slowest domain sets the bandwidth.

More practice: the "Try it" exercises in [Module 0](index.md#module-0--foundations).

## 9. What to read later

*← optional — where to go deeper*

[Horowitz & Hill](../course02/04-horowitz-hill-art-of-electronics/) (the circuit language every analogy borrows) · [Fraden](../course02/06-fraden-handbook-of-modern-sensors/) (the domains as sensor inputs) · [course03 index](../course03/index.md) (six layers, three pillars). Not in course02: Olson, *Dynamical Analogies*; Karnopp, Margolis & Rosenberg, *System Dynamics* (bond graphs).
