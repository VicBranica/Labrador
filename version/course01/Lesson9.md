# Lesson 9 — Cross-domain transducers

[← Lesson 7 — Radiant](Lesson7.md) · [All lessons](index.md#lessons) · [Lesson 10 — Integration & system design →](Lesson10.md)

> Across domains, 2 of 3, in nine steps: start with something you can hold, get one mental model, build it, then learn what it's made of, how it's made, what trick unlocked it, and who got there first.

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

**Theory:** [Module 8](index.md#module-8--cross-domain-transducers) · **Stack:** [Pillar 1 — Arrows between piles](../course03/p1-arrows-between-piles.md) and [Pillar 2 — Material + technique](../course03/p2-material-and-technique.md) · **Bench:** the benches each crossing comes from — [Bench 2](../course04/02-bench-magnetic.md), [Bench 3](../course04/03-bench-mechanical.md), [Bench 5](../course04/05-bench-thermal.md), [Bench 7](../course04/07-bench-radiant.md)

## 1. What you're looking at

*← start concrete*

A loudspeaker, a microphone, a hobby motor, a Peltier module, a phone camera. None of them lives in one domain. Each is a chain of arrows: electrical → magnetic → mechanical → sound, or light → charge → voltage.

## 2. The one thing to understand

*← give the mental model*

A transducer is a chain of domain crossings, and every crossing costs something: efficiency, noise, nonlinearity, bandwidth. Efficiencies multiply down the chain, and the slowest link sets the speed of the whole thing. And many crossings run **both ways**: the physics that turns current into force also turns motion into voltage.

The common crossings, their devices, materials and techniques: [Module 8](index.md#module-8--cross-domain-transducers).

## 3. What to build

*← hands on the bench*

1. Build the hand-wound motor from [Bench 2, Build 2](../course04/02-bench-magnetic.md#build-2--hand-wound-motor). Then take a `2.4.1` hobby motor, put the multimeter (`S.1.1`) on its terminals and spin the shaft by hand. It's a generator. Same part, arrow reversed.
2. Do the [Peltier swap](../course04/05-bench-thermal.md#build-2--peltier-swap) from Bench 5. Then disconnect the battery, set one face on a mug of hot water and the other on ice, and read the voltage. Peltier became Seebeck.
3. Connect the `2.6.4` old speaker to the multimeter's mV range or the scope (`S.5.1`) and tap the cone or shout into it. It's a microphone.
4. Shape-set the [Nitinol spring](../course04/05-bench-thermal.md#build-3--nitinol-spring), then heat it with current from the `1.3.1` 4×AA pack instead of hot water, in short bursts (the wire gets hot). Elec → Therm → Mech. Time how slowly it moves, and how slowly it relaxes: the thermal link sets the bandwidth.
5. Draw the full chain for the [strain-gauge cantilever](../course04/03-bench-mechanical.md#build-1--strain-gauge-cantilever) and the [photodiode darkroom](../course04/07-bench-radiant.md#build-2--photodiode-darkroom). Mark the material on every arrow.

Full BOMs: the benches above. Every part is already on one of them.

## 4. Key materials

*← what it's made of*

One material family per kind of crossing:

- **Mech ↔ Elec (piezo):** quartz, PZT, aluminum nitride.
- **Elec ↔ Mag ↔ Mech:** copper windings, NdFeB magnets, silicon-steel laminations — the motor triple.
- **Therm ↔ Elec:** Bi₂Te₃ (Peltier and thermoelectric generators), chromel/alumel and Pt/Rh (thermocouples).
- **Rad ↔ Elec:** Si, InGaAs and HgCdTe (detectors); GaN, AlGaInP and InGaAsP (LEDs and lasers).
- **Therm → Mech:** Nitinol (shape memory), Invar bonded to brass (bimetal).
- **Chem → Elec:** platinum electrodes, enzymes, Nafion membranes.

## 5. Key techniques

*← how it's made*

- **Draw the chain** — every arrow from first domain to last, with the material and technique on each. If you can't draw it, you don't understand the device.
- **Two-port thinking** — treat each crossing as a box with an effort and a flow on each side. Its coupling constant (Bl for a speaker, d₃₃ for a piezo, the Seebeck coefficient for a thermocouple) links the two sides.
- **Poling** — aligning the domains in PZT with a strong field so the material becomes piezoelectric.
- **Winding and lamination** — copper on silicon steel, the technique behind every motor and transformer.
- **Epitaxy (MOCVD)** — growing the crystal layers of LEDs, lasers and infrared detectors.
- **Shape-set anneal** — fixing a Nitinol shape at about 500 °C.
- **Count the crossings** — two designs for the same job: prefer the one with fewer arrows.

## 6. The clever trick

*← what unlocked the industry*

**Reciprocity: every actuator is also a sensor.** A motor is a generator, a speaker is a microphone, a Peltier cooler is a thermoelectric generator, a piezo buzzer is a knock sensor. Brushless motor drives use it to run without position sensors: they read the rotor's position from the back-EMF of the windings. Hard-drive and camera actuators sense their own motion the same way. One part, two jobs, no extra sensor.

## 7. Who to know

*← short lineage of names*

Seebeck (thermoelectricity, 1821), Faraday (induction, 1831), Peltier (1834), Thomson — Lord Kelvin (strain changes resistance, 1856; tied Seebeck and Peltier together), Hall (1879), Pierre and Jacques Curie (piezoelectricity, 1880), Lippmann (predicted the converse piezo effect, 1881), Buehler (Nitinol, Naval Ordnance Laboratory, early 1960s).

Timeline and people index: [Appendix A](index.md#appendix-a--timeline-of-key-discoveries) · [Appendix B](index.md#appendix-b--people-index).

## 8. The example everyone should work

*← optional — work it with pencil and paper*

A small woofer with force factor Bl = 5 T·m, voice-coil resistance Rₑ = 6 Ω, moving mass 20 g and suspension stiffness 1000 N/m — one crossing, worked in both directions:

1. As a motor: F = Bl · i. One amp through the coil gives 5 × 1 = 5 N on the cone.
2. As a generator: e = Bl · v. Push the cone at 0.01 m/s and the coil puts out 5 × 0.01 = 50 mV.
3. Check the units: T·m·A = N, and T·m·(m/s) = V. The same Bl is the force per amp *and* the volts per m/s. That's reciprocity.
4. Short the terminals. Now the generated voltage drives a current, i = Bl·v / Rₑ, which pushes back: F = (Bl)² / Rₑ · v. That's a damper with c = 25 / 6 ≈ 4.2 N·s/m.
5. The cone's resonance: fₛ = √(k/m) / 2π = √(1000 / 0.02) / 2π ≈ 35.6 Hz. Critical damping would need c = 2√(k·m) = 2√20 ≈ 8.9 N·s/m, so the shorted coil alone gives ζ ≈ 4.2 / 8.9 ≈ 0.47.
6. Read it: tap the cone with the terminals open and it rings. Short them and it thuds. The electrical load changes the mechanical behavior, because the two domains are coupled through one number, Bl. Amplifiers with low output impedance damp speakers exactly this way.

Compare with the spring-mass example in [Lesson 3](Lesson3.md#8-the-example-everyone-should-work): same three numbers, but here the damper is electrical.

More practice: the "Try it" exercises in [Module 8](index.md#module-8--cross-domain-transducers).

## 9. What to read later

*← optional — where to go deeper*

[Fraden](../course02/06-fraden-handbook-of-modern-sensors/) (every crossing as a sensor) · [Horowitz & Hill](../course02/04-horowitz-hill-art-of-electronics/) (the electrical side of every crossing) · [Bard & Faulkner](../course02/07-bard-faulkner-electrochemical-methods/) (chemical crossings) · [Hecht; Saleh & Teich](../course02/08-hecht-saleh-teich-optics-photonics/) (radiant crossings) · [Pillar 1](../course03/p1-arrows-between-piles.md) and [Pillar 2](../course03/p2-material-and-technique.md).
