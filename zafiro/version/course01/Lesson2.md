# Lesson 2 — Crystallography

[← Lesson 1 — Mineralogy](Lesson1.md) · [All lessons](index.md#lessons) · [Lesson 3 — Geochemistry →](Lesson3.md)

> Domain 2 of 8, in nine steps: start with something you can hold, get one mental model, build it, then learn what it's made of, how it's made, what trick unlocked it, and who got there first.

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

**Theory:** [Module 2](index.md#module-2--crystallography-domain) · **Stack:** [course03/02-crystallography](../course03/02-crystallography/README.md) · **Bench:** course04 Bench 2 — course04 is not written yet

## 1. What you're looking at

*← start concrete*

Salt grains under a magnifier — tiny cubes. Sugar crystals. A snowflake on a dark sleeve. A quartz point with its six-sided prism. An egg carton, as a model of a two-dimensional lattice.

## 2. The one thing to understand

*← give the mental model*

A crystal is one small motif of atoms repeated on a lattice in three dimensions. The symmetry of that repeat decides the outer shape, which directions are equal, and how the crystal handles light, heat, stress and X-rays. Only 1-, 2-, 3-, 4- and 6-fold rotations fit a repeating lattice — that single constraint is why there are exactly 7 crystal systems, 14 Bravais lattices, 32 point groups and 230 space groups.

## 3. What to build

*← hands on the bench*

1. Grow crystals: alum (pharmacy or spice shop) or salt from a saturated solution left to evaporate slowly. Compare the shape you get with the cubic or octahedral habit expected.
2. Build a halite unit cell from two colours of modelling clay balls and toothpicks. Count the ions that belong to one cell: 4 Na and 4 Cl.
3. A diffraction grating on the kitchen table: shine a laser pointer through a CD or DVD (stripped of its label layer) or reflect it off one, measure the spot angles, and compute the track spacing with the grating equation — Bragg's idea at a scale you can see.

Full BOM and build steps: course04 Bench 2 — course04 is not written yet; the builds above use household items.

## 4. Key materials

*← what it's made of*

- **Halite (NaCl):** the textbook cubic structure; each ion has six neighbours; perfect cubic cleavage.
- **Diamond and graphite:** the same carbon in a 3-D tetrahedral network and in stacked hexagonal sheets.
- **Quartz (SiO₂):** trigonal and chiral — left- and right-handed crystals; the basis of piezoelectric oscillators.
- **Calcite (CaCO₃):** trigonal; rhombohedral cleavage; strong double refraction in Iceland spar.
- **Garnet, spinel, perovskite:** structure types that host many compositions — the same frame, different atoms.
- **Silicon:** a near-perfect single crystal grown on purpose — the diamond structure in industry.

## 5. Key techniques

*← how it's made*

- **Goniometry** — measuring the angles between faces; the first quantitative crystallography.
- **Single-crystal XRD** — solves the full atomic structure of one crystal.
- **Powder XRD** — identifies phases in a mixture by their d-spacings — the everyday lab workhorse.
- **Electron diffraction** — structure from nanometre-scale regions in a TEM.
- **Crystal growth** — from solution, melt or vapour — slow and clean gives large, perfect crystals.

## 6. The clever trick

*← what unlocked the industry*

**Bragg's law, 1913.** Von Laue showed in 1912 that a crystal diffracts X-rays. The Braggs treated each lattice plane as a mirror: reflections add only when the path difference is a whole number of wavelengths, nλ = 2d sin θ. One angle measurement became one atomic spacing, and every crystal structure since — minerals, metals, DNA — has been read this way.

## 7. Who to know

*← short lineage of names*

Steno (interfacial angles, 1669), Haüy (repeated units, 1784), Bravais (14 lattices, 1848), Fedorov and Schoenflies (230 space groups, 1891), von Laue (X-ray diffraction, 1912), the Braggs (nλ = 2d sin θ, 1913), Pauling (structure rules, 1929), Shechtman (quasicrystals, 1982).

Year-by-year table of what each one measured and with which equipment: [course03 Domain 2](../course03/02-crystallography/README.md#2-measurement).

## 8. The example everyone should work

*← optional — work it with pencil and paper*

Halite has a cubic cell with a = 5.64 Å. A lab diffractometer uses copper Kα X-rays, λ = 1.5406 Å.

1. The (200) planes: d₂₀₀ = a / √(2² + 0 + 0) = 5.64 / 2 = 2.82 Å.
2. Bragg, n = 1: sin θ = λ / 2d = 1.5406 / (2 × 2.82) = 0.2731.
3. θ = 15.85°, so the detector sees the peak at 2θ = 31.7°.
4. The (220) planes: d = 5.64 / √8 = 1.994 Å → sin θ = 0.3863 → 2θ = 45.4°.
5. Kitchen version: a CD track pitch of 1.6 µm with a 650 nm red laser gives sin θ = 0.650 / 1.6 = 0.406 → first-order spot at about 24°.

Measure angles, get spacings; get spacings, get the structure. A powder pattern with peaks at 31.7° and 45.4° 2θ (Cu Kα) is the start of halite's fingerprint.

More practice: the "Try it" exercises in [Module 2](index.md#module-2--crystallography-domain).

## 9. What to read later

*← optional — where to go deeper*

[Hammond, *The Basics of Crystallography and Diffraction*](../course02/04-hammond-basics-of-crystallography/) · [Sands, *Introduction to Crystallography*](../course02/15-sands-introduction-to-crystallography/)
