# Pillar 1 — Arrows between piles

[← Course 05 index](index.md) · [Pillar 2 — Material + technique →](p2-material-and-technique.md)

> Any sensor or actuator is one or more arrows between two piles.

## The one idea you need first

A sensor or actuator moves energy across a boundary between two of those seven piles.

- Microphone: sound (mechanical) → electrical.
- Speaker: electrical → sound.
- Motor: electrical → magnetic → mechanical.
- Thermocouple: thermal → electrical.
- Hydraulic cylinder: fluidic → mechanical.
- Camera: radiant → electrical.

That's it. Every device is one or more of these crossings. Learn to read a device as a chain of crossings and you can read any device, including ones not invented yet.

The crossings that matter are the ones that happen inside common materials. Lorentz force only matters because copper and NdFeB exist together. The photoelectric effect only matters because silicon is cheap. Half the discipline is physics; the other half is which materials happened to exist when someone needed them.

## The same roles on every arrow

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

## Go further

- Multi-crossing devices — servo motor, smartphone — are in the [integration pile](08-integration.md).
- Full table of crossings with their materials and techniques: [course01 Module 8](../course01/index.md#module-8--cross-domain-transducers).
