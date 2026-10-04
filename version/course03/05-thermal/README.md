# Thermal Domain — Six-Layer Stack

**Effort:** Temperature (T) · **Flow:** Heat flow (dQ/dt) · **Note:** first-order and irreversible — no thermal inductance

## 1. Vocabulary

Temperature · Heat · Heat flow · Specific heat · Thermal mass · Thermal conductivity · Thermal resistance · Thermal circuit · Thermal time constant · Conduction / convection / radiation · Emissivity · Blackbody · Stefan–Boltzmann · Seebeck coefficient · Peltier coefficient · Figure of merit (ZT) · Phase transformation (austenite ↔ martensite).

Key relations: R_θ = ΔT / Q̇ [K/W] · C_θ = m·c [J/K] · τ = R_θ · C_θ · Conduction Q̇ = kA ΔT / L · Convection Q̇ = hA ΔT · Radiation Q̇ = εσA(T₁⁴ − T₂⁴).

## 2. Measurement

| Year | Who | Instrument | What it saw |
|---|---|---|---|
| 1807 | Fourier | Hg thermometers in lagged bar | Temperature along heated rod |
| 1821 | Seebeck | Bi-Cu, ice/boiling baths, compass | Compass deflection beside bimetallic loop |
| 1834 | Peltier | Thermocouple, battery, galvanometer | Heating/cooling at junction |
| 1848 | Kelvin | Gas thermometer | Absolute temperature |
| 1879–84 | Stefan, Boltzmann | Blackbody cavity, thermopile | Radiated power vs. T |
| 1962 | Buehler, Wang | Arc melter, Instron, DSC | Nitinol phase transformation |

## 3. Discovery

| Year | Effect / law | Discoverer |
|---|---|---|
| 1807 | Heat equation | Fourier |
| 1821 | Seebeck effect | Seebeck |
| 1834 | Peltier effect | Peltier |
| 1848 | Absolute temperature | Kelvin |
| 1879–84 | Stefan–Boltzmann law | Stefan, Boltzmann |
| 1962 | Shape memory in Nitinol | Buehler, Wang |

## 4. Material

| Function | Material |
|---|---|
| Thermocouples | Chromel/alumel, Pt/Rh |
| RTDs | Pt, Ni, Cu |
| Thermistors | Mn/Ni/Co oxide ceramic |
| IR detectors | HgCdTe, VOx bolometer |
| TE modules | Bi₂Te₃ |
| SMAs | **Nitinol** |
| Bimetal | Invar + brass/steel |

## 5. Technique

| Function | Technique |
|---|---|
| Thermocouples | Bead welding, MI sheath |
| RTDs | Thin-film on ceramic, laser trim |
| Thermistors | Powder press + sintering |
| IR detectors | Epitaxy, MEMS array |
| TE modules | Zone-melted, ceramic plate |
| SMAs | Vacuum melting + shape-set anneal |
| Bimetal | Rolling + bonding |

## 6. Features

| Function | Feature |
|---|---|
| Thermocouples | Wide range, rugged |
| RTDs | High stability |
| Thermistors | High sensitivity |
| IR detectors | Imaging |
| TE modules | Solid-state cooling |
| SMAs | ~5% reversible strain |
| Bimetal | Passive switching |

| Sensor | Range | Accuracy | Response | Notes |
|---|---|---|---|---|
| Thermocouple | −200 to +1700 °C | ±1 °C typical | Fast | Self-powered, rugged |
| RTD (Pt100) | −200 to +850 °C | ±0.1 °C | Medium | Highest stability |
| Thermistor | −50 to +150 °C | ±0.1 °C | Fast | Nonlinear, cheap |
| IR / bolometer | −20 to +2000 °C | ±2 °C | Fast | Non-contact |

## Sources

- [course01 — Module 5: Thermal Domain](../../course01/index.md#module-5--thermal-domain)
- [Fraden, *Handbook of Modern Sensors*](../../course02/06-fraden-handbook-of-modern-sensors/)
- Incropera & DeWitt, *Fundamentals of Heat and Mass Transfer* — [course01, Appendix G](../../course01/index.md#appendix-g--further-reading)

## Related in other courses

- **Course:** [course01 — Module 5: Thermal Domain](../../course01/index.md#module-5--thermal-domain)
- **Terms:** [course05 — Domain 5: Thermal](../../course05/05-thermal.md)
- **Bench:** [course04 — Bench 5: Thermal](../../course04/05-bench-thermal.md)
