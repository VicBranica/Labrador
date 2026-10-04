# Arduino

[← Development boards & breakouts](index.md) · [Course 05 index](../index.md)

| | |
|---|---|
| Type | Manufacturer / open-hardware platform |
| Headquarters | Italy (project origin: Ivrea) |
| Founded | 2005 |
| Owner / parent | Qualcomm (acquisition announced October 2025) |
| Website | [www.arduino.cc](https://www.arduino.cc) |
| Cited in | course01, course04 |

## What they make

Open-source microcontroller boards (Uno, Nano, Mega), the Arduino IDE and libraries.

## Why it's in the courses

The Arduino Uno reads the HX711, BMP280, thermocouple and light-sensor breakouts in the builds. The project began at the Interaction Design Institute Ivrea; Qualcomm announced it was acquiring Arduino in October 2025, with Arduino keeping its brand and multi-vendor chip support.

## Cited in the courses

| File | Section | Mention |
|---|---|---|
| [course01/Lesson10.md](../../course01/Lesson10.md#3-what-to-build) | 3. What to build | …d read it through the `5.2.2` RTD breakout on the Arduino (`S.5.4`). |
| [course01/Lesson10.md](../../course01/Lesson10.md#3-what-to-build) | 3. What to build | …through a `1.2.5` logic-level MOSFET driven by an Arduino pin. Check the supply's current limit first. |
| [course04/00-starter-kit.md](../../course04/00-starter-kit.md#multilevel-bom--nice-to-have-add-when-you-need-them) | Multilevel BOM — nice-to-have (add when you need them) | 2 S.5.4 Arduino Uno or Raspberry Pi Pico 1 10–25 For all benches |
| [course04/00-starter-kit.md](../../course04/00-starter-kit.md#where-used) | Where used | `S.5.4` Arduino Uno or Raspberry Pi Pico B1.4 MOSFET motor speed control, B2.4 Hall-effect tachometer, B3.1 Strain-gauge cantilever, B3.4 Li… |
| [course04/01-bench-electrical.md](../../course04/01-bench-electrical.md#build-4--mosfet-motor-speed-control) | Build 4 — MOSFET motor speed control | …diode across the motor to catch its back-EMF. The Arduino reads a potentiometer and sets the PWM duty cycle. Run the motor from stop to full… |
| [course04/01-bench-electrical.md](../../course04/01-bench-electrical.md#build-4--mosfet-motor-speed-control) | Build 4 — MOSFET motor speed control | Starter kit `S.5.4` Arduino Uno or Raspberry Pi Pico · `S.3.1` Soldering iron · `S.3.2` Solder · `S.3.6` Wire strippers · `S.5.1` USB oscill… |
| [course04/02-bench-magnetic.md](../../course04/02-bench-magnetic.md#build-4--hall-effect-tachometer) | Build 4 — Hall-effect tachometer | …sor beside the magnet and count its pulses on the Arduino: one pulse per revolution gives RPM. Swap in a reed switch and raise the speed unt… |
| [course04/02-bench-magnetic.md](../../course04/02-bench-magnetic.md#build-4--hall-effect-tachometer) | Build 4 — Hall-effect tachometer | Starter kit `S.5.4` Arduino Uno or Raspberry Pi Pico · `S.2.1` Breadboard, solderless · `S.2.2` Jumper wire kit |
| [course04/03-bench-mechanical.md](../../course04/03-bench-mechanical.md#multilevel-bom) | Multilevel BOM | 2 3.1.3 HX711 load-cell amplifier breakout 2 6 24-bit ADC, Arduino-friendly |
| [course04/03-bench-mechanical.md](../../course04/03-bench-mechanical.md#build-1--strain-gauge-cantilever) | Build 1 — Strain-gauge cantilever | Glue a gauge to an aluminum ruler, clamp one end, press the other, read the HX711 on an Arduino. |
| [course04/03-bench-mechanical.md](../../course04/03-bench-mechanical.md#build-1--strain-gauge-cantilever) | Build 1 — Strain-gauge cantilever | Starter kit `S.5.4` Arduino Uno or Raspberry Pi Pico · `S.2.2` Jumper wire kit · `S.3.7` Small bench vise or two 100 mm C-clamps |
| [course04/03-bench-mechanical.md](../../course04/03-bench-mechanical.md#build-4--linear-bearing-slide) | Build 4 — Linear-bearing slide | Starter kit `S.5.4` Arduino Uno or Raspberry Pi Pico · `S.2.2` Jumper wire kit · `S.3.5` Hex key set |
| [course04/04-bench-fluidic.md](../../course04/04-bench-fluidic.md#multilevel-bom) | Multilevel BOM | …luidic flow variable. Pulse output; read with the Arduino. Barb adapters to the `4.1.2` tubing |
| [course04/04-bench-fluidic.md](../../course04/04-bench-fluidic.md#build-3--pressure-logger) | Build 3 — Pressure-logger | BMP280 + Arduino + laptop. Log pressure for a day; see your weather on a graph. |
| [course04/04-bench-fluidic.md](../../course04/04-bench-fluidic.md#build-3--pressure-logger) | Build 3 — Pressure-logger | Starter kit `S.5.4` Arduino Uno or Raspberry Pi Pico · `S.2.2` Jumper wire kit |
| [course04/04-bench-fluidic.md](../../course04/04-bench-fluidic.md#build-4--gravity-fed-flow-loop) | Build 4 — Gravity-fed flow loop | …alve and the flow sensor. Open the valve from the Arduino through a MOSFET, count the flow sensor's pulses to get Q, and read the pressure d… |
| [course04/04-bench-fluidic.md](../../course04/04-bench-fluidic.md) | | …and 1 more mentions |
| [course04/05-bench-thermal.md](../../course04/05-bench-thermal.md#build-1--diy-type-k-thermocouple) | Build 1 — DIY Type K thermocouple | Starter kit `S.5.4` Arduino Uno or Raspberry Pi Pico |
| [course04/05-bench-thermal.md](../../course04/05-bench-thermal.md#build-4--nichrome-heater-and-bimetal-thermostat) | Build 4 — Nichrome heater and bimetal thermostat | …er kit `S.5.2` Benchtop DC power supply · `S.5.4` Arduino Uno or Raspberry Pi Pico · `S.2.1` Breadboard, solderless · `S.2.2` Jumper wire ki… |
| [course04/06-bench-chemical.md](../../course04/06-bench-chemical.md#build-3--lemon-battery-array) | Build 3 — Lemon battery array | Four lemons in series will blink an Arduino's LED. |
| [course04/06-bench-chemical.md](../../course04/06-bench-chemical.md#build-3--lemon-battery-array) | Build 3 — Lemon battery array | Starter kit `S.5.4` Arduino Uno or Raspberry Pi Pico · `S.2.2` Jumper wire kit |
| [course04/07-bench-radiant.md](../../course04/07-bench-radiant.md#build-4--inverse-square-law) | Build 4 — Inverse-square law | Starter kit `S.5.4` Arduino Uno or Raspberry Pi Pico · `S.2.1` Breadboard, solderless · `S.2.2` Jumper wire kit |

## Sources

- <https://en.wikipedia.org/wiki/Arduino>
- <https://www.phoronix.com/news/Qualcomm-Acquires-Arduino>
