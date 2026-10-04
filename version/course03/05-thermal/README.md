# Domain 5 — Thermal

[← Course 03 index](../index.md) · [← Domain 4 — Fluidic](../04-fluidic/README.md) · [Domain 6 — Chemical →](../06-chemical/README.md)

**Effort:** Temperature (T) · **Flow:** Heat flow (dQ/dt) · **Note:** first-order and irreversible — no thermal inductance

**Lesson:** [course01 Lesson 5](../../course01/Lesson5.md) · **Theory:** [course01 Module 5](../../course01/index.md#module-5--thermal-domain) · **Bench:** [course04 Bench 5](../../course04/05-bench-thermal.md)

> Hands on first (A–C), then the six layers from the bottom of the stack up (1–6), then back to the bench (D–E).

## A. What you're looking at

A thermocouple from a multimeter probe. A Peltier module from a USB mini-fridge. A bimetal strip from an old oven thermostat. A pot of water heating on the stove.

## B. The one thing to understand

Heat is slow. Everything thermal has a time constant equal to thermal mass × thermal resistance (just like electrical RC). Nothing changes temperature fast unless it's tiny or you dump huge power into it. The slowest domain in a chain sets the system's bandwidth.

**Key relations:** R_θ = ΔT / Q̇ [K/W] · C_θ = m·c [J/K] · τ = R_θ · C_θ · Conduction Q̇ = kA ΔT / L · Convection Q̇ = hA ΔT · Radiation Q̇ = εσA(T₁⁴ − T₂⁴).

## C. This pile on the three pillars

| Pillar | At this pile |
|---|---|
| [1 · Arrows between piles](../p1-arrows-between-piles.md) | Thermocouple: thermal → electrical |
| [2 · Material + technique](../p2-material-and-technique.md) | See [4. Material](#4-material) and [5. Technique](#5-technique) below |
| [3 · Bandwidth](../p3-bandwidth-and-ceiling.md) | 0.01–10 Hz — limited by thermal mass |
| [3 · Ceiling (energy density)](../p3-bandwidth-and-ceiling.md) | Thermal (SMA): low (Nitinol; shape-setting) |
| Role | Universal sensing; specialty actuation. |
| As sensor input / actuator output | Very common / Specialty |
| Characteristic effects | Fourier conduction, Newton cooling, Stefan–Boltzmann radiation. |

## 1. Vocabulary

*The terms that let you reason about everything below.*

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

## 2. Measurement

*The instruments that first saw each effect.*

| Year | Discoverer | What was measured | Equipment used |
|---|---|---|---|
| 1807 | Fourier | Temperature along a heated rod | Mercury thermometers, charcoal furnace |
| 1821 | Seebeck | Compass deflection beside bimetallic loop | Bi–Cu junctions, ice/boiling baths, compass |
| 1834 | Peltier | Temperature change at a current-carrying junction | Thermocouple-pair, battery, galvanometer |
| 1848 | Kelvin | Absolute temperature scale | Gas thermometers, mercury manometers |
| 1879–84 | Stefan & Boltzmann | Total radiated power vs. T | Blackbody cavity, thermopile, bolometer |
| 1962 | Buehler & Wang | Reversible NiTi phase transformation | Arc melter, Instron, DSC, water baths |

## 3. Discovery

*The physical effects themselves.*

| Year | Effect / law | Discoverer |
|---|---|---|
| 1807 | Heat equation | Fourier |
| 1821 | Seebeck effect | Seebeck |
| 1834 | Peltier effect | Peltier |
| 1848 | Absolute temperature | Kelvin |
| 1879–84 | Stefan–Boltzmann law | Stefan, Boltzmann |
| 1962 | Shape memory in Nitinol | Buehler, Wang |

### Who to know

Fourier (heat equation), Seebeck (thermocouple effect), Peltier (thermoelectric cooling), Buehler and Wang (Nitinol, 1962, at the Naval Ordnance Lab).

## 4. Material

*What carries the effect.*

- **Thermocouples:** chromel-alumel (Type K, general), iron-constantan (Type J), Pt/Rh (high temperature, laboratory accuracy).
- **RTDs:** pure platinum. Pt100 and Pt1000 are everywhere stability matters.
- **Thermistors:** metal-oxide ceramics. High sensitivity, nonlinear.
- **Thermoelectric modules:** bismuth telluride.
- **Shape memory:** Nitinol — one alloy that remembers its shape and springs back when heated. Medical stents, aerospace deployments, thermostatic valves.
- **Bimetals:** Invar bonded to brass or steel.

## 5. Technique

*How the material becomes a device.*

- Bead welding of thermocouple wires.
- Mineral-insulated sheath construction — wires inside MgO powder inside Inconel. Survives furnaces, reactors, exhausts.
- Shape-setting of Nitinol — constrain the wire in a jig, anneal at 500 °C. It now "remembers" that shape and returns to it on heating. One technique, enormous consequences.
- Zone-melting of Bi₂Te₃ — crystals grown with the right orientation for maximum thermoelectric efficiency.

### The clever trick

**Nitinol's phase transformation.** Two phases, austenite (hot) and martensite (cold). Deform it cold, heat it, it springs back to the "remembered" shape. ~5% reversible strain. Used in heart stents that are threaded in cold, then warm to body temperature and open. One alloy, one anneal, and you get a thermal actuator with no motor, no gears, no bearings.

### Signature techniques

Shape-setting of Nitinol; MEMS microbolometer arrays; mineral-insulated thermocouple cable; zone-melting of Bi₂Te₃.

## 6. Features

*What the material + technique combination gives you.*

| Function | Material | Technique | Features |
|---|---|---|---|
| Thermocouples | Chromel/alumel, Pt/Rh | Bead welding, MI sheath assembly | Wide range, rugged, self-powered |
| RTDs | Pt, Ni, Cu | Thin-film on ceramic, laser trim | High accuracy, stability |
| Thermistors | Mn/Ni/Co oxide ceramic | Powder pressing, sintering | High sensitivity, nonlinear |
| IR detectors | HgCdTe, InSb, LiTaO₃, VOx bolometer | Epitaxy, ROIC bonding, MEMS microbolometer | Non-contact, imaging |
| TE modules | Bi₂Te₃ | Zone-melted, ceramic plates | Solid-state cooling |
| SMAs | Nitinol (NiTi) | Vacuum melting, shape-setting anneal | ~5% reversible strain |
| Bimetal | Invar + brass/steel | Rolling, bonding | Simple passive switching |

| Sensor | Range | Accuracy | Response | Notes |
|---|---|---|---|---|
| Thermocouple | −200 to +1700 °C | ±1 °C typical | Fast | Self-powered, rugged |
| RTD (Pt100) | −200 to +850 °C | ±0.1 °C | Medium | Highest stability |
| Thermistor | −50 to +150 °C | ±0.1 °C | Fast | Nonlinear, cheap |
| IR / bolometer | −20 to +2000 °C | ±2 °C | Fast | Non-contact |

## D. What to build

1. Twist chromel and alumel wire together with a torch to make a Type K thermocouple. Dip the junction in boiling water, then ice water. Read millivolts on a meter.
2. Hook a Peltier to a battery. One side gets cold, one side gets hot. Flip the polarity. The sides swap.
3. Watch a bimetal strip bend in the flame of a candle. Count seconds — that's its time constant.
4. Fill a mug with hot water. Measure the temperature every minute for an hour. Fit an exponential. That's your lumped RC model.

Full BOM and build steps: [course04 Bench 5](../../course04/05-bench-thermal.md).

## E. The example everyone should work

A mug of coffee cooling on a desk, as a lumped RC model (Bench 5, build 4 measures this):

1. Thermal mass: 300 g of water, c = 4,186 J/(kg·K) → C_θ = 0.3 × 4,186 = 1,256 J/K.
2. Surface area (8 cm diameter, 10 cm tall, open top): side π · 0.08 · 0.10 = 0.025 m², top π · 0.04² = 0.005 m², total A ≈ 0.030 m².
3. Heat-transfer coefficient for still air (convection + radiation together): h ≈ 10 W/(m²·K).
4. Thermal resistance: R_θ = 1 / (h·A) = 1 / (10 × 0.030) = 3.3 K/W.
5. Time constant: τ = R_θ · C_θ = 3.3 × 1,256 ≈ 4,160 s ≈ 70 minutes.
6. Prediction: from 80 °C in a 22 °C room, T(t) = 22 + 58·e^(−t/τ). After 30 minutes: 22 + 58·e^(−0.43) ≈ 60 °C.

Measure it and you'll find it cools faster — evaporation from the open top is a second heat path the model left out. Add a lid and the model gets better. That's why thermal bandwidth is measured in minutes, and why the slowest domain sets the bandwidth.

## F. What to read later

- [Fraden, *Handbook of Modern Sensors*](../../course02/06-fraden-handbook-of-modern-sensors/)
- Incropera & DeWitt, *Fundamentals of Heat and Mass Transfer* — [course01, Appendix G](../../course01/index.md#appendix-g--further-reading)

## G. Related in other courses

- **Lesson:** [course01 — Lesson 5: Thermal](../../course01/Lesson5.md)
- **Course:** [course01 — Module 5: Thermal Domain](../../course01/index.md#module-5--thermal-domain)
- **Bench:** [course04 — Bench 5: Thermal](../../course04/05-bench-thermal.md)
- **Manufacturers:** [course05 — Manufacturers & Brands](../../course05/index.md)
