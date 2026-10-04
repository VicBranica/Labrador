# Lesson 1 — The Seven Domains, Hands First

[← course01 index](index.md) · [Project map](../../index.md) · Domains as listed in [course03](../course03/index.md)

> One lesson, seven domains, the same nine steps each time. Start with something you can hold, get one mental model, build it, then learn what it's made of, how it's made, what trick unlocked it, and who got there first.

## Lesson structure

Every domain below follows this research structure:

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

Sections 1–7 come from the [course05 piles](../course05/index.md). Section 9 uses the course05 reading notes where a pile has them, and the [course03](../course03/index.md) sources otherwise. Where a domain has no worked example yet, section 8 points to the matching course01 "Try it" exercises.

## Domains

| # | Domain | Lesson section | Module (theory) | Stack | Bench | Pile |
|---|---|---|---|---|---|---|
| 1 | Electrical | [Domain 1](#domain-1--electrical) | [Module 1](index.md#module-1--electrical-domain) | [course03](../course03/01-electrical/README.md) | [course04](../course04/01-bench-electrical.md) | [course05](../course05/01-electrical.md) |
| 2 | Magnetic | [Domain 2](#domain-2--magnetic) | [Module 2](index.md#module-2--magnetic-domain) | [course03](../course03/02-magnetic/README.md) | [course04](../course04/02-bench-magnetic.md) | [course05](../course05/02-magnetic.md) |
| 3 | Mechanical | [Domain 3](#domain-3--mechanical) | [Module 3](index.md#module-3--mechanical-domain) | [course03](../course03/03-mechanical/README.md) | [course04](../course04/03-bench-mechanical.md) | [course05](../course05/03-mechanical.md) |
| 4 | Fluidic | [Domain 4](#domain-4--fluidic) | [Module 4](index.md#module-4--fluidic-domain) | [course03](../course03/04-fluidic/README.md) | [course04](../course04/04-bench-fluidic.md) | [course05](../course05/04-fluidic.md) |
| 5 | Thermal | [Domain 5](#domain-5--thermal) | [Module 5](index.md#module-5--thermal-domain) | [course03](../course03/05-thermal/README.md) | [course04](../course04/05-bench-thermal.md) | [course05](../course05/05-thermal.md) |
| 6 | Chemical | [Domain 6](#domain-6--chemical) | [Module 6](index.md#module-6--chemical-domain) | [course03](../course03/06-chemical/README.md) | [course04](../course04/06-bench-chemical.md) | [course05](../course05/06-chemical.md) |
| 7 | Radiant | [Domain 7](#domain-7--radiant) | [Module 7](index.md#module-7--radiant-domain) | [course03](../course03/07-radiant/README.md) | [course04](../course04/07-bench-radiant.md) | [course05](../course05/07-radiant.md) |

---

## Domain 1 — Electrical

**Theory:** [Module 1](index.md#module-1--electrical-domain) · **Stack:** [course03/01-electrical](../course03/01-electrical/README.md) · **Bench:** [course04/01-bench-electrical](../course04/01-bench-electrical.md) · **Pile:** [course05/01-electrical](../course05/01-electrical.md)

### 1. What you're looking at

A circuit board, a resistor, a capacitor, an op-amp, a battery. All of them move charge around. All of them are made of a conductor, an insulator, and sometimes a semiconductor between them.

### 2. The one thing to understand

Voltage pushes current through resistance. That's Ohm's law, and 90% of electrical engineering is dressed-up versions of it.

### 3. What to build

1. Light an LED from a 9 V battery with a current-limiting resistor. Pick the resistor value yourself.
2. Make an RC filter with a resistor and a capacitor. Watch an input square wave become a smoothed curve on an oscilloscope (or a phone-based scope).
3. Breadboard an op-amp as a non-inverting amplifier with gain 10. Verify the gain.

Full BOM and build steps: [course04 Bench 1](../course04/01-bench-electrical.md).

### 4. Key materials

Copper (conducts), aluminum (conducts cheap), nichrome (resists), ceramic / tantalum / polymer film (insulate while storing charge), silicon (switches).

### 5. Key techniques

Drawing wire, electroplating, sputtering thin films, photolithography on silicon, printing on fiberglass boards and soldering parts to them. The techniques got cheaper every decade; that's why there's electronics in a $5 flashlight.

### 6. The clever trick

**Photolithography.** Someone realized that if you project a pattern onto a photosensitive layer on silicon, you can etch nanometer features in parallel across a whole wafer. One trick turned electronics from a craft into a commodity.

### 7. Who to know

Volta (made steady current possible), Faraday (induction), Ohm (the law), Kirchhoff (the circuit), Bardeen/Brattain/Shockley (the transistor), Kilby/Noyce (the integrated circuit). Each one measured something new with the galvanometer of their day.

Year-by-year table of what each one measured and with which equipment: [course05 Pile 1](../course05/01-electrical.md#discoverers--measurement-and-equipment).

### 8. The example everyone should work *(optional)*

No worked example yet. Work the "Try it" exercises in [Module 1](index.md#module-1--electrical-domain) instead.

### 9. What to read later *(optional)*

Any introductory electronics book. *The Art of Electronics* (Horowitz & Hill) if you're serious. → [course02](../course02/04-horowitz-hill-art-of-electronics/)

---

## Domain 2 — Magnetic

**Theory:** [Module 2](index.md#module-2--magnetic-domain) · **Stack:** [course03/02-magnetic](../course03/02-magnetic/README.md) · **Bench:** [course04/02-bench-magnetic](../course04/02-bench-magnetic.md) · **Pile:** [course05/02-magnetic](../course05/02-magnetic.md)

### 1. What you're looking at

A motor. Open it. Count the magnets. Note the wire wrapped around iron laminations. Spin the shaft and feel the detents (that's the magnetic flux "wanting" to be in the stator teeth).

### 2. The one thing to understand

A magnetic circuit is just an electrical circuit with different words.

| Electrical | Magnetic |
|---|---|
| Voltage | MMF (amp-turns = N × I) |
| Current | Flux Φ |
| Resistance | Reluctance ℛ |
| Ohm's law V = IR | MMF = ℛ × Φ |

Soft iron is low reluctance. Air is high reluctance. The flux follows the easy path, just like current. Everything else — motors, solenoids, loudspeakers, Hall sensors — is this one idea applied with cleverness.

### 3. What to build

1. Wrap 100 turns of magnet wire around a steel bolt. Hook to a battery. You've made an electromagnet. Measure the pull with a kitchen scale.
2. Pull apart a dead BLDC fan motor. Count the teeth and magnets. Guess what's inside before you look.
3. Hold a Hall sensor near a magnet and watch the output voltage change on a meter.
4. Wind a small motor by hand on a nail with a loop of wire and a battery. The ugliest motor you'll ever make. It still spins.

Full BOM and build steps: [course04 Bench 2](../course04/02-bench-magnetic.md).

### 4. Key materials

- **Soft magnetic:** silicon steel laminations (motors), ferrite (high frequency), Mu-metal (shielding), Metglas (sensors).
- **Permanent magnets:** NdFeB (the modern miracle), SmCo (hot environments), AlNiCo (temperature-stable, weaker), ferrite (cheap, weak).
- **Windings:** copper wire with a varnish coating.

### 5. Key techniques

Laminating the steel so eddy currents can't flow (that's the whole reason motor cores are stacks of thin plates). Sintering NdFeB powder in a magnetic field so the grains line up. Winding wire around a bobbin and dunking it in varnish.

### 6. The clever trick

**NdFeB sintering, 1984.** Masato Sagawa aligned iron-neodymium-boron powder in a strong field, pressed it, sintered it. The result had ~10× the energy of ferrite magnets. Everything with a battery today — power tools, drones, EVs, servos — exists because of that one process.

### 7. Who to know

Ørsted (current makes magnetism), Faraday (motor principle), Hall (transverse voltage), Tesla (AC motor), Sagawa and Croat (NdFeB), Fert and Grünberg (GMR — basis of modern hard-drive read heads).

Year-by-year table of what each one measured and with which equipment: [course05 Pile 2](../course05/02-magnetic.md#discoverers--measurement-and-equipment).

### 8. The example everyone should work *(optional)*

A C-shaped iron core with an air gap, coil of N turns carrying current I:

1. MMF = N·I
2. Total reluctance ≈ gap reluctance = l_gap / (μ₀ · A)
3. Flux Φ = MMF / ℛ
4. Flux density in the gap B = Φ / A
5. Force pulling the gap closed F ≈ B²A / (2μ₀)

That's a relay. That's a solenoid. That's one pole of a motor. One calculation, a hundred products.

<details><summary>Full version, with core reluctance</summary>

A simple C-core electromagnet with coil of N turns carrying current I around a ferromagnetic yoke with an air gap:

1. The coil creates an MMF = N × I (ampere-turns).
2. The yoke has high permeability (μ) and low reluctance: ℛ_core = l_core / (μA).
3. The air gap has μ₀ only, so its reluctance ℛ_gap = l_gap / (μ₀A) usually dominates.
4. Total reluctance: ℛ = ℛ_core + ℛ_gap.
5. Magnetic flux: Φ = MMF / ℛ.
6. Flux density in the gap: B = Φ / A.
7. Force of attraction across the gap: F ≈ B²A / (2μ₀) — the standard relay/solenoid equation.

This single loop is the design calculation behind every relay, solenoid, speaker, and motor pole.

</details>

### 9. What to read later *(optional)*

- [Fraden, *Handbook of Modern Sensors*](../course02/06-fraden-handbook-of-modern-sensors/)
- Jiles, *Introduction to Magnetism and Magnetic Materials* — [Appendix G](index.md#appendix-g--further-reading)

---

## Domain 3 — Mechanical

**Theory:** [Module 3](index.md#module-3--mechanical-domain) · **Stack:** [course03/03-mechanical](../course03/03-mechanical/README.md) · **Bench:** [course04/03-bench-mechanical](../course04/03-bench-mechanical.md) · **Pile:** [course05/03-mechanical](../course05/03-mechanical.md)

### 1. What you're looking at

A spring, a bearing, a bolt, a strain gauge. Also: your bench itself. Mechanical engineering is the one where the thing you build is also the thing you build on.

### 2. The one thing to understand

Stuff bends. A little, under small load, in proportion to the load (Hooke). A lot, with hysteresis and crack growth, under big load. Most of mechanical design is staying in the first regime and designing the second regime out of existence.

### 3. What to build

1. Glue a strain gauge to an aluminum ruler. Clamp one end. Press the other. Watch the resistance change by a few milliohms per Newton.
2. Make a flexure out of a strip of spring steel cut with a nibbler. Move it with your finger. Notice there's no backlash, no stiction, no wear.
3. Build a kinematic mount from a plate with three divots, three balls, and a mating plate. Lift the top off. Put it back. Verify it returns to the same position within what you can measure.
4. Weigh a chunk of carbon fiber composite and a chunk of aluminum. Flex them. Carbon fiber feels like aluminum but weighs half. That's why satellites are made of it.

Full BOM and build steps: [course04 Bench 3](../course04/03-bench-mechanical.md).

### 4. Key materials

- Steel for strength, aluminum for weight, titanium for both plus corrosion resistance.
- Spring steel (17-4 PH, 17-7 PH, beryllium copper) for springs and flexures.
- 52100 steel balls for bearings; ceramic (Si₃N₄) for premium bearings.
- Granite, Zerodur, Invar, fused silica when dimensional stability matters more than anything.
- Carbon fiber composites when stiffness-to-weight is king.

### 5. Key techniques

- **Waterjet** — cuts anything flat with no heat-affected zone. The single most useful tool for prototypes. If you only buy one machine, buy time on one.
- **Wire EDM** — spark-erodes hardened materials. The only way to make precise flexures from spring steel.
- **Grinding and lapping** — the mechanical world's lithography; sub-micron flatness.
- **Scraping** — hand-finishing of reference surfaces to <1 µm. Still done. Still unmatched.
- **Kinematic design** — six-point exact constraint. The rule: constrain each DOF exactly once, never twice.
- **Flexure design** — monolithic hinges. No bearings means no friction, no backlash, no lubrication.

### 6. The clever trick

**Flexures.** By making a hinge from a thin section of the same material as the body, you get zero backlash, zero stiction, zero wear, and perfect repeatability — in exchange for limited range. Any precision instrument more expensive than a car has flexures somewhere.

### 7. Who to know

Hooke (elasticity), Newton (motion), Coulomb (friction), Guillaume (Invar — made metrology possible), Slocum and Hale (modern precision machine design — read Hale's MIT thesis for free).

Year-by-year table of what each one measured and with which equipment: [course05 Pile 3](../course05/03-mechanical.md#discoverers--measurement-and-equipment).

### 8. The example everyone should work *(optional)*

No worked example yet. Work the "Try it" exercises in [Module 3](index.md#module-3--mechanical-domain) instead.

### 9. What to read later *(optional)*

[Slocum](../course02/01-slocum-precision-machine-design/) · [Hale](../course02/02-hale-designing-precision-machines/) · [Ashby](../course02/03-ashby-materials-selection/) · [Gelbart's videos](../course02/09-gelbart-videos/)

---

## Domain 4 — Fluidic

**Theory:** [Module 4](index.md#module-4--fluidic-domain) · **Stack:** [course03/04-fluidic](../course03/04-fluidic/README.md) · **Bench:** [course04/04-bench-fluidic](../course04/04-bench-fluidic.md) · **Pile:** [course05/04-fluidic](../course05/04-fluidic.md)

### 1. What you're looking at

A hydraulic cylinder from a tractor. A pneumatic cylinder from a factory. A pressure gauge. A syringe.

### 2. The one thing to understand

Hydraulics is water. Pneumatics is air. Water is nearly incompressible — press on it and the far end moves immediately. Air compresses — press on it and the far end moves eventually. That one difference changes everything about how the two are used.

### 3. What to build

1. Fill a syringe with water. Cap it. Push. It doesn't move. That's bulk modulus.
2. Fill it with air. Push. It compresses. That's compressibility.
3. Rig two syringes with a tube. Push one, the other extends. That's a hydraulic circuit.
4. Measure pressure by hanging the syringe vertically with weight on top and reading travel.

Full BOM and build steps: [course04 Bench 4](../course04/04-bench-fluidic.md).

### 4. Key materials

Steel (cylinders), hardened steel ground to <1 µm (servo valve spools), aluminum (lightweight applications), bronze (bushings). Seals: NBR for general use, Viton for heat, PTFE for chemicals, polyurethane for dynamic rod seals. Fluids: mineral oil for most things; phosphate ester (Skydrol) for aircraft because it doesn't burn when the hydraulic line gets hit.

### 5. Key techniques

- Honing a cylinder bore to a precise diameter and finish.
- Chrome plating of rods for hardness and corrosion resistance.
- Lapping and matched-pair fitting of servo-valve spools to the bore. Hand-selected pairs. <1 µm clearance.
- Flapper-nozzle amplification — tiny torque motor positions a flapper, which modulates a hydraulic bridge, which drives a spool, which drives a cylinder. That's how a pilot's finger moves a 737's flight control.

### 6. The clever trick

**The two-stage servo valve.** A torque motor you could blow over positions a vane the size of a fingernail. That vane throttles a tiny flow of hydraulic oil, which in turn moves a large spool, which drives thousands of pounds of force at the actuator. Four orders of magnitude of power amplification, with precision maintained end to end.

### 7. Who to know

Pascal (pressure transmission), Bernoulli (flow and pressure), Bramah (the hydraulic press, 1795), Reynolds (laminar vs. turbulent), Vickers and Moog (modern servo valves — Moog valves still fly on everything from F-16s to the Shuttle).

Year-by-year table of what each one measured and with which equipment: [course05 Pile 4](../course05/04-fluidic.md#discoverers--measurement-and-equipment).

### 8. The example everyone should work *(optional)*

No worked example yet. Work the "Try it" exercises in [Module 4](index.md#module-4--fluidic-domain) instead.

### 9. What to read later *(optional)*

[Merritt, *Hydraulic Control Systems*](../course02/05-merritt-hydraulic-control-systems/)

---

## Domain 5 — Thermal

**Theory:** [Module 5](index.md#module-5--thermal-domain) · **Stack:** [course03/05-thermal](../course03/05-thermal/README.md) · **Bench:** [course04/05-bench-thermal](../course04/05-bench-thermal.md) · **Pile:** [course05/05-thermal](../course05/05-thermal.md)

### 1. What you're looking at

A thermocouple from a multimeter probe. A Peltier module from a USB mini-fridge. A bimetal strip from an old oven thermostat. A pot of water heating on the stove.

### 2. The one thing to understand

Heat is slow. Everything thermal has a time constant equal to thermal mass × thermal resistance (just like electrical RC). Nothing changes temperature fast unless it's tiny or you dump huge power into it. The slowest domain in a chain sets the system's bandwidth.

### 3. What to build

1. Twist chromel and alumel wire together with a torch to make a Type K thermocouple. Dip the junction in boiling water, then ice water. Read millivolts on a meter.
2. Hook a Peltier to a battery. One side gets cold, one side gets hot. Flip the polarity. The sides swap.
3. Watch a bimetal strip bend in the flame of a candle. Count seconds — that's its time constant.
4. Fill a mug with hot water. Measure the temperature every minute for an hour. Fit an exponential. That's your lumped RC model.

Full BOM and build steps: [course04 Bench 5](../course04/05-bench-thermal.md).

### 4. Key materials

- **Thermocouples:** chromel-alumel (Type K, general), iron-constantan (Type J), Pt/Rh (high temperature, laboratory accuracy).
- **RTDs:** pure platinum. Pt100 and Pt1000 are everywhere stability matters.
- **Thermistors:** metal-oxide ceramics. High sensitivity, nonlinear.
- **Thermoelectric modules:** bismuth telluride.
- **Shape memory:** Nitinol — one alloy that remembers its shape and springs back when heated. Medical stents, aerospace deployments, thermostatic valves.
- **Bimetals:** Invar bonded to brass or steel.

### 5. Key techniques

- Bead welding of thermocouple wires.
- Mineral-insulated sheath construction — wires inside MgO powder inside Inconel. Survives furnaces, reactors, exhausts.
- Shape-setting of Nitinol — constrain the wire in a jig, anneal at 500 °C. It now "remembers" that shape and returns to it on heating. One technique, enormous consequences.
- Zone-melting of Bi₂Te₃ — crystals grown with the right orientation for maximum thermoelectric efficiency.

### 6. The clever trick

**Nitinol's phase transformation.** Two phases, austenite (hot) and martensite (cold). Deform it cold, heat it, it springs back to the "remembered" shape. ~5% reversible strain. Used in heart stents that are threaded in cold, then warm to body temperature and open. One alloy, one anneal, and you get a thermal actuator with no motor, no gears, no bearings.

### 7. Who to know

Fourier (heat equation), Seebeck (thermocouple effect), Peltier (thermoelectric cooling), Buehler and Wang (Nitinol, 1962, at the Naval Ordnance Lab).

Year-by-year table of what each one measured and with which equipment: [course05 Pile 5](../course05/05-thermal.md#discoverers--measurement-and-equipment).

### 8. The example everyone should work *(optional)*

No worked example yet. Work the "Try it" exercises in [Module 5](index.md#module-5--thermal-domain) instead.

### 9. What to read later *(optional)*

- [Fraden, *Handbook of Modern Sensors*](../course02/06-fraden-handbook-of-modern-sensors/)
- Incropera & DeWitt, *Fundamentals of Heat and Mass Transfer* — [Appendix G](index.md#appendix-g--further-reading)

---

## Domain 6 — Chemical

**Theory:** [Module 6](index.md#module-6--chemical-domain) · **Stack:** [course03/06-chemical](../course03/06-chemical/README.md) · **Bench:** [course04/06-bench-chemical](../course04/06-bench-chemical.md) · **Pile:** [course05/06-chemical](../course05/06-chemical.md)

### 1. What you're looking at

A pH probe. A glucose test strip. A smoke detector. A CO sensor. A fuel cell.

### 2. The one thing to understand

Put two different metals in a conductive solution and you get a voltage. The voltage depends on what's dissolved. If you can arrange for a specific chemical to change that voltage reliably, you have a sensor for it. The Nernst equation turns concentration into millivolts: about 59 mV per decade of concentration change at room temperature.

### 3. What to build

1. Volta's pile: alternate zinc and copper coins separated by brine-soaked cardboard. Measure a few volts on a stack of ten.
2. Dip two bits of different metals in salty water. Measure the voltage. Change the salinity. Watch it shift.
3. Buy a $20 pH meter. Open the probe (carefully — the glass bulb is fragile). Note how little is inside: a glass membrane, a wire, a reference, a connector.

Full BOM and build steps: [course04 Bench 6](../course04/06-bench-chemical.md).

### 4. Key materials

- **Electrodes:** platinum (universal), gold (biosensors), silver/silver chloride (reference), glassy carbon (electrochemistry).
- **pH-sensitive membrane:** specially formulated lithium silicate glass.
- **Ion-selective membranes:** PVC loaded with ionophores (e.g., valinomycin for potassium).
- **Metal-oxide gas sensors:** SnO₂, ZnO, WO₃ — operated hot (~400 °C) so adsorbed gas changes conductivity.
- **Biosensors:** enzymes (glucose oxidase), antibodies, aptamers.
- **Fuel cells:** Nafion membrane, platinum catalyst.

### 5. Key techniques

- **Enzyme immobilization** — crosslinking with glutaraldehyde, entrapment in a gel, self-assembled monolayers. Hundreds of millions of glucose test strips a year.
- **Screen-printing of electrodes** — carbon and silver inks on plastic. Disposable biosensors cost pennies to make.
- **Nafion membrane casting** — the proton-conducting plastic that makes PEM fuel cells work.

### 6. The clever trick

**Clark and Lyons, 1962.** Spread glucose oxidase on a membrane over a Clark oxygen electrode. Glucose consumes oxygen as the enzyme oxidizes it. Less O₂ = less current. You've just turned "measure glucose" into "measure current." That one trick is the entire glucose-meter industry.

### 7. Who to know

Volta (pile), Faraday (electrolysis), Grove (fuel cell, 1839), Nernst (the equation), Sørensen (pH), Clark (oxygen electrode, 1956; enzyme electrode, 1962).

Year-by-year table of what each one measured and with which equipment: [course05 Pile 6](../course05/06-chemical.md#discoverers--measurement-and-equipment).

### 8. The example everyone should work *(optional)*

No worked example yet. Work the "Try it" exercises in [Module 6](index.md#module-6--chemical-domain) instead.

### 9. What to read later *(optional)*

[Bard & Faulkner, *Electrochemical Methods*](../course02/07-bard-faulkner-electrochemical-methods/)

---

## Domain 7 — Radiant

**Theory:** [Module 7](index.md#module-7--radiant-domain) · **Stack:** [course03/07-radiant](../course03/07-radiant/README.md) · **Bench:** [course04/07-bench-radiant](../course04/07-bench-radiant.md) · **Pile:** [course05/07-radiant](../course05/07-radiant.md)

### 1. What you're looking at

A photodiode. An LED. A laser pointer. A CCD from an old digital camera. A pair of mirrors and a glass of water (interference, refraction).

### 2. The one thing to understand

Light is both a wave (diffraction, interference, wavelength) and a particle (energy = hν, photoelectric effect). You need both pictures. Every optical device uses one or the other, often in the same sentence.

Photons with energy above a material's bandgap get absorbed and knock out electrons. Silicon's bandgap sets its spectral range (400–1100 nm). Smaller bandgaps see further into the infrared. Bigger bandgaps work in UV.

### 3. What to build

1. Shine a laser pointer through a double slit cut in foil. Watch fringes on a wall. You've reproduced Young's experiment from 1801 for the cost of a laser pointer.
2. Hook a photodiode to a scope. Wave a hand over it. See the shadow in volts.
3. Open a Blu-ray drive. The laser is a GaN diode. The optics are plastic. The sensor is a photodiode array. All assembly done by machines.
4. Image a fluorescent tube with a cheap CMOS camera at a short shutter. See the stripes from the 60 Hz flicker.

Full BOM and build steps: [course04 Bench 7](../course04/07-bench-radiant.md).

### 4. Key materials

- **Photodetectors:** silicon (visible), InGaAs (telecom), Ge (near-IR), HgCdTe (mid/long IR, cryogenic), InSb (mid-IR), GaN (UV).
- **Emitters:** GaN/InGaN (blue, green, white LEDs; Blu-ray lasers), AlGaInP (red/amber), GaAs/AlGaAs (near-IR lasers).
- **Lenses and windows:** fused silica (broad), sapphire (rugged), ZnSe and Ge (IR), CaF₂ (UV).
- **Mirrors:** aluminum (broad), silver (visible), dielectric stacks (laser-grade).
- **Fiber:** fused silica. One meter of preform draws into tens of kilometers of fiber.

### 5. Key techniques

- **MOCVD epitaxy** — atomic-layer growth of semiconductors. Enables every modern LED and semiconductor laser.
- **Diamond turning** — single-point cutting of optics with nanometer finish; aspheric and freeform shapes no polisher can make.
- **Magnetorheological finishing (MRF)** — polishing with a magnetically-shaped slurry. Finishes to a fraction of a wavelength.
- **Preform drawing of fiber** — one of the most dramatic manufacturing processes in existence; a glass log becomes 50 km of fiber in hours.

### 6. The clever trick

**MOCVD growth of GaN.** For decades, nobody could make a bright blue LED — the materials wouldn't cooperate. Nakamura, Akasaki, and Amano got it to work in the early 1990s. The payoff: blue LEDs enabled white LEDs (blue + yellow phosphor), which replaced incandescent lighting worldwide; also Blu-ray, UV sources, modern displays. Nobel in 2014.

### 7. Who to know

Young (interference), Michelson (interferometry), Einstein (photoelectric effect), Maiman (first laser, 1960), Holonyak (first visible LED, 1962), Boyle and Smith (CCD, 1969), Nakamura/Akasaki/Amano (GaN blue LED), Ashkin (optical tweezers).

Year-by-year table of what each one measured and with which equipment: [course05 Pile 7](../course05/07-radiant.md#discoverers--measurement-and-equipment).

### 8. The example everyone should work *(optional)*

No worked example yet. Work the "Try it" exercises in [Module 7](index.md#module-7--radiant-domain) instead.

### 9. What to read later *(optional)*

[Hecht, *Optics*; Saleh & Teich, *Fundamentals of Photonics*](../course02/08-hecht-saleh-teich-optics-photonics/)
