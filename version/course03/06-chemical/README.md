# Domain 6 — Chemical

[← Course 03 index](../index.md) · [← Domain 5 — Thermal](../05-thermal/README.md) · [Domain 7 — Radiant →](../07-radiant/README.md)

**State variable:** Concentration / activity · **Note:** does not fit the clean effort × flow pattern

**Lesson:** [course01 Lesson 6](../../course01/Lesson6.md) · **Theory:** [course01 Module 6](../../course01/index.md#module-6--chemical-domain) · **Bench:** [course04 Bench 6](../../course04/06-bench-chemical.md)

> Hands on first (A–C), then the six layers from the bottom of the stack up (1–6), then back to the bench (D–E).

## A. What you're looking at

A pH probe. A glucose test strip. A smoke detector. A CO sensor. A fuel cell.

## B. The one thing to understand

Put two different metals in a conductive solution and you get a voltage. The voltage depends on what's dissolved. If you can arrange for a specific chemical to change that voltage reliably, you have a sensor for it. The Nernst equation turns concentration into millivolts: about 59 mV per decade of concentration change at room temperature.

**Key relation:** E = E° − (RT / nF) · ln(Q) — ~59 mV per decade at 25 °C, n = 1.

## C. This pile on the three pillars

| Pillar | At this pile |
|---|---|
| [1 · Arrows between piles](../p1-arrows-between-piles.md) | Glucose strip: chemical → electrical (Clark & Lyons — "measure glucose" becomes "measure current") |
| [2 · Material + technique](../p2-material-and-technique.md) | See [4. Material](#4-material) and [5. Technique](#5-technique) below |
| [3 · Bandwidth](../p3-bandwidth-and-ceiling.md) | 0.001–1 Hz — limited by diffusion, reaction kinetics |
| [3 · Ceiling (energy density)](../p3-bandwidth-and-ceiling.md) | Chemical (fuel): very high (hydrocarbons, hydrogen; combustion) |
| Role | Core sensing in process industry, medicine, environment. |
| As sensor input / actuator output | Common (process) / Very rare |

## 1. Vocabulary

*The terms that let you reason about everything below.*

| Term | Meaning |
|---|---|
| Concentration | Amount per volume (mol/L, ppm). |
| Activity | Effective concentration (what the Nernst equation uses). |
| pH | −log₁₀[H⁺]. |
| Electrode potential (E) | Voltage of a half-cell vs. reference. |
| Reference electrode | Known, stable potential (Ag/AgCl, calomel, SHE). |
| Nernst equation | E = E° − (RT/nF) ln(Q); concentration-to-voltage relation. |
| Diffusion-limited current | Current limited by analyte diffusion to the electrode. |
| Amperometric / potentiometric | Measure current / voltage. |
| Selectivity | Response to target vs. interferents. |
| Sensitivity | Signal change per concentration change. |
| Limit of detection (LOD) | Lowest reliably detected concentration. |
| Enzyme kinetics (Km, Vmax) | Describes biosensor response. |
| Fuel cell / electrolysis | Chemical ↔ electrical energy conversion. |

## 2. Measurement

*The instruments that first saw each effect.*

| Year | Discoverer | What was measured | Equipment used |
|---|---|---|---|
| 1800 | Volta | Steady current from a pile | Voltaic pile, electroscope |
| 1834 | Faraday | Mass deposited per unit charge | Electrolytic cells, balances |
| 1839 | Grove | Current from H₂/O₂ cell | Pt electrodes in dilute H₂SO₄, galvanometer |
| 1889 | Nernst | EMF of half-cells vs. concentration | Hydrogen electrode, salt bridges, potentiometer |
| 1909 | Sørensen | H⁺ activity in buffers | Hydrogen electrode, calomel reference |
| 1956 | Clark | Dissolved O₂ as diffusion current | Pt cathode, Ag/AgCl anode, polyethylene membrane |
| 1962 | Clark & Lyons | Glucose via O₂ consumption | Clark electrode + glucose oxidase membrane |

## 3. Discovery

*The physical effects themselves.*

| Year | Effect / law | Discoverer |
|---|---|---|
| 1800 | Voltaic pile | Volta |
| 1834 | Laws of electrolysis | Faraday |
| 1839 | Fuel cell | Grove |
| 1889 | Nernst equation | Nernst |
| 1909 | pH scale | Sørensen |
| 1956 | Clark oxygen electrode | Clark |
| 1962 | Enzyme electrode | Clark, Lyons |

### Who to know

Volta (pile), Faraday (electrolysis), Grove (fuel cell, 1839), Nernst (the equation), Sørensen (pH), Clark (oxygen electrode, 1956; enzyme electrode, 1962).

## 4. Material

*What carries the effect.*

- **Electrodes:** platinum (universal), gold (biosensors), silver/silver chloride (reference), glassy carbon (electrochemistry).
- **pH-sensitive membrane:** specially formulated lithium silicate glass.
- **Ion-selective membranes:** PVC loaded with ionophores (e.g., valinomycin for potassium).
- **Metal-oxide gas sensors:** SnO₂, ZnO, WO₃ — operated hot (~400 °C) so adsorbed gas changes conductivity.
- **Biosensors:** enzymes (glucose oxidase), antibodies, aptamers.
- **Fuel cells:** Nafion membrane, platinum catalyst.

## 5. Technique

*How the material becomes a device.*

- **Enzyme immobilization** — crosslinking with glutaraldehyde, entrapment in a gel, self-assembled monolayers. Hundreds of millions of glucose test strips a year.
- **Screen-printing of electrodes** — carbon and silver inks on plastic. Disposable biosensors cost pennies to make.
- **Nafion membrane casting** — the proton-conducting plastic that makes PEM fuel cells work.

### The clever trick

**Clark and Lyons, 1962.** Spread glucose oxidase on a membrane over a Clark oxygen electrode. Glucose consumes oxygen as the enzyme oxidizes it. Less O₂ = less current. You've just turned "measure glucose" into "measure current." That one trick is the entire glucose-meter industry.

### Signature techniques

Enzyme immobilization, screen-printed electrodes, Nafion membrane casting, sol-gel deposition.

## 6. Features

*What the material + technique combination gives you.*

| Function | Material | Technique | Features |
|---|---|---|---|
| Electrodes | Pt, Au, Ag/AgCl, glassy carbon | Electroplating, screen-printing, sputtering | Stable, catalytic |
| pH membrane | Lithium silicate glass | Glass blowing, hydration | Nernstian H⁺ response |
| ISE membranes | PVC + ionophore; LaF₃ | Casting, crystal growth | Species-selective |
| Metal-oxide gas sensors | SnO₂, ZnO, WO₃ | Screen-print, sol-gel | Low cost, broad detection |
| Catalytic (pellistor) | Pt/Pd on Al₂O₃ bead | Wire coil + catalyst coating | Combustible-gas detection |
| Biosensor layers | Enzymes, antibodies, aptamers | Immobilization (crosslink, entrap, SAM) | Target-specific |
| Fuel-cell catalyst | Pt, Pt/Ru on carbon | Impregnation onto Nafion | High activity |

Sensor families: potentiometric (pH, ISEs) · amperometric (Clark electrode, glucose) · conductometric · metal-oxide semiconductor (SnO₂, hot) · optical (colorimetric strips, fluorescent probes).

## D. What to build

1. Volta's pile: alternate zinc and copper coins separated by brine-soaked cardboard. Measure a few volts on a stack of ten.
2. Dip two bits of different metals in salty water. Measure the voltage. Change the salinity. Watch it shift.
3. Buy a $20 pH meter. Open the probe (carefully — the glass bulb is fragile). Note how little is inside: a glass membrane, a wire, a reference, a connector.

Full BOM and build steps: [course04 Bench 6](../../course04/06-bench-chemical.md).

## E. The example everyone should work

Two copper strips in copper sulfate at different concentrations — a concentration cell (Bench 6, build 2):

1. Nernst: E = (RT / nF) · ln(c₁ / c₂). At 25 °C, RT/F · ln(10) = 59.16 mV, so E = (59.16 mV / n) · log₁₀(c₁ / c₂).
2. For Cu²⁺ + 2e⁻ → Cu, n = 2: each decade of concentration is worth 59.16 / 2 = 29.6 mV.
3. Use 0.1 M on one side and 0.001 M on the other: two decades → E = 29.6 × 2 = 59 mV.
4. The more concentrated side is the positive electrode (copper plates out there; it dissolves on the dilute side).
5. Same law, n = 1, gives the pH probe: 59.16 mV per pH unit. Between the pH 4 and pH 7 buffers you should read 3 × 59.16 = 177 mV.
6. If your probe reads 170 mV across that span, its slope is 170 / 177 = 96% — that's what a pH meter's calibration screen is reporting.

Millivolts per decade: one equation turns concentration into voltage for pH probes, ion-selective electrodes and every reference electrode.

## F. What to read later

- [Bard & Faulkner, *Electrochemical Methods*](../../course02/07-bard-faulkner-electrochemical-methods/) — the chemical pile.
- [Wang, *Electrochemical Sensors, Biosensors, and Their Biomedical Applications*](../../course02/12-wang-electrochemical-sensors-biosensors/) — biosensors.

## G. Related in other courses

- **Lesson:** [course01 — Lesson 6: Chemical](../../course01/Lesson6.md)
- **Course:** [course01 — Module 6: Chemical Domain](../../course01/index.md#module-6--chemical-domain)
- **Bench:** [course04 — Bench 6: Chemical](../../course04/06-bench-chemical.md)
- **Manufacturers:** [course05 — Manufacturers & Brands](../../course05/index.md)
