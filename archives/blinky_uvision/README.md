# STM32F4_disco board - Blinky with Keil uVision

## Credits

https://microcontrollerslab.com/led-blinking-tutorial-stm32f4-discovery-board-gpio-hal-library/

## Setup

1. Open Keil uVision
2. Open Pack Installer (use icon)
3. Select Devices > STMicroelectronics > STM32F4 Series
4. In Packs tabulation, Install Device Specific Keil::STM32F4xx_DFP and Keil::STM32NUCLEO_BSP

## Project

Real chip on board: stm32f411vetx

1. Keil uVision > Project > Create New Project > blinky_uvision
2. Select Device for Target > STMMicroelectronics > STM32F4 Series > STM32F411 > STM32F411VE > STM32F411VETx > OK
3. Manage Run-Time Environment
   1. CMSIS > CORE
   2. Device > startup
   3. Device > STM32Cube Framework (API) > Classic
   4. Device > STM32Cube HAL > GPIO
   5. Click Resolve > OK
4. Right-Click Target 1/Source Group 1 > Add new item to group > C++ File > main.cpp > Add
5. Add code to main.cpp
6. Option for Target
   1. Output
      1. Create Batch File
   2. C/C++
      1. Language C = c11
      2. Language C++ = C++14
      3. Optimization = -0s balanced
      4. Link-Time Optimization
   3. Debug
      1. Use: ST-Link Debugger
   4. OK
7. Build
8. Find Objects/linky_uvision.axf

