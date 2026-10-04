# Course 05 — Manufacturers & Brands

> **Course 05 of 05 — Manufacturers & brands** · [← course04](../course04/index.md) · [Project map](../../index.md)
>
> Every manufacturer, brand, trade name and supplier cited in courses 01–04, researched: who they are, what they make, why they appear in the courses, and every place they're cited.
>
> **Builds on:** course01 (materials and equipment), course03 (domain stack and piles), course04 (BOMs and where to buy)  
> **Feeds into:** course04 (where to source each BOM item)

## How to read this course

- One folder per category, one file per company.
- Each company file has a fact table (type, headquarters, founded, owner, website), what they make, why they're in the courses, a **Cited in the courses** table linking to every mention, and sources.
- Part numbers in the BOMs (LM358, HX711, BMP280, …) are filed under the chip maker. Many are multi-sourced or cloned — the file says so where it matters.
- Trade-name materials (Viton, Hastelloy, Invar, …) are filed under the company that owns the name today, with the history of who first made it.
- Facts marked "—" weren't confirmed during research and are left blank rather than guessed.

## Categories

| # | Category | Companies |
|---|---|---|
| 01 | [Instruments & tools](01-instruments-and-tools/index.md) | 10 |
| 02 | [Development boards & breakouts](02-boards-and-modules/index.md) | 4 |
| 03 | [Semiconductor manufacturers](03-semiconductors/index.md) | 16 |
| 04 | [Sensor & module makers](04-sensor-and-module-makers/index.md) | 4 |
| 05 | [Motion & fluid power](05-motion-and-fluid-power/index.md) | 3 |
| 06 | [Materials & trade names](06-materials-and-trade-names/index.md) | 13 |
| 07 | [Suppliers & distributors](07-suppliers/index.md) | 14 |
| | **Total** | **64** |

## Products and material codes

- **Products cited** — what the courses name from each company.
- **BOM code** — the course04 item number (the lab's material code). Click through to the bench file. Generated from the BOM tables.
- **Material / grade code** — for trade-name materials, the common grade and its standard designation (UNS, EN, ASTM, IEC, SAE). The courses name only the brand, so these are the usual grades, not a specific purchase.

### [Instruments & tools](01-instruments-and-tools/index.md)

| Company | Products cited | BOM code (course04) | Material / grade code |
|---|---|---|---|
| [AstroAI](01-instruments-and-tools/astroai.md) | 6000-count digital multimeter | [`S.1.1`](../course04/00-starter-kit.md) | — |
| [Fluke Corporation](01-instruments-and-tools/fluke.md) | Fluke 101 multimeter | [`S.1.1`](../course04/00-starter-kit.md) | — |
| [Hakko Corporation](01-instruments-and-tools/hakko.md) | FX-888D soldering station | [`S.3.1`](../course04/00-starter-kit.md) | — |
| [PINE64 (Pine Store Ltd.)](01-instruments-and-tools/pine64.md) | Pinecil soldering iron | [`S.3.1`](../course04/00-starter-kit.md) | — |
| [Mitutoyo Corporation](01-instruments-and-tools/mitutoyo.md) | 150 mm digital calipers | [`S.1.2`](../course04/00-starter-kit.md) | — |
| [Hantek (Qingdao Hantek Electronic Co., Ltd.)](01-instruments-and-tools/hantek.md) | 6022BE USB oscilloscope | [`S.5.1`](../course04/00-starter-kit.md) | — |
| [Teledyne FLIR](01-instruments-and-tools/teledyne-flir.md) | FLIR One phone thermal camera | [`S.5.5`](../course04/00-starter-kit.md) | — |
| [InfiRay (IRay Technology Co., Ltd.)](01-instruments-and-tools/infiray.md) | P2 phone thermal camera | [`S.5.5`](../course04/00-starter-kit.md) | — |
| [Instron](01-instruments-and-tools/instron.md) | Universal testing machine (historical — Nitinol, 1962) | — | — |
| [Hanna Instruments](01-instruments-and-tools/hanna-instruments.md) | Pocket pH meters | — | — |

### [Development boards & breakouts](02-boards-and-modules/index.md)

| Company | Products cited | BOM code (course04) | Material / grade code |
|---|---|---|---|
| [Arduino](02-boards-and-modules/arduino.md) | Arduino Uno | [`S.5.4`](../course04/00-starter-kit.md) | — |
| [Raspberry Pi Ltd](02-boards-and-modules/raspberry-pi.md) | Raspberry Pi Pico | [`S.5.4`](../course04/00-starter-kit.md) | — |
| [Adafruit Industries](02-boards-and-modules/adafruit.md) | Sensor breakout boards | — | — |
| [SparkFun Electronics](02-boards-and-modules/sparkfun.md) | Sensor breakout boards | — | — |

### [Semiconductor manufacturers](03-semiconductors/index.md)

| Company | Products cited | BOM code (course04) | Material / grade code |
|---|---|---|---|
| [Texas Instruments](03-semiconductors/texas-instruments.md) | LM358, TL072 op-amps · DRV8833 motor driver | [`1.2.3`](../course04/01-bench-electrical.md) · [`2.4.4`](../course04/02-bench-magnetic.md) | — |
| [Microchip Technology](03-semiconductors/microchip.md) | MCP6002 op-amp | [`1.2.3`](../course04/01-bench-electrical.md) | — |
| [Infineon Technologies](03-semiconductors/infineon.md) | IRLZ44N MOSFET | [`1.2.5`](../course04/01-bench-electrical.md) | — |
| [onsemi](03-semiconductors/onsemi.md) | 2N3904 / 2N3906 / BC547 transistors · 2N7000 MOSFET · 1N4148 / 1N4007 / 1N5819 diodes | [`1.2.2`](../course04/01-bench-electrical.md) · [`1.2.4`](../course04/01-bench-electrical.md) · [`1.2.5`](../course04/01-bench-electrical.md) | — |
| [Silicon Labs](03-semiconductors/silicon-labs.md) | CP2102 USB–UART bridge | [`1.4.1`](../course04/01-bench-electrical.md) | — |
| [WCH (Nanjing Qinheng Microelectronics)](03-semiconductors/wch.md) | CH340 USB–serial chip | [`1.4.1`](../course04/01-bench-electrical.md) | — |
| [Allegro MicroSystems](03-semiconductors/allegro.md) | A3144 Hall switch (discontinued) · A1324 linear Hall sensor | [`2.3.1`](../course04/02-bench-magnetic.md) | — |
| [STMicroelectronics](03-semiconductors/stmicroelectronics.md) | L298N H-bridge · VL53L0X / VL53L1X time-of-flight sensors | [`2.4.4`](../course04/02-bench-magnetic.md) · [`7.3.3`](../course04/07-bench-radiant.md) | — |
| [Avia Semiconductor](03-semiconductors/avia-semiconductor.md) | HX711 24-bit load-cell ADC | [`3.1.3`](../course04/03-bench-mechanical.md) | — |
| [TDK InvenSense](03-semiconductors/tdk-invensense.md) | MPU6050 6-axis IMU | [`3.5.1`](../course04/03-bench-mechanical.md) | — |
| [Bosch Sensortec](03-semiconductors/bosch-sensortec.md) | BMP280 barometric pressure sensor | [`4.3.1`](../course04/04-bench-fluidic.md) | — |
| [NXP Semiconductors](03-semiconductors/nxp.md) | MPX5010DP differential pressure sensor | [`4.3.2`](../course04/04-bench-fluidic.md) | — |
| [Analog Devices](03-semiconductors/analog-devices.md) | MAX6675 / MAX31855 thermocouple readers · MAX31865 RTD reader | [`5.1.2`](../course04/05-bench-thermal.md) · [`5.2.2`](../course04/05-bench-thermal.md) | — |
| [Vishay Intertechnology](03-semiconductors/vishay.md) | BPW34 photodiode · TEMT6000 phototransistor · VEML7700 light sensor | [`7.2.1`](../course04/07-bench-radiant.md) · [`7.2.2`](../course04/07-bench-radiant.md) · [`7.3.1`](../course04/07-bench-radiant.md) | — |
| [ams OSRAM](03-semiconductors/ams-osram.md) | TSL2591 light sensor · TCS34725 color sensor | [`7.3.1`](../course04/07-bench-radiant.md) · [`7.3.2`](../course04/07-bench-radiant.md) | — |
| [Sensirion](03-semiconductors/sensirion.md) | SHT31 humidity + temperature sensor | [`6.4.2`](../course04/06-bench-chemical.md) | — |

### [Sensor & module makers](04-sensor-and-module-makers/index.md)

| Company | Products cited | BOM code (course04) | Material / grade code |
|---|---|---|---|
| [Hanwei Electronics](04-sensor-and-module-makers/hanwei.md) | MQ-series metal-oxide gas sensors | [`6.4.1`](../course04/06-bench-chemical.md) | — |
| [Winsen (Zhengzhou Winsen Electronics Technology)](04-sensor-and-module-makers/winsen.md) | MH-Z19 NDIR CO₂ sensor | [`6.4.1`](../course04/06-bench-chemical.md) | — |
| [Aosong Electronics](04-sensor-and-module-makers/aosong.md) | DHT22 (AM2302) humidity + temperature sensor | [`6.4.2`](../course04/06-bench-chemical.md) | — |
| [Hebei I.T. (Shanghai) Co., Ltd.](04-sensor-and-module-makers/hebei-it.md) | TEC1-12706 Peltier module | [`5.3.1`](../course04/05-bench-thermal.md) | — |

### [Motion & fluid power](05-motion-and-fluid-power/index.md)

| Company | Products cited | BOM code (course04) | Material / grade code |
|---|---|---|---|
| [Moog Inc.](05-motion-and-fluid-power/moog.md) | Two-stage electrohydraulic servo valve | — | — |
| [Vickers (now Danfoss Power Solutions)](05-motion-and-fluid-power/vickers-danfoss.md) | Hydraulic vane pumps and servo valves | — | — |
| [HIWIN Technologies](05-motion-and-fluid-power/hiwin.md) | MGN12H carriage on MGN12 rail | [`3.3.1.9`](../course04/03-bench-mechanical.md) | Rail and carriage: bearing steel |

### [Materials & trade names](06-materials-and-trade-names/index.md)

| Company | Products cited | BOM code (course04) | Material / grade code |
|---|---|---|---|
| [Henkel (Loctite)](06-materials-and-trade-names/henkel-loctite.md) | Loctite 496 cyanoacrylate | [`3.1.2`](../course04/03-bench-mechanical.md) | Methyl cyanoacrylate |
| [Metglas, Inc.](06-materials-and-trade-names/metglas.md) | Amorphous metal ribbon | — | 2605SA1 (Fe-Si-B) |
| [VACUUMSCHMELZE (VAC)](06-materials-and-trade-names/vacuumschmelze.md) | Vitrovac amorphous alloy | — | Vitrovac 6025 (Co-based amorphous) |
| [Eastman Chemical (Skydrol)](06-materials-and-trade-names/eastman-skydrol.md) | Skydrol aviation hydraulic fluid | — | Phosphate ester, SAE AS1241 (e.g. Skydrol LD-4, 500B-4) |
| [Chemours](06-materials-and-trade-names/chemours.md) | Viton seals · Nafion membrane | — | Viton = FKM (ASTM D1418) · Nafion = PFSA |
| [DuPont](06-materials-and-trade-names/dupont.md) | Kapton polyimide film | — | Polyimide (PI), e.g. Kapton HN |
| [Sorbothane, Inc.](06-materials-and-trade-names/sorbothane.md) | Sorbothane damping material | — | Polyether-based polyurethane |
| [Haynes International (Hastelloy)](06-materials-and-trade-names/haynes.md) | Hastelloy alloy | — | Hastelloy C-276 = UNS N10276 |
| [Special Metals Corporation (Inconel)](06-materials-and-trade-names/special-metals.md) | Inconel alloy | — | Inconel 600 = UNS N06600 |
| [SCHOTT AG (Zerodur)](06-materials-and-trade-names/schott.md) | Zerodur glass-ceramic | — | Li₂O-Al₂O₃-SiO₂ glass-ceramic |
| [Aperam Alloys Imphy (Invar)](06-materials-and-trade-names/aperam-imphy.md) | Invar alloy | — | Invar 36 = UNS K93603, EN 1.3912 (FeNi36) |
| [Magnetic Shield Corporation (MuMETAL)](06-materials-and-trade-names/magnetic-shield-corp.md) | MuMETAL shielding alloy | — | ASTM A753 Alloy 4 (~80% Ni) |
| [Concept Alloys (Chromel / Alumel)](06-materials-and-trade-names/concept-alloys.md) | Chromel / Alumel thermocouple wire | [`5.1.1`](../course04/05-bench-thermal.md) | Type K legs: Chromel = KP, Alumel = KN (IEC 60584) |

### [Suppliers & distributors](07-suppliers/index.md)

| Company | Products cited | BOM code (course04) | Material / grade code |
|---|---|---|---|
| [DigiKey](07-suppliers/digikey.md) | Electronic components | — | — |
| [Mouser Electronics](07-suppliers/mouser.md) | Electronic components | — | — |
| [AliExpress](07-suppliers/aliexpress.md) | Electronics, teardown-grade optics | — | — |
| [McMaster-Carr](07-suppliers/mcmaster-carr.md) | Mechanical parts | — | — |
| [MISUMI](07-suppliers/misumi.md) | Modular mechanical hardware | — | — |
| [MSC Industrial Supply (MSC Direct)](07-suppliers/msc-industrial.md) | Mechanical parts | — | — |
| [Cole-Parmer](07-suppliers/cole-parmer.md) | Chemicals, probes | — | — |
| [Thermo Fisher Scientific](07-suppliers/thermo-fisher.md) | Chemicals, probes | — | — |
| [Thorlabs](07-suppliers/thorlabs.md) | Optics | — | — |
| [Edmund Optics](07-suppliers/edmund-optics.md) | Optics | — | — |
| [K&J Magnetics](07-suppliers/kj-magnetics.md) | NdFeB magnets | — | — |
| [supermagnete (Webcraft)](07-suppliers/supermagnete.md) | NdFeB magnets | — | — |
| [eBay](07-suppliers/ebay.md) | Teardown stock ("untested" lots) | — | — |
| [Amazon](07-suppliers/amazon.md) | General (avoid for magnets) | — | — |

## All companies

| Company | Category | Type | Cited in |
|---|---|---|---|
| [Adafruit Industries](02-boards-and-modules/adafruit.md) | Development boards & breakouts | Manufacturer and retailer | course04 |
| [AliExpress](07-suppliers/aliexpress.md) | Suppliers & distributors | Marketplace | course04 |
| [Allegro MicroSystems](03-semiconductors/allegro.md) | Semiconductor manufacturers | Manufacturer | course04 |
| [Amazon](07-suppliers/amazon.md) | Suppliers & distributors | Marketplace | course04 |
| [ams OSRAM](03-semiconductors/ams-osram.md) | Semiconductor manufacturers | Manufacturer | course04 |
| [Analog Devices](03-semiconductors/analog-devices.md) | Semiconductor manufacturers | Manufacturer | course04 |
| [Aosong Electronics](04-sensor-and-module-makers/aosong.md) | Sensor & module makers | Manufacturer | course04 |
| [Aperam Alloys Imphy (Invar)](06-materials-and-trade-names/aperam-imphy.md) | Materials & trade names | Manufacturer | course01, course02, course03 |
| [Arduino](02-boards-and-modules/arduino.md) | Development boards & breakouts | Manufacturer / open-hardware platform | course01, course04 |
| [AstroAI](01-instruments-and-tools/astroai.md) | Instruments & tools | Manufacturer (consumer brand) | course04 |
| [Avia Semiconductor](03-semiconductors/avia-semiconductor.md) | Semiconductor manufacturers | Manufacturer | course04 |
| [Bosch Sensortec](03-semiconductors/bosch-sensortec.md) | Semiconductor manufacturers | Manufacturer | course04 |
| [Chemours](06-materials-and-trade-names/chemours.md) | Materials & trade names | Manufacturer | course01, course02, course03 |
| [Cole-Parmer](07-suppliers/cole-parmer.md) | Suppliers & distributors | Distributor and manufacturer | course04 |
| [Concept Alloys (Chromel / Alumel)](06-materials-and-trade-names/concept-alloys.md) | Materials & trade names | Manufacturer | course01, course03, course04 |
| [DigiKey](07-suppliers/digikey.md) | Suppliers & distributors | Distributor | course04 |
| [DuPont](06-materials-and-trade-names/dupont.md) | Materials & trade names | Manufacturer | course01 |
| [Eastman Chemical (Skydrol)](06-materials-and-trade-names/eastman-skydrol.md) | Materials & trade names | Manufacturer | course01, course03 |
| [eBay](07-suppliers/ebay.md) | Suppliers & distributors | Marketplace | course04 |
| [Edmund Optics](07-suppliers/edmund-optics.md) | Suppliers & distributors | Manufacturer | course04 |
| [Fluke Corporation](01-instruments-and-tools/fluke.md) | Instruments & tools | Manufacturer | course04 |
| [Hakko Corporation](01-instruments-and-tools/hakko.md) | Instruments & tools | Manufacturer | course04 |
| [Hanna Instruments](01-instruments-and-tools/hanna-instruments.md) | Instruments & tools | Manufacturer | course04 |
| [Hantek (Qingdao Hantek Electronic Co., Ltd.)](01-instruments-and-tools/hantek.md) | Instruments & tools | Manufacturer | course04 |
| [Hanwei Electronics](04-sensor-and-module-makers/hanwei.md) | Sensor & module makers | Manufacturer | course04 |
| [Haynes International (Hastelloy)](06-materials-and-trade-names/haynes.md) | Materials & trade names | Manufacturer | course01, course02, course03 |
| [Hebei I.T. (Shanghai) Co., Ltd.](04-sensor-and-module-makers/hebei-it.md) | Sensor & module makers | Manufacturer | course04 |
| [Henkel (Loctite)](06-materials-and-trade-names/henkel-loctite.md) | Materials & trade names | Manufacturer | course04 |
| [HIWIN Technologies](05-motion-and-fluid-power/hiwin.md) | Motion & fluid power | Manufacturer | course04 |
| [Infineon Technologies](03-semiconductors/infineon.md) | Semiconductor manufacturers | Manufacturer | course04 |
| [InfiRay (IRay Technology Co., Ltd.)](01-instruments-and-tools/infiray.md) | Instruments & tools | Manufacturer | course04 |
| [Instron](01-instruments-and-tools/instron.md) | Instruments & tools | Manufacturer | course01, course03 |
| [K&J Magnetics](07-suppliers/kj-magnetics.md) | Suppliers & distributors | Supplier | course04 |
| [Magnetic Shield Corporation (MuMETAL)](06-materials-and-trade-names/magnetic-shield-corp.md) | Materials & trade names | Manufacturer | course01, course03 |
| [McMaster-Carr](07-suppliers/mcmaster-carr.md) | Suppliers & distributors | Distributor | course04 |
| [Metglas, Inc.](06-materials-and-trade-names/metglas.md) | Materials & trade names | Manufacturer | course01, course03 |
| [Microchip Technology](03-semiconductors/microchip.md) | Semiconductor manufacturers | Manufacturer | course04 |
| [MISUMI](07-suppliers/misumi.md) | Suppliers & distributors | Distributor and manufacturer | course04 |
| [Mitutoyo Corporation](01-instruments-and-tools/mitutoyo.md) | Instruments & tools | Manufacturer | course04 |
| [Moog Inc.](05-motion-and-fluid-power/moog.md) | Motion & fluid power | Manufacturer | course01, course03 |
| [Mouser Electronics](07-suppliers/mouser.md) | Suppliers & distributors | Distributor | course04 |
| [MSC Industrial Supply (MSC Direct)](07-suppliers/msc-industrial.md) | Suppliers & distributors | Distributor | course04 |
| [NXP Semiconductors](03-semiconductors/nxp.md) | Semiconductor manufacturers | Manufacturer | course04 |
| [onsemi](03-semiconductors/onsemi.md) | Semiconductor manufacturers | Manufacturer | course04 |
| [PINE64 (Pine Store Ltd.)](01-instruments-and-tools/pine64.md) | Instruments & tools | Manufacturer | course04 |
| [Raspberry Pi Ltd](02-boards-and-modules/raspberry-pi.md) | Development boards & breakouts | Manufacturer | course04 |
| [SCHOTT AG (Zerodur)](06-materials-and-trade-names/schott.md) | Materials & trade names | Manufacturer | course01, course02, course03 |
| [Sensirion](03-semiconductors/sensirion.md) | Semiconductor manufacturers | Manufacturer | course04 |
| [Silicon Labs](03-semiconductors/silicon-labs.md) | Semiconductor manufacturers | Manufacturer | course04 |
| [Sorbothane, Inc.](06-materials-and-trade-names/sorbothane.md) | Materials & trade names | Manufacturer | course01 |
| [SparkFun Electronics](02-boards-and-modules/sparkfun.md) | Development boards & breakouts | Manufacturer and retailer | course04 |
| [Special Metals Corporation (Inconel)](06-materials-and-trade-names/special-metals.md) | Materials & trade names | Manufacturer | course01, course03 |
| [STMicroelectronics](03-semiconductors/stmicroelectronics.md) | Semiconductor manufacturers | Manufacturer | course04 |
| [supermagnete (Webcraft)](07-suppliers/supermagnete.md) | Suppliers & distributors | Supplier | course04 |
| [TDK InvenSense](03-semiconductors/tdk-invensense.md) | Semiconductor manufacturers | Manufacturer | course04 |
| [Teledyne FLIR](01-instruments-and-tools/teledyne-flir.md) | Instruments & tools | Manufacturer | course04 |
| [Texas Instruments](03-semiconductors/texas-instruments.md) | Semiconductor manufacturers | Manufacturer | course04 |
| [Thermo Fisher Scientific](07-suppliers/thermo-fisher.md) | Suppliers & distributors | Manufacturer and distributor | course04 |
| [Thorlabs](07-suppliers/thorlabs.md) | Suppliers & distributors | Manufacturer | course04 |
| [VACUUMSCHMELZE (VAC)](06-materials-and-trade-names/vacuumschmelze.md) | Materials & trade names | Manufacturer | course03 |
| [Vickers (now Danfoss Power Solutions)](05-motion-and-fluid-power/vickers-danfoss.md) | Motion & fluid power | Brand | course01, course03 |
| [Vishay Intertechnology](03-semiconductors/vishay.md) | Semiconductor manufacturers | Manufacturer | course01, course03, course04 |
| [WCH (Nanjing Qinheng Microelectronics)](03-semiconductors/wch.md) | Semiconductor manufacturers | Manufacturer | course04 |
| [Winsen (Zhengzhou Winsen Electronics Technology)](04-sensor-and-module-makers/winsen.md) | Sensor & module makers | Manufacturer | course04 |
