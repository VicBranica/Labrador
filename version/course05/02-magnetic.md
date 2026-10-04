# Domain 2 — Magnetic

[← Course 05 index](index.md) · [← Domain 1 — Electrical](01-electrical.md) · [Domain 3 — Mechanical →](03-mechanical.md)

**Course:** [course01 Module 2](../course01/index.md#module-2--magnetic-domain) · **Theory:** [course03/02-magnetic](../course03/02-magnetic/README.md) · **Bench:** [course04/02-bench-magnetic](../course04/02-bench-magnetic.md)

## Important terms

| Term | Meaning |
|---|---|
| Magnetic field (H) | Field strength from currents and magnets. Unit: A/m. |
| Magnetic flux (Φ) | Total "amount" of magnetic field through a surface. Unit: weber (Wb). |
| Flux density (B) | Flux per unit area; what the material "sees." Unit: tesla (T). |
| Permeability (μ) | How easily a material carries flux. μ = μ₀μᵣ. |
| Relative permeability (μᵣ) | Material's permeability compared to vacuum. |
| Reluctance (ℛ) | Magnetic analog of resistance; "resistance to flux." |
| Magnetomotive force (MMF) | Driver of flux in a magnetic circuit; MMF = N × I. Unit: ampere-turn. |
| Magnetic circuit | Closed loop that carries flux, analyzed like an electrical circuit (MMF = ℛΦ, analogous to V = IR). |
| Electromagnet | Coil + ferromagnetic core; flux produced only while current flows. |
| Permanent magnet | Material that retains magnetization without external current. |
| B-H curve | Flux density vs. applied field — nonlinear, hysteretic for ferromagnets. |
| Hysteresis | Lag of B behind H; area of the loop = loss per cycle. |
| Saturation | Point where further H no longer increases B meaningfully. |
| Remanence (Bᵣ) | B remaining after H returns to zero. |
| Coercivity (Hc) | H needed to drive B back to zero. |
| Energy product (BHmax) | Figure of merit for permanent magnets. |
| Eddy currents | Induced circulating currents in conductive cores; loss mechanism. |
| Lorentz force | Force on a current-carrying conductor in a field: F = IL × B. |
| Hall effect | Transverse voltage across a conductor in a perpendicular field. |
| GMR / TMR | Giant / tunnel magnetoresistance; large resistance changes in multilayers. |
| Air gap | Non-magnetic break in a magnetic circuit; dominates reluctance. |

## Mini-example: a magnetic circuit

A simple C-core electromagnet with coil of N turns carrying current I around a ferromagnetic yoke with an air gap:

1. The coil creates an MMF = N × I (ampere-turns).
2. The yoke has high permeability (μ) and low reluctance: ℛ_core = l_core / (μA).
3. The air gap has μ₀ only, so its reluctance ℛ_gap = l_gap / (μ₀A) usually dominates.
4. Total reluctance: ℛ = ℛ_core + ℛ_gap.
5. Magnetic flux: Φ = MMF / ℛ.
6. Flux density in the gap: B = Φ / A.
7. Force of attraction across the gap: F ≈ B²A / (2μ₀) — the standard relay/solenoid equation.

This single loop is the design calculation behind every relay, solenoid, speaker, and motor pole.

## Role

Dominant actuation domain; core sensing domain for rugged, non-contact measurement.

## Characteristic effects

Lorentz force, saturation, hysteresis, eddy currents.

## Discoverers — measurement and equipment

| Year | Discoverer | What was measured | Equipment used |
|---|---|---|---|
| 1820 | Ørsted | Compass deflection beside current | Voltaic pile, platinum wire, compass |
| 1821 | Faraday | Continuous rotation of wire around a magnet | Mercury bath, bar magnet, suspended wire |
| 1879 | Edwin Hall | Transverse voltage across gold leaf in a field | Thin gold leaf, electromagnet, galvanometer |
| 1882 | Ferraris / Tesla | Torque from phase-shifted AC coils | AC source, two-phase stator, copper rotor |
| 1888 | Tesla | Torque–speed of polyphase induction motor | Polyphase alternator, squirrel cage, prony brake |
| 1984 | Sagawa / Croat | Hysteresis loop of Nd₂Fe₁₄B | Vibrating-sample magnetometer, hysteresisgraph |
| 1988 | Fert & Grünberg | ~50% resistance drop in Fe/Cr multilayers | MBE chambers, cryostats, superconducting magnets |

## Materials, techniques, features

| Function | Material | Technique | Features |
|---|---|---|---|
| Soft magnetic cores | Silicon steel, permalloy, Mu-metal, ferrite, Metglas | Lamination, sintering, ribbon casting, annealing | High μᵣ, low hysteresis loss, low eddy loss |
| Permanent magnets | NdFeB, SmCo, AlNiCo, ferrite | Powder metallurgy, aligned-field pressing, sintering | High Bᵣ, high Hc, high BHmax |
| Hall & MR sensors | InSb, GaAs, Si (Hall); permalloy (AMR); Co/Cu, Fe/Cr (GMR); MgO (TMR) | Thin-film deposition, epitaxy, lithography | Non-contact, small, sensitive |
| Electromagnets / coils | Copper magnet wire + soft core | Winding, varnish impregnation | Controllable force, high MMF per cm³ |
| Fluxgate cores | Permalloy, Vitrovac | Thin-ribbon winding, field annealing | Senses geomagnetic-level fields |

## Signature techniques

Lamination of silicon steel (breaks eddy-current paths); aligned-sintering of NdFeB; thin-film multilayer deposition; rotor skewing.
