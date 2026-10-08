# Lesson 7 — Materials science

[← Lesson 6 — Gemology](Lesson6.md) · [All lessons](index.md#lessons) · [Lesson 8 — Environmental mineralogy →](Lesson8.md)

> Domain 7 of 8, in nine steps: start with something you can hold, get one mental model, build it, then learn what it's made of, how it's made, what trick unlocked it, and who got there first.

## Lesson structure

```
1.  What you're looking at         ← start concrete
2.  The one thing to understand    ← give the mental model
3.  What to build                  ← hands on the bench
4.  Key materials                  ← what it's made of
5.  Key techniques                 ← how it's made
6.  The clever trick               ← what unlocked the industry
7.  Who to know                    ← short lineage of names
8.  The example everyone should work   (optional)
9.  What to read later             (optional)
```

| Step | Section | Purpose |
|---|---|---|
| 1 | [What you're looking at](#1-what-youre-looking-at) | Start concrete. |
| 2 | [The one thing to understand](#2-the-one-thing-to-understand) | Give the mental model. |
| 3 | [What to build](#3-what-to-build) | Hands on the bench. |
| 4 | [Key materials](#4-key-materials) | What it's made of. |
| 5 | [Key techniques](#5-key-techniques) | How it's made. |
| 6 | [The clever trick](#6-the-clever-trick) | What unlocked the industry. |
| 7 | [Who to know](#7-who-to-know) | Short lineage of names. |
| 8 | [The example everyone should work](#8-the-example-everyone-should-work) | Optional — work it with pencil and paper. |
| 9 | [What to read later](#9-what-to-read-later) | Optional — where to go deeper. |

**Theory:** [Module 7](index.md#module-7--materials-science-domain) · **Stack:** [course03/07-materials-science](../course03/07-materials-science/README.md) · **Bench:** course04 Bench 7 — course04 is not written yet

## 1. What you're looking at

*← start concrete*

A quartz watch. A ceramic mug. A window pane and a phone's cover glass. A bag of cement. A ceramic kitchen knife (zirconia). The piezo igniter in a gas lighter. A silicon chip.

## 2. The one thing to understand

*← give the mental model*

Properties come from structure at every scale — bonds, crystal structure, defects, grains — and processing changes that structure. Minerals are the raw materials and the templates: quartz becomes glass and silicon, clay becomes porcelain, limestone becomes cement, bauxite becomes aluminium, and mineral structures such as perovskite and spinel are copied in the lab for electronics and energy.

## 3. What to build

*← hands on the bench*

1. Plaster of Paris: mix calcined gypsum (CaSO₄·½H₂O, craft shop) with water, feel it warm as it rehydrates to gypsum (CaSO₄·2H₂O), and cast a shape. A mineral reaction in five minutes.
2. Piezoelectricity: click a gas-lighter igniter in the dark and see the spark — a crystal turning a hammer blow into kilovolts.
3. Grow an alum single crystal from a seed on a thread over several days. Compare its faces with a crystal grown fast in the same solution.
4. Griffith in the kitchen: score a glass microscope slide once with a glass cutter and snap it over a pencil. Wear safety glasses; the flaw makes the break.

Full BOM and build steps: course04 Bench 7 — course04 is not written yet; the builds above use household items.

## 4. Key materials

*← what it's made of*

- **Quartz:** piezoelectric oscillators; raw material for silica glass and, by carbothermic reduction, silicon.
- **Clays (kaolinite):** porcelain and other ceramics.
- **Limestone and gypsum:** cement (clinker fired at ~1450 °C) and plaster.
- **Bauxite:** alumina (Bayer process) and aluminium (Hall–Héroult).
- **Zircon:** zirconia ceramics, refractories.
- **Corundum:** synthetic sapphire for watch crystals and LED substrates; ruby lasers.
- **Diamond and graphite:** cutting tools and heat spreaders; battery anodes, graphene.
- **Mineral structure types:** perovskite (piezoelectrics, solar cells), spinel (magnets, battery cathodes), zeolites (catalysts, detergents).

## 5. Key techniques

*← how it's made*

- **Crystal growth** — Czochralski (silicon, sapphire), Verneuil (corundum), hydrothermal (quartz), flux, CVD (diamond).
- **Sintering** — dense ceramics from powder — alumina, zirconia, PZT.
- **Glass melting and forming** — float glass, fibre drawing, ion exchange for toughened cover glass.
- **Extractive metallurgy** — smelting, electrolysis, leaching.
- **Characterization** — XRD, electron microscopy, mechanical testing.

## 6. The clever trick

*← what unlocked the industry*

**Hydrothermal synthetic quartz.** Natural quartz veins grow from hot water under pressure. Reproduce that in a steel autoclave — alkaline water, a hot zone that dissolves quartz feedstock and a cooler zone where seed plates grow — and you get flawless, oriented quartz by the tonne. Since the mid-20th century almost all the quartz in oscillators has been synthetic: a geological process run on purpose.

## 7. Who to know

*← short lineage of names*

Aspdin (cement, 1824), the Curies (piezoelectricity, 1880), Hall, Héroult and Bayer (aluminium), Czochralski (crystal pulling, 1916), Griffith (fracture, 1921), Taylor, Orowan and Polanyi (dislocations, 1934), Maiman (ruby laser, 1960), Geim and Novoselov (graphene, 2004).

Year-by-year table of what each one measured and with which equipment: [course03 Domain 7](../course03/07-materials-science/README.md#2-measurement).

## 8. The example everyone should work

*← optional — work it with pencil and paper*

A quartz watch and a quartz radio crystal use the same mineral at very different frequencies.

1. A watch crystal is a tiny tuning fork cut to 32 768 Hz = 2¹⁵ Hz.
2. Fifteen divide-by-two stages give exactly 1 pulse per second for the stepper motor.
3. A radio crystal is a thickness-shear AT-cut plate: f × t ≈ 1.66 MHz·mm.
4. For 10 MHz: t = 1.66 / 10 = 0.166 mm. For 30 MHz: t = 0.055 mm — so higher fundamentals need thinner, more fragile plates.

Frequency is set by geometry and the elastic constants of quartz; the crystal's stability is why a cheap watch keeps time to seconds a week or better.

More practice: the "Try it" exercises in [Module 7](index.md#module-7--materials-science-domain).

## 9. What to read later

*← optional — where to go deeper*

[Callister & Rethwisch, *Materials Science and Engineering: An Introduction*](../course02/09-callister-rethwisch-materials-science/) · [Newnham, *Properties of Materials*](../course02/24-newnham-properties-of-materials/) · [Ashby, *Materials Selection in Mechanical Design*](../course02/25-ashby-materials-selection/)
