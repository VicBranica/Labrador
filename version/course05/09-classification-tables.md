# Classification Tables

[← Course 05 index](index.md) · [← Cross-Domain Term Patterns](08-cross-domain-term-patterns.md) · [Material Families →](10-material-families.md)

## By how commonly a domain appears in sensors vs. actuators

| Domain | As sensor input | As actuator output |
|---|---|---|
| [Electrical](01-electrical.md) | Common (signal) | Rare (electrostatic) |
| [Magnetic](02-magnetic.md) | Very common | Dominant |
| [Mechanical](03-mechanical.md) | The measurand itself | The goal itself |
| [Fluidic](04-fluidic.md) | Common | Common |
| [Thermal](05-thermal.md) | Very common | Specialty |
| [Chemical](06-chemical.md) | Common (process) | Very rare |
| [Radiant](07-radiant.md) | Very common | Specialty |

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
