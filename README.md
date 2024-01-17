# WiBCI16T_Application
This application aims to configure and acquire data from [NortekLabs](www.norteklabs.co.nz) **WiBCI16T** bio-potential amplifiers. 

## Requirements
* Windows 8 or above
* Minimum 8 GB of RAM (Recommended)

## Quick Start Guide
1. First, connect the PC to the WiFi Access point of the WiBCI amplifier.
2. Start the application. If the connection cannot be established, the app will display a warning and quit.
3. There are 4 main UI pages _**Graph**_, _**Impedance**_, _**CNV Demo**_, and _**Eyes Open/Close Demo**_. The page can be selected via the menu bar. Their purpose is:
   
  * Graph: Display data from the selected montage.
  * Impedance: Measures the connection health of selected montage.
  * CNV Demo: Starts CNV demonstration.
  * Eyes Open/Close Demo: Starts Eyes Open/Close demonstration.
4. Use Settings for montage selection or creation, data path for file logging, soft trigger, and LSL configuration.

![settings](https://github.com/KAMRANRASOOL777/WiBCI16T_Application/assets/48867631/0fffeffc-9117-479d-804e-5b8af189ac74)

5. Select the Graph page. Select **Live data** from the selection bar. Press **START**. Data will start getting updated on graphs. Press **RECORD**. A pop-up window will appear to get the file name.

![graph](https://github.com/KAMRANRASOOL777/WiBCI16T_Application/assets/48867631/7f073558-65a4-433c-9599-56ad4ba1eb86)

6. Press **STOP** and select the Impedance page from the menu.
7. Press **START** and selected montage channels will start displaying their impedance (also color-coded).
   
 ![impedance](https://github.com/KAMRANRASOOL777/WiBCI16T_Application/assets/48867631/076e9f1b-60cd-43e2-842a-cdfb2d18c815)

8. Similarly interactive demonstrations of **CNV** and **Eyes Open Close** can be selected and run.
![cnv](https://github.com/KAMRANRASOOL777/WiBCI16T_Application/assets/48867631/94fcd3a5-5200-4a1e-8880-03cf855c0f44)

![eyes](https://github.com/KAMRANRASOOL777/WiBCI16T_Application/assets/48867631/98ff9f5f-4d6b-41ca-b526-9b50eac49720)


9. Demo data can be selected and run. This will generate pre-loaded data instead of amplifier data.

## Software Architecture
This software is developed using [Delacor](https://labviewwiki.org/wiki/Delacor_Queued_Message_Handler_(DQMH)) DQMH framework. 
There are 6 DQMH modules as
1. CML UI: Main display and user interaction module.
2. Settings Editor: Module responsible for storing and retrieval of settings information.
3. Acquisition: Module responsible for acquiring data from Amplifiers.
4. Logging: Module responsible for data logging in CSV format.
5. Demo Data Generation: This module generates pre-stored data for display purposes.
6. LSL: Module responsible for data broadcast using [Lab Streamin Layer](https://github.com/sccn/labstreaminglayer).

