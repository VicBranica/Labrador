# Zafiro — Mineral & Gem Learning Project

[← Labrador project map](../index.md) · [Opal domains](../opal/README.md) · [Course templates](course-templates/README.md)

> Five courses that teach minerals and gems as one discipline organized around eight domains — mineralogy, crystallography, geochemistry, petrology, economic geology, gemology, materials science and environmental mineralogy — laid out like Labrador: theory and lessons, reading, the domain stack, a hands-on lab, and the companies behind the material. **Status: draft structure.** Only this map, the [course templates](course-templates/README.md) and each course's `index.md` header exist; every other entry in the tree below is planned.

## Project structure

```
zafiro/
├── README.md                              ← project map (this file)
├── course-templates/                      ← start every new course file here
│   ├── README.md                            how templates map to files, follow-up edits
│   ├── lesson.md                            → version/course01/LessonN.md
│   ├── course02-resource.md                 → version/course02/NN-author-short-title/README.md
│   ├── course03-domain.md                   → version/course03/NN-domain/README.md
│   ├── course04-bench.md                    → version/course04/NN-bench-domain.md
│   ├── course05-company.md                  → version/course05/NN-category/company.md
│   └── course-index.md                      → version/courseNN/index.md
└── version/
    ├── course01/                          Core course
    │   ├── index.md                         modules 0–10, appendices, lessons table
    │   ├── Lesson1.md                       01 Mineralogy
    │   ├── Lesson2.md                       02 Crystallography
    │   ├── Lesson3.md                       03 Geochemistry
    │   ├── Lesson4.md                       04 Petrology
    │   ├── Lesson5.md                       05 Economic geology
    │   ├── Lesson6.md                       06 Gemology
    │   ├── Lesson7.md                       07 Materials science
    │   ├── Lesson8.md                       08 Environmental mineralogy
    │   └── Lesson9.md …                     across domains — how many is open
    ├── course02/                          Reading list
    │   ├── index.md
    │   └── NN-author-short-title/
    │       └── README.md                    one per resource, by reading priority — none chosen yet
    ├── course03/                          Domain stack
    │   ├── index.md
    │   ├── p1-….md                          pillar 1 — name open
    │   ├── p2-….md                          pillar 2 — name open
    │   ├── p3-….md                          pillar 3 — name open
    │   ├── 01-mineralogy/README.md
    │   ├── 02-crystallography/README.md
    │   ├── 03-geochemistry/README.md
    │   ├── 04-petrology/README.md
    │   ├── 05-economic-geology/README.md
    │   ├── 06-gemology/README.md
    │   ├── 07-materials-science/README.md
    │   ├── 08-environmental-mineralogy/README.md
    │   └── 09-integration.md                integration pile
    ├── course04/                          Hands-on lab
    │   ├── index.md
    │   ├── 00-starter-kit.md
    │   ├── 01-bench-mineralogy.md
    │   ├── 02-bench-crystallography.md
    │   ├── 03-bench-geochemistry.md
    │   ├── 04-bench-petrology.md
    │   ├── 05-bench-economic-geology.md
    │   ├── 06-bench-gemology.md
    │   ├── 07-bench-materials-science.md
    │   └── 08-bench-environmental-mineralogy.md
    └── course05/                          Companies & brands
        ├── index.md
        └── NN-category/                     categories open
            ├── index.md
            └── company.md                   one per company
```

**Conventions**

- Every course folder opens at `index.md`, which states the course's role, what it builds on and what it feeds into, with links to the previous and next course.
- Domain numbers are the same in every course: `01` mineralogy · `02` crystallography · `03` geochemistry · `04` petrology · `05` economic geology · `06` gemology · `07` materials science · `08` environmental mineralogy. course03 adds `p1`–`p3` (pillars) and `09` (integration pile, since `08` is a domain here); course04 adds `00` (starter kit). course01 Modules 1–8 and Lessons 1–8 follow the same numbers.
- Folder and file slugs: `mineralogy` · `crystallography` · `geochemistry` · `petrology` · `economic-geology` · `gemology` · `materials-science` · `environmental-mineralogy`.
- course02 is numbered by reading priority, not by domain.
- Every domain file links to the same domain in the other courses.
- New course files start from [course-templates/](course-templates/README.md); its destinations are relative to `zafiro/`.
- Unknown facts are "—", never guessed.

## The five courses

| Course | Role | What it is | Builds on | Feeds into |
|---|---|---|---|---|
| [course01](version/course01/index.md) | Core course | Theory spine: Module 0 (foundations), Modules 1–8 (one per domain), modules across domains, appendices; Lessons 1–8 (one per domain, nine steps each) plus lessons across domains | — | course02, course03, course04, course05 |
| [course02](version/course02/index.md) | Reading list | Books and other resources, one folder each, numbered by reading priority — none chosen yet | course01 (further reading) | course03 (sources) |
| [course03](version/course03/index.md) | Domain stack | Three pillars, then one file per domain — hands-on pile (A–C), six layers (vocabulary → measurement → discovery → material → technique → features), back to the bench (D–G) — then the integration pile | course01, course02 | course04, course05 |
| [course04](version/course04/index.md) | Hands-on lab | Starter kit + eight benches, each with four builds; the BOM format for mineral benches is open | course03 | Your lab notebook, course05 |
| [course05](version/course05/index.md) | Companies & brands | One folder per category, one file per company cited in courses 01–04 — categories open | course01, course03, course04 | course04 (sourcing) |

## Domain cross-reference

The same domain, in every course. Nothing below exists yet; each cell is the planned path, relative to `version/`.

| # | Domain | What it studies | Lesson (course01) | Module (course01) | Domain stack (course03) | Bench (course04) | course02 books |
|---|---|---|---|---|---|---|---|
| 1 | Mineralogy | Mineral composition, properties, classification, and formation | planned: `course01/Lesson1.md` | planned: Module 1 | planned: `course03/01-mineralogy/README.md` | planned: `course04/01-bench-mineralogy.md` | — |
| 2 | Crystallography | Atomic arrangement, symmetry, and crystal structure | planned: `course01/Lesson2.md` | planned: Module 2 | planned: `course03/02-crystallography/README.md` | planned: `course04/02-bench-crystallography.md` | — |
| 3 | Geochemistry | Distribution and movement of chemical elements | planned: `course01/Lesson3.md` | planned: Module 3 | planned: `course03/03-geochemistry/README.md` | planned: `course04/03-bench-geochemistry.md` | — |
| 4 | Petrology | Rocks and their constituent minerals | planned: `course01/Lesson4.md` | planned: Module 4 | planned: `course03/04-petrology/README.md` | planned: `course04/04-bench-petrology.md` | — |
| 5 | Economic geology | Deposits, ores, and resource formation | planned: `course01/Lesson5.md` | planned: Module 5 | planned: `course03/05-economic-geology/README.md` | planned: `course04/05-bench-economic-geology.md` | — |
| 6 | Gemology | Jewelry materials, identification, treatments, quality, and care | planned: `course01/Lesson6.md` | planned: Module 6 | planned: `course03/06-gemology/README.md` | planned: `course04/06-bench-gemology.md` | — |
| 7 | Materials science | Physical properties and technological applications | planned: `course01/Lesson7.md` | planned: Module 7 | planned: `course03/07-materials-science/README.md` | planned: `course04/07-bench-materials-science.md` | — |
| 8 | Environmental mineralogy | Weathering, contamination, and mineral–environment interactions | planned: `course01/Lesson8.md` | planned: Module 8 | planned: `course03/08-environmental-mineralogy/README.md` | planned: `course04/08-bench-environmental-mineralogy.md` | — |
| — | All domains | — | planned: Lesson 9 onward | planned: Module 0, modules after 8 | planned: pillars `p1`–`p3` · `course03/09-integration.md` | planned: `course04/00-starter-kit.md` | — |

Domain descriptions are from [opal/README.md](../opal/README.md). Companies: [course05](version/course05/index.md) — none listed yet.

## Open questions

- **Lessons and modules across domains** — Labrador has three (foundations, cross-domain, integration). How many does Zafiro have, and what are they?
- **Pillars** — Labrador's three pillars (arrows between piles, material + technique, bandwidth and ceiling) are about energy domains. What are Zafiro's?
- **Effort · flow · power** — the course03 domain header line has no counterpart for minerals; replace with key quantities or drop.
- **Benches and BOMs** — what a mineral & gem bench holds (tools, reagents, reference specimens?) and whether it is costed as a BOM; what replaces the free "teardown targets" category.
- **course05 categories** — e.g. mining companies, gem labs, instrument makers, dealers and suppliers? Not decided.
- **course02 resources** — none chosen.
