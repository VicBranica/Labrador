# Design Heuristics (Gelbart-style, with material lens)

[← Dan Gelbart's videos](README.md) · [course02 index](../index.md)

The single list of design heuristics for the project. [course05's integration pile](../../course05/08-integration.md#design-heuristics-gelbart-style) and the [course01 capstone](../../course01/index.md#module-9--integration--system-design) point here.

## Physics and materials

1. **Stay in one domain if you can.** Each crossing adds loss, noise, nonlinearity, and failure modes — and another material-compatibility problem (CTE mismatch, corrosion, outgassing).
2. **Match impedances across boundaries.** Mechanical, electrical, acoustic — all obey the same rule.
3. **Pick the domain and material naturally matched to the measurand.** Nanometers? Capacitive silicon or interferometric fused silica. A car? Copper + NdFeB + silicon steel.
4. **Bandwidth lives in the slowest domain** — and in the material with the longest time constant. A fast electrical controller behind a thermal actuator is still a thermal system.
5. **Energy density determines size.** The material family sets the ceiling. If the device looks absurdly large or small, you probably picked the wrong domain.
6. **Rugged environment = pick the material first.** Hastelloy diaphragms, sapphire windows, Viton seals, platinum electrodes — survival dictates the material before the device.

## Practice

7. **Build it yourself.** Even badly. You'll learn more in a weekend than in a month of reading.
8. **The second one is always better than the first.** Expect to throw the first version away.
9. **Simplicity over cleverness.** Fewer parts, fewer tolerances, fewer failure modes.

## Why Discoveries + Materials Matter Together

- **A discovery without a material is a lab curiosity.** The piezoelectric effect (1880, quartz) was known for 60 years before PZT (1950s) made it an industrial technology.
- **A material without a discovery is just a lump.** NdFeB would be unremarkable without Faraday, Ørsted, and a century of motor engineering to put it to work.
- **Era-defining devices usually mark the moment the two meet.**
  - Clark's enzyme electrode (1962) = Nernst equation + glucose oxidase.
  - Modern servo motor = Lorentz force + NdFeB + silicon steel.
  - Smartphone camera = photoelectric effect + silicon CMOS + microlens arrays.
  - Precision stage = Hooke's law + Invar/Zerodur + flexure design.
