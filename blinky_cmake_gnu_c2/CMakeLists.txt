cmake_minimum_required(VERSION 3.23)

project(blinky_cmake_gnu_c
LANGUAGES C ASM)

include(toolchain/stm32f4_disco.cmake)

set(target_name blinky_cmake_gnu_c)

add_executable(${target_name}
  source/main.c
  source/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal.c
  source/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_gpio.c
  source/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_cortex.c
  source/system_stm32f4xx.c
  source/startup_stm32f411xe.S
)

target_include_directories(${target_name} PRIVATE
  source/include
  source/STM32F4xx_HAL_Driver/Inc
  source/STM32F4xx/include
  source/CMSIS/Core/Include
)

target_compile_definitions(${target_name} PRIVATE STM32F411xE _RTE_)
