# Lesson 5 — Thermal

[← Lesson 4 — Fluidic](Lesson4.md) · [All lessons](index.md#lessons) · [Lesson 6 — Chemical →](Lesson6.md)

> Domain 5 of 7, in nine steps: start with something you can hold, get one mental model, build it, then learn what it's made of, how it's made, what trick unlocked it, and who got there first.

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

**Theory:** [Module 5](index.md#module-5--thermal-domain) · **Stack:** [course03/05-thermal](../course03/05-thermal/README.md) · **Bench:** [course04/05-bench-thermal](../course04/05-bench-thermal.md)

## 1. What you're looking at

*← start concrete*

A thermocouple from a multimeter probe. A Peltier module from a USB mini-fridge. A bimetal strip from an old oven thermostat. A pot of water heating on the stove.

## 2. The one thing to understand

*← give the mental model*

Heat is slow. Everything thermal has a time constant equal to thermal mass × thermal resistance (just like electrical RC). Nothing changes temperature fast unless it's tiny or you dump huge power into it. The slowest domain in a chain sets the system's bandwidth.

## 3. What to build

*← hands on the bench*

1. Twist chromel and alumel wire together with a torch to make a Type K thermocouple. Dip the junction in boiling water, then ice water. Read millivolts on a meter.
2. Hook a Peltier to a battery. One side gets cold, one side gets hot. Flip the polarity. The sides swap.
3. Watch a bimetal strip bend in the flame of a candle. Count seconds — that's its time constant.
4. Fill a mug with hot water. Measure the temperature every minute for an hour. Fit an exponential. That's your lumped RC model.

Full BOM and build steps: [course04 Bench 5](../course04/05-bench-thermal.md).

## 4. Key materials

*← what it's made of*

- **Thermocouples:** chromel-alumel (Type K, general), iron-constantan (Type J), Pt/Rh (high temperature, laboratory accuracy).
- **RTDs:** pure platinum. Pt100 and Pt1000 are everywhere stability matters.
- **Thermistors:** metal-oxide ceramics. High sensitivity, nonlinear.
- **Thermoelectric modules:** bismuth telluride.
- **Shape memory:** Nitinol — one alloy that remembers its shape and springs back when heated. Medical stents, aerospace deployments, thermostatic valves.
- **Bimetals:** Invar bonded to brass or steel.

## 5. Key techniques

*← how it's made*

- Bead welding of thermocouple wires.
- Mineral-insulated sheath construction — wires inside MgO powder inside Inconel. Survives furnaces, reactors, exhausts.
- Shape-setting of Nitinol — constrain the wire in a jig, anneal at 500 °C. It now "remembers" that shape and returns to it on heating. One technique, enormous consequences.
- Zone-melting of Bi₂Te₃ — crystals grown with the right orientation for maximum thermoelectric efficiency.

## 6. The clever trick

*← what unlocked the industry*

**Nitinol's phase transformation.** Two phases, austenite (hot) and martensite (cold). Deform it cold, heat it, it springs back to the "remembered" shape. ~5% reversible strain. Used in heart stents that are threaded in cold, then warm to body temperature and open. One alloy, one anneal, and you get a thermal actuator with no motor, no gears, no bearings.

## 7. Who to know

*← short lineage of names*

Fourier (heat equation), Seebeck (thermocouple effect), Peltier (thermoelectric cooling), Buehler and Wang (Nitinol, 1962, at the Naval Ordnance Lab).

Year-by-year table of what each one measured and with which equipment: [course03 Domain 5](../course03/05-thermal/README.md#2-measurement).

## 8. The example everyone should work

*← optional — work it with pencil and paper*

A mug of coffee cooling on a desk, as a lumped RC model (Bench 5, build 4 measures this):

1. Thermal mass: 300 g of water, c = 4,186 J/(kg·K) → C_θ = 0.3 × 4,186 = 1,256 J/K.
2. Surface area (8 cm diameter, 10 cm tall, open top): side π · 0.08 · 0.10 = 0.025 m², top π · 0.04² = 0.005 m², total A ≈ 0.030 m².
3. Heat-transfer coefficient for still air (convection + radiation together): h ≈ 10 W/(m²·K).
4. Thermal resistance: R_θ = 1 / (h·A) = 1 / (10 × 0.030) = 3.3 K/W.
5. Time constant: τ = R_θ · C_θ = 3.3 × 1,256 ≈ 4,160 s ≈ 70 minutes.
6. Prediction: from 80 °C in a 22 °C room, T(t) = 22 + 58·e^(−t/τ). After 30 minutes: 22 + 58·e^(−0.43) ≈ 60 °C.

Measure it and you'll find it cools faster — evaporation from the open top is a second heat path the model left out. Add a lid and the model gets better. That's why thermal bandwidth is measured in minutes, and why the slowest domain sets the bandwidth.

More practice: the "Try it" exercises in [Module 5](index.md#module-5--thermal-domain).

## 9. What to read later

*← optional — where to go deeper*

- [Fraden, *Handbook of Modern Sensors*](../course02/06-fraden-handbook-of-modern-sensors/)
- [Incropera & DeWitt, *Fundamentals of Heat and Mass Transfer*](../course02/11-incropera-dewitt-heat-and-mass-transfer/)
