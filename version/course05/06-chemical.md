# Pile 6 — Chemical

[← Course 05 index](index.md) · [← Pile 5](05-thermal.md) · [Pile 7 →](07-radiant.md)

**Course:** [course01 Module 6](../course01/index.md#module-6--chemical-domain) · **Theory:** [course03/06-chemical](../course03/06-chemical/README.md) · **Bench:** [course04/06-bench-chemical](../course04/06-bench-chemical.md)

## What you're looking at

A pH probe. A glucose test strip. A smoke detector. A CO sensor. A fuel cell.

## The one thing to understand

Put two different metals in a conductive solution and you get a voltage. The voltage depends on what's dissolved. If you can arrange for a specific chemical to change that voltage reliably, you have a sensor for it. The Nernst equation turns concentration into millivolts: about 59 mV per decade of concentration change at room temperature.

## This pile on the three pillars

| Pillar | At this pile |
|---|---|
| [1 · Arrows between piles](p1-arrows-between-piles.md) | Glucose strip: chemical → electrical (Clark & Lyons — "measure glucose" becomes "measure current") |
| [2 · Material + technique](p2-material-and-technique.md) | See [Material + technique](#material--technique) below |
| [3 · Bandwidth](p3-bandwidth-and-ceiling.md) | 0.001–1 Hz — limited by diffusion, reaction kinetics |
| [3 · Ceiling (energy density)](p3-bandwidth-and-ceiling.md) | Chemical (fuel): very high (hydrocarbons, hydrogen; combustion) |
| Role | Core sensing in process industry, medicine, environment. |
| As sensor input / actuator output | Common (process) / Very rare |

## What to build

1. Volta's pile: alternate zinc and copper coins separated by brine-soaked cardboard. Measure a few volts on a stack of ten.
2. Dip two bits of different metals in salty water. Measure the voltage. Change the salinity. Watch it shift.
3. Buy a $20 pH meter. Open the probe (carefully — the glass bulb is fragile). Note how little is inside: a glass membrane, a wire, a reference, a connector.

## Material + technique

### Key materials

- **Electrodes:** platinum (universal), gold (biosensors), silver/silver chloride (reference), glassy carbon (electrochemistry).
- **pH-sensitive membrane:** specially formulated lithium silicate glass.
- **Ion-selective membranes:** PVC loaded with ionophores (e.g., valinomycin for potassium).
- **Metal-oxide gas sensors:** SnO₂, ZnO, WO₃ — operated hot (~400 °C) so adsorbed gas changes conductivity.
- **Biosensors:** enzymes (glucose oxidase), antibodies, aptamers.
- **Fuel cells:** Nafion membrane, platinum catalyst.

### Key techniques

- **Enzyme immobilization** — crosslinking with glutaraldehyde, entrapment in a gel, self-assembled monolayers. Hundreds of millions of glucose test strips a year.
- **Screen-printing of electrodes** — carbon and silver inks on plastic. Disposable biosensors cost pennies to make.
- **Nafion membrane casting** — the proton-conducting plastic that makes PEM fuel cells work.

### The clever trick

**Clark and Lyons, 1962.** Spread glucose oxidase on a membrane over a Clark oxygen electrode. Glucose consumes oxygen as the enzyme oxidizes it. Less O₂ = less current. You've just turned "measure glucose" into "measure current." That one trick is the entire glucose-meter industry.

### Materials, techniques, features

| Function | Material | Technique | Features |
|---|---|---|---|
| Electrodes | Pt, Au, Ag/AgCl, glassy carbon | Electroplating, screen-printing, sputtering | Stable, catalytic |
| pH membrane | Lithium silicate glass | Glass blowing, hydration | Nernstian H⁺ response |
| ISE membranes | PVC + ionophore; LaF₃ | Casting, crystal growth | Species-selective |
| Metal-oxide gas sensors | SnO₂, ZnO, WO₃ | Screen-print, sol-gel | Low cost, broad detection |
| Catalytic (pellistor) | Pt/Pd on Al₂O₃ bead | Wire coil + catalyst coating | Combustible-gas detection |
| Biosensor layers | Enzymes, antibodies, aptamers | Immobilization (crosslink, entrap, SAM) | Target-specific |
| Fuel-cell catalyst | Pt, Pt/Ru on carbon | Impregnation onto Nafion | High activity |

### Signature techniques

Enzyme immobilization, screen-printed electrodes, Nafion membrane casting, sol-gel deposition.

## Who to know

Volta (pile), Faraday (electrolysis), Grove (fuel cell, 1839), Nernst (the equation), Sørensen (pH), Clark (oxygen electrode, 1956; enzyme electrode, 1962).

### Discoverers — measurement and equipment

| Year | Discoverer | What was measured | Equipment used |
|---|---|---|---|
| 1800 | Volta | Steady current from a pile | Voltaic pile, electroscope |
| 1834 | Faraday | Mass deposited per unit charge | Electrolytic cells, balances |
| 1839 | Grove | Current from H₂/O₂ cell | Pt electrodes in dilute H₂SO₄, galvanometer |
| 1889 | Nernst | EMF of half-cells vs. concentration | Hydrogen electrode, salt bridges, potentiometer |
| 1909 | Sørensen | H⁺ activity in buffers | Hydrogen electrode, calomel reference |
| 1956 | Clark | Dissolved O₂ as diffusion current | Pt cathode, Ag/AgCl anode, polyethylene membrane |
| 1962 | Clark & Lyons | Glucose via O₂ consumption | Clark electrode + glucose oxidase membrane |

## Important terms

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

## What to read later

[Bard & Faulkner, *Electrochemical Methods*](../course02/07-bard-faulkner-electrochemical-methods/)
