# Electrical Domain — Six-Layer Stack

**Effort:** Voltage (V) · **Flow:** Current (I) · **Power:** V × I

## 1. Vocabulary

Voltage · Current · Charge · Resistance · Conductance · Capacitance · Inductance · Impedance · Reactance · Admittance · Power (real, reactive, apparent) · Node / loop / branch · A/D & D/A conversion · Noise (thermal, 1/f, shot).

Key relations: V = IR · ∑I = 0 at a node · ∑V = 0 around a loop · ε = −dΦ/dt · P = VI (AC: P = VI cos φ) · E = ½CV² · E = ½LI².

## 2. Measurement

| Year | Who | Instrument | What it saw |
|---|---|---|---|
| 1800 | Volta | Voltaic pile, electroscope | Steady current from pile |
| 1826 | Ohm | Thermocouple source, torsion galvanometer | Current vs. wire length |
| 1831 | Faraday | Iron ring + coils + galvanometer | Induced current from moving magnet |
| 1845 | Kirchhoff | Galvanometer, decade boxes | Branch currents, node voltages |
| 1948 | Bardeen, Brattain, Shockley | Oscilloscope, probe station | Current gain in Ge point-contact device |
| 1958 | Kilby & Noyce | Photomasks, diffusion furnaces | Integrated circuits |

## 3. Discovery

| Year | Effect / law | Discoverer |
|---|---|---|
| 1800 | Voltaic pile — first steady current | Volta |
| 1826 | Ohm's law | Ohm |
| 1831 | Electromagnetic induction | Faraday |
| 1845 | Circuit laws | Kirchhoff |
| 1948 | Transistor | Bardeen, Brattain, Shockley |
| 1958 | Integrated circuit | Kilby, Noyce |

## 4. Material

| Function | Material |
|---|---|
| Conductors | Cu, Al |
| Resistors | Nichrome, metal foil |
| Dielectrics | Ceramic, tantalum, polymer film |
| Semiconductors | Si, GaAs, SiC, GaN |
| Magnetic cores (electrical use) | Ferrite, silicon steel |

## 5. Technique

| Function | Technique |
|---|---|
| Conductors | Drawing, electroplating |
| Resistors | Sputtering, laser trim |
| Dielectrics | Tape-casting, sintering |
| Semiconductors | Czochralski, epitaxy, lithography |
| Magnetic cores | Lamination, powder pressing |

Signature techniques: photolithography · PCB manufacturing · laser trimming · reflow soldering.

## 6. Features

| Function | Feature |
|---|---|
| Conductors | Low loss |
| Resistors | Precise, low TCR |
| Dielectrics | High k, low leakage |
| Semiconductors | Integrable logic |
| Magnetic cores | Low-loss inductors |

Signal-conditioning toolbox: amplification (op-amps, instrumentation amps) · filtering (RC, LC, active) · isolation (optocouplers, transformers, isolation amps) · A/D conversion (resolution vs. accuracy, sampling theorem, aliasing).

## Sources

- [Course1 — Module 1: Electrical Domain](../../Course1/README.md#module-1--electrical-domain)
- [Horowitz & Hill, *The Art of Electronics*](../../course02/04-horowitz-hill-art-of-electronics/) — the electrical pile, done right.
- [Fraden, *Handbook of Modern Sensors*](../../course02/06-fraden-handbook-of-modern-sensors/)
