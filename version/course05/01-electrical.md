# Pile 1 — Electrical

[← Course 05 index](index.md) · [← Pillar 3 — Bandwidth and ceiling](p3-bandwidth-and-ceiling.md) · [Pile 2 →](02-magnetic.md)

**Course:** [course01 Module 1](../course01/index.md#module-1--electrical-domain) · **Theory:** [course03/01-electrical](../course03/01-electrical/README.md) · **Bench:** [course04/01-bench-electrical](../course04/01-bench-electrical.md)

## What you're looking at

A circuit board, a resistor, a capacitor, an op-amp, a battery. All of them move charge around. All of them are made of a conductor, an insulator, and sometimes a semiconductor between them.

## The one thing to understand

Voltage pushes current through resistance. That's Ohm's law, and 90% of electrical engineering is dressed-up versions of it.

## This pile on the three pillars

| Pillar | At this pile |
|---|---|
| [1 · Arrows between piles](p1-arrows-between-piles.md) | Microphone: sound (mechanical) → electrical · Speaker: electrical → sound · Motor: electrical → magnetic → mechanical · Thermocouple: thermal → electrical · Camera: radiant → electrical |
| [2 · Material + technique](p2-material-and-technique.md) | See [Material + technique](#material--technique) below |
| [3 · Bandwidth](p3-bandwidth-and-ceiling.md) | MHz–GHz — limited by parasitics |
| [3 · Ceiling (energy density)](p3-bandwidth-and-ceiling.md) | — |
| Role | Universal output domain of sensors; input domain of most actuators. |
| As sensor input / actuator output | Common (signal) / Rare (electrostatic) |
| Characteristic effects | Ohm's law, Kirchhoff's laws, Faraday's law, resistive heating. |

## What to build

1. Light an LED from a 9 V battery with a current-limiting resistor. Pick the resistor value yourself.
2. Make an RC filter with a resistor and a capacitor. Watch an input square wave become a smoothed curve on an oscilloscope (or a phone-based scope).
3. Breadboard an op-amp as a non-inverting amplifier with gain 10. Verify the gain.

## Material + technique

### Key materials

Copper (conducts), aluminum (conducts cheap), nichrome (resists), ceramic / tantalum / polymer film (insulate while storing charge), silicon (switches).

### Key techniques

Drawing wire, electroplating, sputtering thin films, photolithography on silicon, printing on fiberglass boards and soldering parts to them. The techniques got cheaper every decade; that's why there's electronics in a $5 flashlight.

### The clever trick

**Photolithography.** Someone realized that if you project a pattern onto a photosensitive layer on silicon, you can etch nanometer features in parallel across a whole wafer. One trick turned electronics from a craft into a commodity.

### Materials, techniques, features

| Function | Material | Technique | Features |
|---|---|---|---|
| Conductors | Copper, aluminum | Drawing, electroplating | Low loss, solderable |
| Resistors | Nichrome, metal foil | Sputtering, laser trim | Low TCR, precise |
| Dielectrics | Ceramic, tantalum, polymer film | Tape casting, sintering | High k, low leakage |
| Semiconductors | Si, GaAs, SiC, GaN | Czochralski, epitaxy, lithography | Scalable, integrable |
| Magnetic cores (electrical use) | Ferrite, silicon steel | Lamination, powder pressing | Low-loss inductors/transformers |

### Signature techniques

Photolithography, PCB manufacturing, laser trimming, reflow soldering.

## Who to know

Volta (made steady current possible), Faraday (induction), Ohm (the law), Kirchhoff (the circuit), Bardeen/Brattain/Shockley (the transistor), Kilby/Noyce (the integrated circuit). Each one measured something new with the galvanometer of their day.

### Discoverers — measurement and equipment

| Year | Discoverer | What was measured | Equipment used |
|---|---|---|---|
| 1800 | Alessandro Volta | Steady current from a chemical pile | Stacked Cu/Zn discs with brine, electroscope |
| 1820 | Hans Christian Ørsted | Compass deflection near a current-carrying wire | Voltaic pile, wire, magnetic compass |
| 1826 | Georg Ohm | Current through calibrated wires | Thermocouple source, torsion galvanometer |
| 1831 | Michael Faraday | Induced current from a moving magnet | Iron ring + coils + battery + galvanometer |
| 1845 | Gustav Kirchhoff | Branch currents, node voltages | Galvanometer, decade boxes, Daniell cells |
| 1948 | Bardeen, Brattain, Shockley | Current gain in a point-contact device | Germanium crystal, gold foil contacts, oscilloscope |
| 1958 | Kilby & Noyce | First working integrated circuits | Ge/Si wafers, photo masks, diffusion furnaces |

## Important terms

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

## What to read later

Any introductory electronics book. *The Art of Electronics* (Horowitz & Hill) if you're serious. → [course02](../course02/04-horowitz-hill-art-of-electronics/)
