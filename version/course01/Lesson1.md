# Lesson 1 — Electrical

[← Lesson 8 — Foundations](Lesson8.md) · [All lessons](index.md#lessons) · [Lesson 2 — Magnetic →](Lesson2.md)

> Domain 1 of 7, in nine steps: start with something you can hold, get one mental model, build it, then learn what it's made of, how it's made, what trick unlocked it, and who got there first.
>
> New to the course? Work [Lesson 8 — Foundations](Lesson8.md) first.

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

**Theory:** [Module 1](index.md#module-1--electrical-domain) · **Stack:** [course03/01-electrical](../course03/01-electrical/README.md) · **Bench:** [course04/01-bench-electrical](../course04/01-bench-electrical.md)

## 1. What you're looking at

*← start concrete*

A circuit board, a resistor, a capacitor, an op-amp, a battery. All of them move charge around. All of them are made of a conductor, an insulator, and sometimes a semiconductor between them.

## 2. The one thing to understand

*← give the mental model*

Voltage pushes current through resistance. That's Ohm's law, and 90% of electrical engineering is dressed-up versions of it.

## 3. What to build

*← hands on the bench*

1. Light an LED from a 9 V battery with a current-limiting resistor. Pick the resistor value yourself.
2. Make an RC filter with a resistor and a capacitor. Watch an input square wave become a smoothed curve on an oscilloscope (or a phone-based scope).
3. Breadboard an op-amp as a non-inverting amplifier with gain 10. Verify the gain.

Full BOM and build steps: [course04 Bench 1](../course04/01-bench-electrical.md).

## 4. Key materials

*← what it's made of*

Copper (conducts), aluminum (conducts cheap), nichrome (resists), ceramic / tantalum / polymer film (insulate while storing charge), silicon (switches).

## 5. Key techniques

*← how it's made*

Drawing wire, electroplating, sputtering thin films, photolithography on silicon, printing on fiberglass boards and soldering parts to them. The techniques got cheaper every decade; that's why there's electronics in a $5 flashlight.

## 6. The clever trick

*← what unlocked the industry*

**Photolithography.** Someone realized that if you project a pattern onto a photosensitive layer on silicon, you can etch nanometer features in parallel across a whole wafer. One trick turned electronics from a craft into a commodity.

## 7. Who to know

*← short lineage of names*

Volta (made steady current possible), Faraday (induction), Ohm (the law), Kirchhoff (the circuit), Bardeen/Brattain/Shockley (the transistor), Kilby/Noyce (the integrated circuit). Each one measured something new with the galvanometer of their day.

Year-by-year table of what each one measured and with which equipment: [course03 Domain 1](../course03/01-electrical/README.md#2-measurement).

## 8. The example everyone should work

*← optional — work it with pencil and paper*

A red LED on a 9 V battery, then a 1 kHz RC low-pass filter:

1. A red LED drops about V_LED ≈ 2.0 V. The resistor takes the rest: 9 − 2 = 7 V.
2. For 20 mA: R = 7 V / 0.020 A = 350 Ω. The nearest standard (E12) value above is 390 Ω.
3. Check the current: I = 7 / 390 = 17.9 mA — just under the target, which is where you want it.
4. Check the resistor's power: P = V² / R = 7² / 390 = 0.13 W. A 1/4 W resistor is fine.
5. Now the filter. The −3 dB corner is f = 1 / (2πRC). Pick C = 100 nF (easy to buy), then R = 1 / (2π · 1000 Hz · 100 nF) = 1,592 Ω.
6. The nearest standard (E24) value is 1.6 kΩ, giving f = 995 Hz.

Ohm's law sized the resistor; one time constant set the filter. Every pull-up, every LED, every anti-aliasing filter in front of an ADC is one of these two calculations.

More practice: the "Try it" exercises in [Module 1](index.md#module-1--electrical-domain).

## 9. What to read later

*← optional — where to go deeper*

Any introductory electronics book. *The Art of Electronics* (Horowitz & Hill) if you're serious. → [course02](../course02/04-horowitz-hill-art-of-electronics/)
