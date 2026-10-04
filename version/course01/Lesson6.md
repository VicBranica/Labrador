# Lesson 6 — Chemical

[← Lesson 5 — Thermal](Lesson5.md) · [All lessons](index.md#lessons) · [Lesson 7 — Radiant →](Lesson7.md)

> Domain 6 of 7, in nine steps: start with something you can hold, get one mental model, build it, then learn what it's made of, how it's made, what trick unlocked it, and who got there first.

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

**Theory:** [Module 6](index.md#module-6--chemical-domain) · **Stack:** [course03/06-chemical](../course03/06-chemical/README.md) · **Bench:** [course04/06-bench-chemical](../course04/06-bench-chemical.md)

## 1. What you're looking at

*← start concrete*

A pH probe. A glucose test strip. A smoke detector. A CO sensor. A fuel cell.

## 2. The one thing to understand

*← give the mental model*

Put two different metals in a conductive solution and you get a voltage. The voltage depends on what's dissolved. If you can arrange for a specific chemical to change that voltage reliably, you have a sensor for it. The Nernst equation turns concentration into millivolts: about 59 mV per decade of concentration change at room temperature.

## 3. What to build

*← hands on the bench*

1. Volta's pile: alternate zinc and copper coins separated by brine-soaked cardboard. Measure a few volts on a stack of ten.
2. Dip two bits of different metals in salty water. Measure the voltage. Change the salinity. Watch it shift.
3. Buy a $20 pH meter. Open the probe (carefully — the glass bulb is fragile). Note how little is inside: a glass membrane, a wire, a reference, a connector.

Full BOM and build steps: [course04 Bench 6](../course04/06-bench-chemical.md).

## 4. Key materials

*← what it's made of*

- **Electrodes:** platinum (universal), gold (biosensors), silver/silver chloride (reference), glassy carbon (electrochemistry).
- **pH-sensitive membrane:** specially formulated lithium silicate glass.
- **Ion-selective membranes:** PVC loaded with ionophores (e.g., valinomycin for potassium).
- **Metal-oxide gas sensors:** SnO₂, ZnO, WO₃ — operated hot (~400 °C) so adsorbed gas changes conductivity.
- **Biosensors:** enzymes (glucose oxidase), antibodies, aptamers.
- **Fuel cells:** Nafion membrane, platinum catalyst.

## 5. Key techniques

*← how it's made*

- **Enzyme immobilization** — crosslinking with glutaraldehyde, entrapment in a gel, self-assembled monolayers. Hundreds of millions of glucose test strips a year.
- **Screen-printing of electrodes** — carbon and silver inks on plastic. Disposable biosensors cost pennies to make.
- **Nafion membrane casting** — the proton-conducting plastic that makes PEM fuel cells work.

## 6. The clever trick

*← what unlocked the industry*

**Clark and Lyons, 1962.** Spread glucose oxidase on a membrane over a Clark oxygen electrode. Glucose consumes oxygen as the enzyme oxidizes it. Less O₂ = less current. You've just turned "measure glucose" into "measure current." That one trick is the entire glucose-meter industry.

## 7. Who to know

*← short lineage of names*

Volta (pile), Faraday (electrolysis), Grove (fuel cell, 1839), Nernst (the equation), Sørensen (pH), Clark (oxygen electrode, 1956; enzyme electrode, 1962).

Year-by-year table of what each one measured and with which equipment: [course03 Domain 6](../course03/06-chemical/README.md#2-measurement).

## 8. The example everyone should work

*← optional — work it with pencil and paper*

Two copper strips in copper sulfate at different concentrations — a concentration cell (Bench 6, build 2):

1. Nernst: E = (RT / nF) · ln(c₁ / c₂). At 25 °C, RT/F · ln(10) = 59.16 mV, so E = (59.16 mV / n) · log₁₀(c₁ / c₂).
2. For Cu²⁺ + 2e⁻ → Cu, n = 2: each decade of concentration is worth 59.16 / 2 = 29.6 mV.
3. Use 0.1 M on one side and 0.001 M on the other: two decades → E = 29.6 × 2 = 59 mV.
4. The more concentrated side is the positive electrode (copper plates out there; it dissolves on the dilute side).
5. Same law, n = 1, gives the pH probe: 59.16 mV per pH unit. Between the pH 4 and pH 7 buffers you should read 3 × 59.16 = 177 mV.
6. If your probe reads 170 mV across that span, its slope is 170 / 177 = 96% — that's what a pH meter's calibration screen is reporting.

Millivolts per decade: one equation turns concentration into voltage for pH probes, ion-selective electrodes and every reference electrode.

More practice: the "Try it" exercises in [Module 6](index.md#module-6--chemical-domain).

## 9. What to read later

*← optional — where to go deeper*

[Bard & Faulkner, *Electrochemical Methods*](../course02/07-bard-faulkner-electrochemical-methods/) · [Wang, *Electrochemical Sensors, Biosensors, and Their Biomedical Applications*](../course02/12-wang-electrochemical-sensors-biosensors/)
