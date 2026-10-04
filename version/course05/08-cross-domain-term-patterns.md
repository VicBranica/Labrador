# Cross-Domain Term Patterns

[← Course 05 index](index.md) · [← Domain 7 — Radiant](07-radiant.md) · [Classification Tables →](09-classification-tables.md)

Many terms show up in multiple domains, often with different units but the same role. Recognizing them is a core skill:

| Role | [Electrical](01-electrical.md) | [Magnetic](02-magnetic.md) | [Mechanical](03-mechanical.md) | [Fluidic](04-fluidic.md) | [Thermal](05-thermal.md) |
|---|---|---|---|---|---|
| Effort | Voltage (V) | MMF | Force / torque | Pressure | Temperature |
| Flow | Current (I) | dΦ/dt | Velocity / ω | Volumetric flow | Heat flow |
| Resistance | Resistance (Ω) | Reluctance (ℛ) | Damping (c) | Flow resistance | Thermal resistance (R_θ) |
| Capacitance | Capacitance (F) | — | Mass / inertia | Accumulator | Thermal mass (C_θ) |
| Inductance | Inductance (H) | — | Spring (compliance) | Fluid inertia | — |
| Driver equation | V = IR | MMF = ℛΦ | F = cv | ΔP = R_f Q | ΔT = R_θ dQ/dt |
| Energy storage | ½CV², ½LI² | ½ΦMMF | ½mv², ½kx² | ½(V/K)P² | mcΔT |

This is why circuit intuition transfers across domains — once you can read a Kirchhoff network, you can read a thermal network, a magnetic circuit, or a hydraulic schematic.
