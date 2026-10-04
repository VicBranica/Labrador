# Pillar 3 — Bandwidth and ceiling

[← Course 03 index](index.md) · [← Pillar 2 — Material + technique](p2-material-and-technique.md) · [Domain 1 — Electrical →](01-electrical/README.md)

> The slowest domain sets the bandwidth. The material family sets the ceiling.

- **Bandwidth lives in the slowest domain.** A fast electrical controller behind a thermal actuator is still a thermal system.
- **Energy density determines size.** If the device looks absurdly large or small, you probably picked the wrong domain.

## By how commonly a domain appears in sensors vs. actuators

| Domain | As sensor input | As actuator output |
|---|---|---|
| [Electrical](01-electrical/README.md) | Common (signal) | Rare (electrostatic) |
| [Magnetic](02-magnetic/README.md) | Very common | Dominant |
| [Mechanical](03-mechanical/README.md) | The measurand itself | The goal itself |
| [Fluidic](04-fluidic/README.md) | Common | Common |
| [Thermal](05-thermal/README.md) | Very common | Specialty |
| [Chemical](06-chemical/README.md) | Common (process) | Very rare |
| [Radiant](07-radiant/README.md) | Very common | Specialty |

## By energy density

| Domain | Energy density | Dominant material + technique |
|---|---|---|
| Chemical (fuel) | Very high | Hydrocarbons, hydrogen; combustion |
| Hydraulic | High | Oil + honed steel; precision sealing |
| Pneumatic | Medium | Air + alloy; pressure-vessel engineering |
| Electromagnetic | Medium | Copper + NdFeB + silicon steel |
| Piezoelectric | High force, tiny stroke | PZT; stack co-firing |
| Thermal (SMA) | Low | Nitinol; shape-setting |

## By bandwidth

| Domain | Typical bandwidth | Limiting factor |
|---|---|---|
| Radiant / optical | GHz+ | Detector response, electronics |
| Electrical | MHz–GHz | Parasitics |
| Magnetic | kHz–MHz | Core losses, eddy currents |
| Piezoelectric mechanical | kHz | Mechanical resonance |
| Fluidic (pneumatic) | 10–100 Hz | Compressibility |
| Fluidic (hydraulic) | 10–1000 Hz | Fluid inertia, bulk modulus |
| Thermal | 0.01–10 Hz | Thermal mass |
| Chemical | 0.001–1 Hz | Diffusion, reaction kinetics |
