# Lesson 3 — Geochemistry

[← Lesson 2 — Crystallography](Lesson2.md) · [All lessons](index.md#lessons) · [Lesson 4 — Petrology →](Lesson4.md)

> Domain 3 of 8, in nine steps: start with something you can hold, get one mental model, build it, then learn what it's made of, how it's made, what trick unlocked it, and who got there first.

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

**Theory:** [Module 3](index.md#module-3--geochemistry-domain) · **Stack:** [course03/03-geochemistry](../course03/03-geochemistry/README.md) · **Bench:** course04 Bench 3 — course04 is not written yet

## 1. What you're looking at

*← start concrete*

Sea salt (sodium and chloride from rivers and vents). The ion list on a mineral-water label. Limescale in a kettle. A rusty nail. A banana — its potassium includes a little radioactive ⁴⁰K.

## 2. The one thing to understand

*← give the mental model*

Elements go where their charge and size fit. Each element has an affinity — for silicate rock, metal, sulfide or gas (Goldschmidt's classes) — and it substitutes for ions of similar radius and charge in crystal structures. Follow those rules and you can predict where an element ends up. Radioactive isotopes add a clock: they decay at a fixed rate, so the ratio of daughter to parent tells you when a mineral closed.

## 3. What to build

*← hands on the bench*

1. Water hardness: shake equal volumes of tap water, rainwater (or distilled) and mineral water with one drop of liquid soap. Less foam = more Ca and Mg dissolved from rocks.
2. Red-cabbage indicator: boil red cabbage, keep the purple water, and test vinegar, rainwater, tap water and baking soda. You are reading pH — the master variable of water–rock chemistry.
3. Evaporate a dish of seawater (or salt water) slowly. Look at the residue with a magnifier: cubic halite crystals, and around the edges finer crusts that form first.

Full BOM and build steps: course04 Bench 3 — course04 is not written yet; the builds above use household items.

## 4. Key materials

*← what it's made of*

- **Crust:** eight elements make up over 98% by weight: O ~46%, Si ~28%, Al ~8%, Fe ~5%, then Ca, Na, K and Mg at a few percent each.
- **Feldspars:** hosts for K, Na, Ca — and for Rb, Sr, Ba by substitution.
- **Zircon (ZrSiO₄):** takes in U and Th, rejects Pb — the best geochronometer.
- **Olivine:** hosts Mg and Fe; takes up compatible Ni.
- **Sulfides:** collect chalcophile metals — Cu, Zn, Pb, Ag.
- **Carbonates and clays:** record C and O isotopes; clays exchange cations with water.

## 5. Key techniques

*← how it's made*

- **X-ray fluorescence (XRF)** — major and trace elements in a fused glass bead or pressed powder.
- **ICP-MS and laser ablation** — trace elements and isotopes at ppb levels, in solution or on a spot.
- **Thermal ionization mass spectrometry (TIMS)** — the most precise isotope ratios — the reference for dating.
- **Clean-lab sample preparation** — crushing, acid digestion, column chemistry — contamination is the enemy.

## 6. The clever trick

*← what unlocked the industry*

**Zircon U–Pb dating.** Zircon builds uranium into its structure as it grows but rejects lead, so all the lead found in it later was made by decay. Two independent chains run inside the same grain — ²³⁸U → ²⁰⁶Pb and ²³⁵U → ²⁰⁷Pb — so the grain checks its own age. If both clocks agree the age is concordant; if they disagree, the mismatch tells you the grain was disturbed.

## 7. Who to know

*← short lineage of names*

Bunsen and Kirchhoff (spectroscopy), Clarke and Washington (crustal composition, 1924), Boltwood (U–Pb dating, 1907), Goldschmidt (classification and substitution, 1920s), Urey (stable isotopes, 1947), Patterson (age of the Earth, 1956).

Year-by-year table of what each one measured and with which equipment: [course03 Domain 3](../course03/03-geochemistry/README.md#2-measurement).

## 8. The example everyone should work

*← optional — work it with pencil and paper*

A zircon grain gives a radiogenic ²⁰⁶Pb/²³⁸U ratio of 0.0500. The decay constant of ²³⁸U is λ = 1.55125 × 10⁻¹⁰ per year.

1. Age: t = (1/λ) · ln(1 + ²⁰⁶Pb*/²³⁸U).
2. ln(1 + 0.0500) = ln 1.05 = 0.04879.
3. t = 0.04879 / 1.55125 × 10⁻¹⁰ = 3.145 × 10⁸ years ≈ 315 million years.
4. Half-life check: t½ = ln 2 / λ = 0.693 / 1.55125 × 10⁻¹⁰ = 4.47 billion years — so 315 million years used up only ~5% of the parent.
5. Cross-check with the ²³⁵U → ²⁰⁷Pb clock in the same grain; if both give ~315 Ma, the age is concordant.

A ratio and a decay constant give an absolute age. The same equation dates the Earth, a granite, or a gem's host rock.

More practice: the "Try it" exercises in [Module 3](index.md#module-3--geochemistry-domain).

## 9. What to read later

*← optional — where to go deeper*

Albarède, *Geochemistry: An Introduction* · White, *Geochemistry* · Krauskopf & Bird, *Introduction to Geochemistry*

*Not yet in course02, which has no resources chosen.*
