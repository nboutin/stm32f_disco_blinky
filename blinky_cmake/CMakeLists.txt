cmake_minimum_required(VERSION 3.23)

project(blinky_cmake
  LANGUAGES C ASM)

include(toolchain/stm32f4_disco.cmake)

set(target_name blinky_cmake)

add_executable(${target_name}
  source/Core/Src/main.c
  source/Core/Src/gpio.c
  source/Core/Src/error_handler.c
  source/Core/Src/stm32f4xx_it.c
  source/Core/Src/stm32f4xx_hal_msp.c
  source/Core/Src/syscalls.c
  source/Core/Src/sysmem.c
  source/Core/Src/system_stm32f4xx.c
  source/Core/Startup/startup_stm32f401vctx.s
  source/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal.c
  source/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_cortex.c
  source/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_gpio.c
  source/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_rcc.c
  source/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_rcc_ex.c
)

target_include_directories(${target_name} PRIVATE
  source/core/Inc
  source/Drivers/STM32F4xx_HAL_Driver/Inc
  source/Drivers/STM32F4xx_HAL_Driver/Inc/Legacy
  source/Drivers/CMSIS/Device/ST/STM32F4xx/Include
  source/Drivers/CMSIS/Include
)

target_compile_definitions(${target_name} PRIVATE USE_HAL_DRIVER STM32F401xC)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=gnu11 -ffunction-sections -fdata-sections -Wall \
-fstack-usage -fcyclomatic-complexity")

set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -T ${CMAKE_SOURCE_DIR}/source/STM32F401VCTX_FLASH.ld \
  -Wl,-Map=${target_name}.map -Wl,--gc-sections -static -Wl,--start-group -lc -lm -Wl,--end-group")
