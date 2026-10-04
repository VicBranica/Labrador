# Domain 5 — Thermal

[← Course 05 index](index.md) · [← Domain 4 — Fluidic](04-fluidic.md) · [Domain 6 — Chemical →](06-chemical.md)

**Course:** [course01 Module 5](../course01/index.md#module-5--thermal-domain) · **Theory:** [course03/05-thermal](../course03/05-thermal/README.md) · **Bench:** [course04/05-bench-thermal](../course04/05-bench-thermal.md)

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

## Role

Universal sensing; specialty actuation.

## Characteristic effects

Fourier conduction, Newton cooling, Stefan–Boltzmann radiation.

## Discoverers — measurement and equipment

| Year | Discoverer | What was measured | Equipment used |
|---|---|---|---|
| 1807 | Fourier | Temperature along a heated rod | Mercury thermometers, charcoal furnace |
| 1821 | Seebeck | Compass deflection beside bimetallic loop | Bi–Cu junctions, ice/boiling baths, compass |
| 1834 | Peltier | Temperature change at a current-carrying junction | Thermocouple-pair, battery, galvanometer |
| 1848 | Kelvin | Absolute temperature scale | Gas thermometers, mercury manometers |
| 1879–84 | Stefan & Boltzmann | Total radiated power vs. T | Blackbody cavity, thermopile, bolometer |
| 1962 | Buehler & Wang | Reversible NiTi phase transformation | Arc melter, Instron, DSC, water baths |

## Materials, techniques, features

| Function | Material | Technique | Features |
|---|---|---|---|
| Thermocouples | Chromel/alumel, Pt/Rh | Bead welding, MI sheath assembly | Wide range, rugged, self-powered |
| RTDs | Pt, Ni, Cu | Thin-film on ceramic, laser trim | High accuracy, stability |
| Thermistors | Mn/Ni/Co oxide ceramic | Powder pressing, sintering | High sensitivity, nonlinear |
| IR detectors | HgCdTe, InSb, LiTaO₃, VOx bolometer | Epitaxy, ROIC bonding, MEMS microbolometer | Non-contact, imaging |
| TE modules | Bi₂Te₃ | Zone-melted, ceramic plates | Solid-state cooling |
| SMAs | Nitinol (NiTi) | Vacuum melting, shape-setting anneal | ~5% reversible strain |
| Bimetal | Invar + brass/steel | Rolling, bonding | Simple passive switching |

## Signature techniques

Shape-setting of Nitinol; MEMS microbolometer arrays; mineral-insulated thermocouple cable; zone-melting of Bi₂Te₃.
