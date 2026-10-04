# Pile 5 — Thermal

[← Course 05 index](index.md) · [← Pile 4](04-fluidic.md) · [Pile 6 →](06-chemical.md)

**Course:** [course01 Module 5](../course01/index.md#module-5--thermal-domain) · **Theory:** [course03/05-thermal](../course03/05-thermal/README.md) · **Bench:** [course04/05-bench-thermal](../course04/05-bench-thermal.md)

## What you're looking at

A thermocouple from a multimeter probe. A Peltier module from a USB mini-fridge. A bimetal strip from an old oven thermostat. A pot of water heating on the stove.

## The one thing to understand

Heat is slow. Everything thermal has a time constant equal to thermal mass × thermal resistance (just like electrical RC). Nothing changes temperature fast unless it's tiny or you dump huge power into it. The slowest domain in a chain sets the system's bandwidth.

## This pile on the three pillars

| Pillar | At this pile |
|---|---|
| [1 · Arrows between piles](p1-arrows-between-piles.md) | Thermocouple: thermal → electrical |
| [2 · Material + technique](p2-material-and-technique.md) | See [Material + technique](#material--technique) below |
| [3 · Bandwidth](p3-bandwidth-and-ceiling.md) | 0.01–10 Hz — limited by thermal mass |
| [3 · Ceiling (energy density)](p3-bandwidth-and-ceiling.md) | Thermal (SMA): low (Nitinol; shape-setting) |
| Role | Universal sensing; specialty actuation. |
| As sensor input / actuator output | Very common / Specialty |
| Characteristic effects | Fourier conduction, Newton cooling, Stefan–Boltzmann radiation. |

## What to build

1. Twist chromel and alumel wire together with a torch to make a Type K thermocouple. Dip the junction in boiling water, then ice water. Read millivolts on a meter.
2. Hook a Peltier to a battery. One side gets cold, one side gets hot. Flip the polarity. The sides swap.
3. Watch a bimetal strip bend in the flame of a candle. Count seconds — that's its time constant.
4. Fill a mug with hot water. Measure the temperature every minute for an hour. Fit an exponential. That's your lumped RC model.

## Material + technique

### Key materials

- **Thermocouples:** chromel-alumel (Type K, general), iron-constantan (Type J), Pt/Rh (high temperature, laboratory accuracy).
- **RTDs:** pure platinum. Pt100 and Pt1000 are everywhere stability matters.
- **Thermistors:** metal-oxide ceramics. High sensitivity, nonlinear.
- **Thermoelectric modules:** bismuth telluride.
- **Shape memory:** Nitinol — one alloy that remembers its shape and springs back when heated. Medical stents, aerospace deployments, thermostatic valves.
- **Bimetals:** Invar bonded to brass or steel.

### Key techniques

- Bead welding of thermocouple wires.
- Mineral-insulated sheath construction — wires inside MgO powder inside Inconel. Survives furnaces, reactors, exhausts.
- Shape-setting of Nitinol — constrain the wire in a jig, anneal at 500 °C. It now "remembers" that shape and returns to it on heating. One technique, enormous consequences.
- Zone-melting of Bi₂Te₃ — crystals grown with the right orientation for maximum thermoelectric efficiency.

### The clever trick

**Nitinol's phase transformation.** Two phases, austenite (hot) and martensite (cold). Deform it cold, heat it, it springs back to the "remembered" shape. ~5% reversible strain. Used in heart stents that are threaded in cold, then warm to body temperature and open. One alloy, one anneal, and you get a thermal actuator with no motor, no gears, no bearings.

### Materials, techniques, features

| Function | Material | Technique | Features |
|---|---|---|---|
| Thermocouples | Chromel/alumel, Pt/Rh | Bead welding, MI sheath assembly | Wide range, rugged, self-powered |
| RTDs | Pt, Ni, Cu | Thin-film on ceramic, laser trim | High accuracy, stability |
| Thermistors | Mn/Ni/Co oxide ceramic | Powder pressing, sintering | High sensitivity, nonlinear |
| IR detectors | HgCdTe, InSb, LiTaO₃, VOx bolometer | Epitaxy, ROIC bonding, MEMS microbolometer | Non-contact, imaging |
| TE modules | Bi₂Te₃ | Zone-melted, ceramic plates | Solid-state cooling |
| SMAs | Nitinol (NiTi) | Vacuum melting, shape-setting anneal | ~5% reversible strain |
| Bimetal | Invar + brass/steel | Rolling, bonding | Simple passive switching |

### Signature techniques

Shape-setting of Nitinol; MEMS microbolometer arrays; mineral-insulated thermocouple cable; zone-melting of Bi₂Te₃.

## Who to know

Fourier (heat equation), Seebeck (thermocouple effect), Peltier (thermoelectric cooling), Buehler and Wang (Nitinol, 1962, at the Naval Ordnance Lab).

### Discoverers — measurement and equipment

| Year | Discoverer | What was measured | Equipment used |
|---|---|---|---|
| 1807 | Fourier | Temperature along a heated rod | Mercury thermometers, charcoal furnace |
| 1821 | Seebeck | Compass deflection beside bimetallic loop | Bi–Cu junctions, ice/boiling baths, compass |
| 1834 | Peltier | Temperature change at a current-carrying junction | Thermocouple-pair, battery, galvanometer |
| 1848 | Kelvin | Absolute temperature scale | Gas thermometers, mercury manometers |
| 1879–84 | Stefan & Boltzmann | Total radiated power vs. T | Blackbody cavity, thermopile, bolometer |
| 1962 | Buehler & Wang | Reversible NiTi phase transformation | Arc melter, Instron, DSC, water baths |

## Important terms

| Term | Meaning |
|---|---|
| Temperature (T) | Intensive measure of thermal energy. Unit: K, °C. |
| Heat (Q) / heat flow (dQ/dt) | Energy / power transferred thermally. |
| Specific heat (c) | Energy to raise 1 kg by 1 K. |
| Thermal mass | m × c; thermal "capacitance." |
| Thermal conductivity (k) | Fourier's law coefficient. Unit: W/(m·K). |
| Thermal resistance (R_θ) | ΔT per watt; analog of electrical resistance. |
| Thermal circuit | R_θ and C_θ network for lumped thermal modeling. |
| Thermal time constant (τ = R_θ C_θ) | How fast a mass heats or cools. |
| Conduction, convection, radiation | The three heat-transfer modes. |
| Emissivity (ε) | How effectively a surface radiates (0–1). |
| Blackbody / Stefan–Boltzmann | Radiation framework for IR sensing. |
| Seebeck coefficient (α) | Thermocouple voltage per K. |
| Peltier coefficient (Π) | Heat pumped per ampere at a junction. |
| Figure of merit (ZT) | Thermoelectric material quality. |
| Phase transformation (austenite ↔ martensite) | Mechanism behind SMAs. |
