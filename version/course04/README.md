# Course 04 — Build Your Own Sensors & Actuators Lab

> **Goal:** build your own sensors & actuators lab, one bench per physical domain, with a bill of materials (BOM) for each.

| Section | Domain | Theory | Cost (USD) |
|---|---|---|---|
| [Universal Starter Kit](#universal-starter-kit-buy-once-use-for-every-bench) | All | — | 160–250 |
| [Bench 1 — Electrical](#bench-1--electrical) | Electrical | [course03/01-electrical](../course03/01-electrical/README.md) | ~100 |
| [Bench 2 — Magnetic](#bench-2--magnetic) | Magnetic | [course03/02-magnetic](../course03/02-magnetic/README.md) | ~95 |
| [Bench 3 — Mechanical](#bench-3--mechanical) | Mechanical | [course03/03-mechanical](../course03/03-mechanical/README.md) | ~115 |
| [Bench 4 — Fluidic](#bench-4--fluidic) | Fluidic | [course03/04-fluidic](../course03/04-fluidic/README.md) | ~115 |
| [Bench 5 — Thermal](#bench-5--thermal) | Thermal | [course03/05-thermal](../course03/05-thermal/README.md) | ~115 |
| [Bench 6 — Chemical](#bench-6--chemical) | Chemical | [course03/06-chemical](../course03/06-chemical/README.md) | ~135 |
| [Bench 7 — Radiant](#bench-7--radiant) | Radiant | [course03/07-radiant](../course03/07-radiant/README.md) | ~100 |

See also: [Grand Total](#grand-total) · [Where to buy](#where-to-buy) · [How to use these benches](#how-to-use-these-benches)

---

## Universal Starter Kit (buy once, use for every bench)

Before any single pile — these are the tools that make every exercise possible.

### Tools

| Item | Qty | Cost (USD) | Notes |
|---|---|---|---|
| Digital multimeter (6000-count) | 1 | 25–50 | AstroAI, Fluke 101 for the budget option |
| Breadboard, solderless (830 tie-point) | 2 | 10 | Keep one for electronics, one for sensor prototyping |
| Jumper wire kit (M-M, M-F, F-F) | 1 | 10 | Pre-cut assortment |
| Soldering iron (temp-controlled, 60 W) | 1 | 30–80 | Pinecil or Hakko FX-888D if budget allows |
| Solder (60/40 or lead-free, 0.6 mm) | 1 roll | 10 | |
| Flush cutters, needle-nose pliers | 1 set | 10 | |
| Precision screwdriver set (Phillips, flat, Torx) | 1 | 15 | For disassembly — the heart of this course |
| Hex key set (metric + imperial) | 1 | 10 | |
| Digital calipers (150 mm) | 1 | 15–40 | Mitutoyo if you can swing it; cheap ones work |
| Kitchen scale (0.1 g resolution, 3 kg) | 1 | 15 | Measures force, mass, and lots else |
| Steel ruler (300 mm) | 1 | 5 | |
| Safety glasses | 1 | 5 | Non-negotiable |
| Notebook + pen | 1 | 5 | Draw every teardown. Date everything. |

**Starter total: ~$160–$250**

### Nice-to-have (add when you need them)

| Item | Cost | For |
|---|---|---|
| USB oscilloscope (Hantek 6022BE or similar) | 60 | Pile 1, 2, 7 |
| Benchtop DC power supply (0–30 V, 0–5 A) | 60 | Pile 1, 2 |
| Function generator (DDS, 0–20 MHz) | 40 | Pile 1, 7 |
| Arduino Uno or Raspberry Pi Pico | 10–25 | All piles |
| Thermal camera attachment (FLIR One or InfiRay P2) | 200–400 | Pile 5, 7 |
| USB microscope | 25 | Teardowns |

---

## Bench 1 — Electrical

### What's on it

Resistors, capacitors, inductors, diodes, LEDs, op-amps, transistors, a battery, a motor driver. The vocabulary of signals and power.

### BOM — components

| Item | Qty | Cost | Notes |
|---|---|---|---|
| Resistor assortment (1/4 W, 1% metal film, 10 Ω to 10 MΩ) | 1 kit | 15 | E12 or E24 series, at least 10 of each |
| Capacitor assortment (ceramic 10 pF–1 µF, electrolytic 1–470 µF) | 1 kit | 15 | Mixed |
| LED assortment (red, green, blue, white, 3 mm & 5 mm) | 50 | 8 | |
| Diodes (1N4148, 1N4007, 1N5819) | 20 each | 5 | Signal, power, Schottky |
| Op-amps (LM358, TL072, MCP6002) | 5 each | 10 | Rail-to-rail options |
| NPN/PNP transistors (2N3904, 2N3906, BC547) | 10 each | 5 | |
| MOSFETs (IRLZ44N logic-level, 2N7000) | 5 each | 10 | For switching motors, heaters |
| 9 V battery + clip, 4×AA holder | 2 ea | 10 | |
| Potentiometers (10 kΩ linear, 100 kΩ log) | 5 each | 8 | |
| USB-to-serial adapter (CP2102 or CH340) | 1 | 5 | |
| Prototype PCB (perfboard) | 5 | 10 | For permanent circuits |

### Teardown targets (free from recycling)

- An old TV remote → look at the IR LED and the carbon-film PCB.
- A dead phone charger → see the rectifier, filter cap, and switching transformer.
- A broken toy → trace the circuit from battery to motor driver.

### Three builds

1. **LED with current-limiting resistor** — pick R for a 20 mA LED on a 9 V source.
2. **RC low-pass filter** — 1 kHz corner, feed it a square wave, scope the output.
3. **Non-inverting op-amp with gain 10** — verify gain with a function generator.

### Measurement wins

- You can read voltage and current anywhere in a circuit.
- You can predict RC behavior from component values alone.

**Bench 1 total: ~$100 for components (reuse the starter tools)**

---

## Bench 2 — Magnetic

### What's on it

Motors to disassemble, magnets to feel, coils to wind, Hall sensors to probe. The physical home of flux, reluctance, and force.

### BOM — components

| Item | Qty | Cost | Notes |
|---|---|---|---|
| Neodymium (NdFeB) magnets, assorted (5–20 mm disc/block) | 20 | 15 | N42 or N52 grade |
| Ferrite ring + bar magnets | 5 | 5 | For comparison with NdFeB |
| Magnet wire (0.3 mm enameled copper, 100 m spool) | 1 | 10 | For winding your own coils |
| Steel bolts, assorted M4–M8 | 10 | 5 | Cores for homemade electromagnets |
| Hall effect sensor breakout (A3144 digital, A1324 linear) | 3 each | 10 | |
| Reed switch | 5 | 3 | |
| Rotary encoder breakout (incremental, with button) | 2 | 8 | |
| Small DC brushed motor (6 V hobby) | 2 | 6 | For teardown and drive practice |
| BLDC fan (12 V, 80 mm, dead or alive) | 1 | 5 | Teardown — count stator teeth and magnets |
| Stepper motor (NEMA 17, 1.8°) | 1 | 15 | Drives everything in 3D printers |
| Motor driver (L298N or DRV8833 breakout) | 2 | 8 | |
| Compass, pocket | 1 | 5 | Ørsted's experiment |

### Teardown targets (free)

- Dead cordless-drill motor → BLDC with NdFeB rotor magnets.
- Hard-drive voice coil → the strongest magnet most people have handled.
- Microwave oven transformer (unplugged, discharged, **DANGEROUS unless you know what you're doing**) → silicon-steel laminations.
- Old speaker → magnet + voice coil + diaphragm.

### Three builds

1. **Electromagnet** — wind 100 turns on a steel bolt. Measure pull on a scale.
2. **Hand-wound motor** — nail, battery, loop of wire with insulation scraped off one side. Ugly, works.
3. **Measure NdFeB vs. ferrite** — same geometry, compare force on a steel washer.

### Measurement wins

- You can hold a C-core electromagnet calculation in your head.
- You can read a motor spec sheet (torque constant, Kv, resistance) and know what each number does.

**Bench 2 total: ~$95**

---

## Bench 3 — Mechanical

### What's on it

Springs, bearings, strain gauges, a flexure cut from spring steel. The pile where "it bends a little" is a feature and "it bends a lot" is a problem.

### BOM — components

| Item | Qty | Cost | Notes |
|---|---|---|---|
| Strain gauges (120 Ω foil, with leads) | 10 | 15 | Standard quarter-bridge |
| Cyanoacrylate (CA) adhesive, strain-gauge grade | 1 | 10 | Loctite 496 or equivalent |
| HX711 load-cell amplifier breakout | 2 | 6 | 24-bit ADC, Arduino-friendly |
| Load cells (1 kg and 10 kg, bar type) | 1 each | 15 | Pre-wired with strain gauges — a free teardown |
| Spring steel strip (0.5 mm × 25 mm × 300 mm) | 1 | 10 | For hand-cut flexures |
| Compression springs, assorted | 20 | 10 | |
| Linear ball bearings (608ZZ skate bearings) | 10 | 10 | Universal precision bearing |
| Precision ground steel balls (6 mm) | 10 | 5 | For kinematic mounts |
| Aluminum extrusion (20×20, 500 mm) | 2 | 10 | For benchtop structures |
| Carbon fiber tube (10 mm OD, 300 mm) | 1 | 15 | Feel the stiffness-to-weight |
| MPU6050 breakout (accelerometer + gyro) | 2 | 8 | Measure your own motion |

### Teardown targets

- Kitchen scale → strain-gauge bridge + ADC.
- Dead printer → linear rails, lead screws, flexure-mounted print heads.
- Old hard-drive head stack → ultra-precision flexure assembly.
- Any watch → gears, bearings, hairspring (the perfect flexure).

### Three builds

1. **Strain-gauge cantilever** — glue a gauge to an aluminum ruler, clamp one end, press the other, read the HX711 on an Arduino.
2. **Monolithic flexure** — nibble or hacksaw a parallel-blade flexure from spring steel. Verify no backlash by hand.
3. **Kinematic mount** — three divots, three balls. Lift and replace. Measure return position with a dial indicator (or a laser pointer bouncing off).

### Measurement wins

- You can wire a Wheatstone bridge from memory.
- You know what "exact constraint" means and can draw a six-point kinematic mount.

**Bench 3 total: ~$115**

---

## Bench 4 — Fluidic

### What's on it

Syringes, tubes, pressure gauges, a hand pump. Hydraulic and pneumatic principles, kitchen-table scale.

### BOM — components

| Item | Qty | Cost | Notes |
|---|---|---|---|
| Syringes (10 mL, 60 mL, no needle) | 5 each | 8 | Clear plastic, Luer-lock preferred |
| Silicone tubing (3 mm ID, 5 m) | 1 | 8 | |
| Luer-lock fittings assortment | 1 kit | 10 | Tees, barbs, valves |
| Hand vacuum pump (brake-bleeder type) | 1 | 25 | Pulls to ~−25 inHg |
| Bicycle pump with gauge | 1 | 15 | Positive-pressure side |
| Pressure sensors (BMP280 breakout, 0–110 kPa absolute) | 2 | 5 | Also measures altitude |
| Differential pressure sensor (MPX5010DP) | 1 | 15 | For flow calculations |
| Pneumatic cylinder (small, 10 mm bore, 25 mm stroke) | 1 | 10 | 1/8" NPT fittings |
| Micro peristaltic pump (12 V DC) | 1 | 15 | Dose-pumping, no cross-contamination |
| Food coloring | 1 bottle | 2 | For Reynolds-number visualization |

### Teardown targets

- A broken coffee machine → peristaltic pump + solenoid valve + pressure switch.
- Old sphygmomanometer → aneroid pressure gauge mechanism.
- Dead pneumatic nail gun (if you can scrounge one) → piston, O-rings, trigger valve.

### Three builds

1. **Syringe hydraulics** — connect two syringes with tubing. Fill with water (no air). Verify force multiplication.
2. **Reynolds-number demo** — slowly inject dye into clear tube flow. Watch transition from laminar to turbulent.
3. **Pressure-logger** — BMP280 + Arduino + laptop. Log pressure for a day; see your weather on a graph.

### Measurement wins

- You feel the difference between compressible and incompressible media.
- You can predict a hydraulic lift's force from piston area and input pressure.

**Bench 4 total: ~$115**

---

## Bench 5 — Thermal

### What's on it

Thermocouples, RTDs, a Peltier module, Nitinol wire, a bimetal strip. The pile where everything is slow.

### BOM — components

| Item | Qty | Cost | Notes |
|---|---|---|---|
| Thermocouple wire (Type K, chromel-alumel, 10 m each) | 1 | 15 | Make your own junctions |
| MAX6675 or MAX31855 breakout (Type K reader) | 2 | 8 | SPI output |
| RTD (Pt100, 2-wire + Pt1000, surface-mount) | 2 each | 10 | |
| MAX31865 breakout (RTD reader) | 1 | 10 | |
| NTC thermistor assortment (10 kΩ @ 25 °C, bead) | 10 | 5 | |
| Peltier module (TEC1-12706, 40×40 mm) | 2 | 10 | 60 W each |
| CPU heatsink + fan (for Peltier hot side) | 1 | 10 | |
| Nitinol wire (0.5 mm, 1 m, body-temperature actuation) | 1 | 15 | Shape-settable |
| Bimetal strip (or snap-disc thermostat) | 2 | 5 | |
| IR non-contact thermometer | 1 | 20 | Verify your thermocouple readings |
| Thermal paste (1 g syringe) | 1 | 3 | |
| Candle, matches | — | 5 | Cheap variable heat source |

### Teardown targets

- Old mercury thermostat → bimetal coil, mercury switch (now illegal but you may still have one).
- USB mini-fridge → Peltier module + heatsink stack.
- Hairdryer → nichrome heater coil + bimetal cutoff.
- Old iron → thermostat with bimetal + adjustment screw.

### Three builds

1. **DIY Type K thermocouple** — twist-weld chromel and alumel with a propane torch. Compare to IR thermometer.
2. **Peltier swap** — hook to a battery, feel cold/hot. Flip polarity, sides swap.
3. **Nitinol spring** — wrap wire around a pencil, hold with pliers in a torch flame to shape-set at ~500 °C. Deform cold, drop in hot water, watch it spring back.

### Measurement wins

- You can estimate a thermal time constant from mass and surface area.
- You know why thermal systems set bandwidth in a sensor + actuator chain.

**Bench 5 total: ~$115**

---

## Bench 6 — Chemical

### What's on it

Electrodes, a pH meter, a glucose test strip, two different metals in salt water. The pile where millivolts mean concentration.

### BOM — components

| Item | Qty | Cost | Notes |
|---|---|---|---|
| pH meter (digital, pocket) | 1 | 15 | With calibration buffers |
| pH buffer solutions (pH 4, 7, 10) | 1 set | 10 | |
| Glucose test strips + lancet (any pharmacy meter) | 1 kit | 15 | For teardown; disposable |
| Zinc and copper strips (hobby-shop) | 5 each | 10 | For Volta cells |
| Silver wire + silver chloride (or SMD Ag/AgCl pellet) | 1 each | 10 | Reference electrode |
| Platinum wire (0.2 mm, 100 mm) | 1 | 25 | Expensive but essential |
| Electrolyte salts (NaCl, KCl, CuSO₄, lemon juice) | 1 each | 5 | Household + hardware store |
| CO/CO₂/smoke sensor module (MQ-series, MH-Z19) | 2 | 15 | Metal-oxide and NDIR |
| Humidity + temp sensor (DHT22 or SHT31) | 2 | 10 | Capacitive humidity |
| pH probe (BNC-type replacement) | 1 | 20 | Open it (gently) to see the glass bulb and reference |
| Lemons, potatoes | — | 2 | Classic batteries |

### Teardown targets

- Any disposable glucose meter + strip → platinum trace, enzyme spot, reference line.
- Old smoke detector (ionization type — **handle carefully, has small Am-241 source**) OR photoelectric detector → IR LED + photodiode.
- Dead alkaline battery → zinc anode, MnO₂ cathode, KOH electrolyte.

### Three builds

1. **Volta's pile** — alternate copper and zinc coins with brine-soaked cardboard. Light an LED with a stack of 10.
2. **Salt-concentration cell** — two copper strips in CuSO₄ solutions of different concentrations. Measure the Nernst voltage — about 30 mV per decade for the Cu²⁺/Cu couple.
3. **Lemon battery array** — four lemons in series will blink an Arduino's LED.

### Measurement wins

- You can apply the Nernst equation to a half-cell.
- You can distinguish amperometric from potentiometric sensing by looking at the signal.

**Bench 6 total: ~$135**

---

## Bench 7 — Radiant

### What's on it

LEDs, photodiodes, a laser pointer, lenses, a CCD out of an old camera. The pile that scales from quantum effects to everyday light.

### BOM — components

| Item | Qty | Cost | Notes |
|---|---|---|---|
| Laser pointers (red, green) | 1 each | 10 | <5 mW; eye-safe class II |
| Photodiodes (BPW34 silicon, 300–1100 nm) | 5 | 5 | |
| Phototransistors (TEMT6000 ambient-light) | 3 | 5 | |
| LEDs (red, green, blue, white, IR 940 nm, UV 395 nm) | 10 each | 10 | Measure threshold voltages |
| TSL2591 or VEML7700 breakout (light sensor) | 1 | 10 | Calibrated lux readings |
| TCS34725 breakout (color sensor) | 1 | 8 | RGB + clear |
| ToF distance sensor (VL53L0X or VL53L1X) | 2 | 10 | Lidar in miniature |
| Diffraction grating sheet (1000 lines/mm) | 1 | 5 | |
| Lenses (biconvex 25 mm f/50; plano-convex 25 mm f/100) | 2 each | 10 | For hand optics bench |
| Front-surface mirror (50×50 mm) | 2 | 10 | |
| Polarizing film (sheet) | 1 | 5 | |
| Index cards, foil, pins | — | 2 | Hand-cut slits for Young's experiment |
| Fiber-optic patch cable (any FC/PC multimode) | 1 | 10 | Teardown target |

### Teardown targets

- Old digital camera → CCD or CMOS imager + optical stack.
- Blu-ray drive → GaN laser diode, pickup head optics.
- TV remote → IR LED (point your phone camera at it, you'll see the invisible blink).
- Dead smartphone → tiny lenses, image sensor, maybe a VCSEL for FaceID.
- Broken fluorescent tube (**handle carefully — contains mercury**) → phosphor coating.

### Three builds

1. **Young's double-slit** — foil, pin, laser pointer. Project fringes on a wall across the room.
2. **Photodiode darkroom** — BPW34 into an op-amp transimpedance amp. Measure your room's ambient light in nanoamps.
3. **Grating spectrometer** — slit, grating, screen. Compare an incandescent bulb's spectrum to a fluorescent tube's and an LED's.

### Measurement wins

- You can compute photon energy for a wavelength and match it to a detector.
- You can set up and read a Michelson interferometer conceptually.

**Bench 7 total: ~$100**

---

## Grand Total

| Bench | Cost |
|---|---|
| Universal starter kit | 160–250 |
| Bench 1 — Electrical | 100 |
| Bench 2 — Magnetic | 95 |
| Bench 3 — Mechanical | 115 |
| Bench 4 — Fluidic | 115 |
| Bench 5 — Thermal | 115 |
| Bench 6 — Chemical | 135 |
| Bench 7 — Radiant | 100 |
| **Total (budget)** | **~$935** |
| **Total (one weekend of teardowns + minimal buys)** | **~$500** |

Most of what makes this work isn't on the shopping list — it's on the free side: broken electronics from recycling bins, defunct printers, old speakers, hard drives, kitchen scales. Every one of those is a working example of two or three domains at once, and taking them apart teaches more than any purchased kit.

---

## Where to buy

- **Electronics:** DigiKey, Mouser (new, authoritative), Adafruit, SparkFun (hobby-friendly), AliExpress (cheap, slow, caveat emptor).
- **Magnets:** K&J Magnetics (US), supermagnete.de (EU) — avoid random Amazon listings for serious work.
- **Mechanical:** McMaster-Carr (US gold standard, same-day), Misumi (modular hardware), MSC Direct.
- **Chemicals / probes:** Cole-Parmer, Thermo Fisher, Hanna Instruments (consumer pH meters).
- **Optics:** Thorlabs, Edmund Optics (serious), AliExpress (teardown-grade).
- **Teardown stock:** your own recycling bin, eBay "untested" lots, local repair shops that would otherwise bin the broken stuff.

---

## How to use these benches

1. **One bench at a time.** Set it up on a card table or in a drawer. Clear it when done. Rotate.
2. **Start with teardowns, not purchases.** You'll know what to buy once you've seen what's inside the free stuff.
3. **Build the three listed exercises on each bench before moving on.** Not three like the ones listed — those three.
4. **Measure before, during, after.** The whole point is to turn invisible phenomena into numbers on a meter.
5. **Keep a notebook per bench.** Date every entry. Sketch every teardown. Write down what surprised you.
