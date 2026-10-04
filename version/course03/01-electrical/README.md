# Domain 1 — Electrical

[← Course 03 index](../index.md) · [← Pillar 3](../p3-bandwidth-and-ceiling.md) · [Domain 2 — Magnetic →](../02-magnetic/README.md)

**Effort:** Voltage (V) · **Flow:** Current (I) · **Power:** V × I

**Lesson:** [course01 Lesson 1](../../course01/Lesson1.md) · **Theory:** [course01 Module 1](../../course01/index.md#module-1--electrical-domain) · **Bench:** [course04 Bench 1](../../course04/01-bench-electrical.md)

> Hands on first (A–C), then the six layers from the bottom of the stack up (1–6), then back to the bench (D–E), then where to go next (F–G).

## A. What you're looking at

A circuit board, a resistor, a capacitor, an op-amp, a battery. All of them move charge around. All of them are made of a conductor, an insulator, and sometimes a semiconductor between them.

## B. The one thing to understand

Voltage pushes current through resistance. That's Ohm's law, and 90% of electrical engineering is dressed-up versions of it.

**Key relations:** V = IR · ∑I = 0 at a node · ∑V = 0 around a loop · ε = −dΦ/dt · P = VI (AC: P = VI cos φ) · E = ½CV² · E = ½LI².

## C. This pile on the three pillars

| Pillar | At this pile |
|---|---|
| [1 · Arrows between piles](../p1-arrows-between-piles.md) | Microphone: sound (mechanical) → electrical · Speaker: electrical → sound · Motor: electrical → magnetic → mechanical · Thermocouple: thermal → electrical · Camera: radiant → electrical |
| [2 · Material + technique](../p2-material-and-technique.md) | See [4. Material](#4-material) and [5. Technique](#5-technique) below |
| [3 · Bandwidth](../p3-bandwidth-and-ceiling.md) | MHz–GHz — limited by parasitics |
| [3 · Ceiling (energy density)](../p3-bandwidth-and-ceiling.md) | — |
| Role | Universal output domain of sensors; input domain of most actuators. |
| As sensor input / actuator output | Common (signal) / Rare (electrostatic) |
| Characteristic effects | Ohm's law, Kirchhoff's laws, Faraday's law, resistive heating. |

## 1. Vocabulary

*The terms that let you reason about everything below.*

| Term | Meaning |
|---|---|
| Voltage (V, EMF) | Electrical potential difference; "pressure" that drives current. Unit: volt. |
| Current (I) | Flow of charge through a conductor. Unit: ampere. |
| Charge (Q) | Quantity of electricity. Unit: coulomb. |
| Resistance (R) | Opposition to current flow (V = IR). Unit: ohm. |
| Conductance (G) | Inverse of resistance. Unit: siemens. |
| Capacitance (C) | Charge stored per volt (Q = CV). Unit: farad. |
| Inductance (L) | EMF induced per rate of change of current. Unit: henry. |
| Impedance (Z) | Generalized AC opposition (resistance + reactance). |
| Reactance (X) | Impedance of capacitors/inductors at a frequency. |
| Admittance (Y) | Inverse of impedance. |
| Power (P) | V × I; real, reactive, apparent in AC. |
| Node, loop, branch | Topological terms for Kirchhoff's laws. |
| A/D & D/A conversion | Discretizing or reconstructing analog signals. |
| Noise (thermal, shot, 1/f) | Fundamental random voltage/current fluctuations. |

## 2. Measurement

*The instruments that first saw each effect.*

| Year | Discoverer | What was measured | Equipment used |
|---|---|---|---|
| 1800 | Alessandro Volta | Steady current from a chemical pile | Stacked Cu/Zn discs with brine, electroscope |
| 1820 | Hans Christian Ørsted | Compass deflection near a current-carrying wire | Voltaic pile, wire, magnetic compass |
| 1826 | Georg Ohm | Current through calibrated wires | Thermocouple source, torsion galvanometer |
| 1831 | Michael Faraday | Induced current from a moving magnet | Iron ring + coils + battery + galvanometer |
| 1845 | Gustav Kirchhoff | Branch currents, node voltages | Galvanometer, decade boxes, Daniell cells |
| 1948 | Bardeen, Brattain, Shockley | Current gain in a point-contact device | Germanium crystal, gold foil contacts, oscilloscope |
| 1958 | Kilby & Noyce | First working integrated circuits | Ge/Si wafers, photo masks, diffusion furnaces |

## 3. Discovery

*The physical effects themselves.*

| Year | Effect / law | Discoverer |
|---|---|---|
| 1800 | Voltaic pile — first steady current | Volta |
| 1826 | Ohm's law | Ohm |
| 1831 | Electromagnetic induction | Faraday |
| 1845 | Circuit laws | Kirchhoff |
| 1948 | Transistor | Bardeen, Brattain, Shockley |
| 1958 | Integrated circuit | Kilby, Noyce |

### Who to know

Volta (made steady current possible), Faraday (induction), Ohm (the law), Kirchhoff (the circuit), Bardeen/Brattain/Shockley (the transistor), Kilby/Noyce (the integrated circuit). Each one measured something new with the galvanometer of their day.

## 4. Material

*What carries the effect.*

Copper (conducts), aluminum (conducts cheap), nichrome (resists), ceramic / tantalum / polymer film (insulate while storing charge), silicon (switches).

## 5. Technique

*How the material becomes a device.*

Drawing wire, electroplating, sputtering thin films, photolithography on silicon, printing on fiberglass boards and soldering parts to them. The techniques got cheaper every decade; that's why there's electronics in a $5 flashlight.

### The clever trick

**Photolithography.** Someone realized that if you project a pattern onto a photosensitive layer on silicon, you can etch nanometer features in parallel across a whole wafer. One trick turned electronics from a craft into a commodity.

### Signature techniques

Photolithography, PCB manufacturing, laser trimming, reflow soldering.

## 6. Features

*What the material + technique combination gives you.*

| Function | Material | Technique | Features |
|---|---|---|---|
| Conductors | Copper, aluminum | Drawing, electroplating | Low loss, solderable |
| Resistors | Nichrome, metal foil | Sputtering, laser trim | Low TCR, precise |
| Dielectrics | Ceramic, tantalum, polymer film | Tape casting, sintering | High k, low leakage |
| Semiconductors | Si, GaAs, SiC, GaN | Czochralski, epitaxy, lithography | Scalable, integrable |
| Magnetic cores (electrical use) | Ferrite, silicon steel | Lamination, powder pressing | Low-loss inductors/transformers |

Signal-conditioning toolbox: amplification (op-amps, instrumentation amps) · filtering (RC, LC, active) · isolation (optocouplers, transformers, isolation amps) · A/D conversion (resolution vs. accuracy, sampling theorem, aliasing).

## D. What to build

1. Light an LED from a 9 V battery with a current-limiting resistor. Pick the resistor value yourself.
2. Make an RC filter with a resistor and a capacitor. Watch an input square wave become a smoothed curve on an oscilloscope (or a phone-based scope).
3. Breadboard an op-amp as a non-inverting amplifier with gain 10. Verify the gain.

Full BOM and build steps: [course04 Bench 1](../../course04/01-bench-electrical.md).

## E. The example everyone should work

A red LED on a 9 V battery, then a 1 kHz RC low-pass filter:

1. A red LED drops about V_LED ≈ 2.0 V. The resistor takes the rest: 9 − 2 = 7 V.
2. For 20 mA: R = 7 V / 0.020 A = 350 Ω. The nearest standard (E12) value above is 390 Ω.
3. Check the current: I = 7 / 390 = 17.9 mA — just under the target, which is where you want it.
4. Check the resistor's power: P = V² / R = 7² / 390 = 0.13 W. A 1/4 W resistor is fine.
5. Now the filter. The −3 dB corner is f = 1 / (2πRC). Pick C = 100 nF (easy to buy), then R = 1 / (2π · 1000 Hz · 100 nF) = 1,592 Ω.
6. The nearest standard (E24) value is 1.6 kΩ, giving f = 995 Hz.

Ohm's law sized the resistor; one time constant set the filter. Every pull-up, every LED, every anti-aliasing filter in front of an ADC is one of these two calculations.

## F. What to read later

Any introductory electronics book. *The Art of Electronics* (Horowitz & Hill) if you're serious. → [course02](../../course02/04-horowitz-hill-art-of-electronics/)

- [Horowitz & Hill, *The Art of Electronics*](../../course02/04-horowitz-hill-art-of-electronics/) — the electrical pile, done right.
- [Fraden, *Handbook of Modern Sensors*](../../course02/06-fraden-handbook-of-modern-sensors/)

## G. Related in other courses

- **Lesson:** [course01 — Lesson 1: Electrical](../../course01/Lesson1.md)
- **Course:** [course01 — Module 1: Electrical Domain](../../course01/index.md#module-1--electrical-domain)
- **Bench:** [course04 — Bench 1: Electrical](../../course04/01-bench-electrical.md)
- **Manufacturers:** [course05 — Manufacturers & Brands](../../course05/index.md)
