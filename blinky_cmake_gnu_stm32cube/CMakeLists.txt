cmake_minimum_required(VERSION 3.23)

project(blinky_cmake_gnu_stm32cube
  LANGUAGES C ASM)

# include(toolchain/stm32f4_disco.cmake)

set(target_name blinky_cmake_gnu_stm32cube)

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
  # source/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_hcd.c
)

target_include_directories(${target_name} PRIVATE
  source/core/Inc
  source/Drivers/STM32F4xx_HAL_Driver/Inc
  source/Drivers/STM32F4xx_HAL_Driver/Inc/Legacy
  source/Drivers/CMSIS/Device/ST/STM32F4xx/Include
  source/Drivers/CMSIS/Include
)

target_compile_definitions(${target_name} PRIVATE USE_HAL_DRIVER STM32F401xC)

# ASM
# -mcpu=cortex-m4 -g3 -DDEBUG -c -x assembler-with-cpp --specs=nano.specs -mfpu=fpv4-sp-d16
# -mfloat-abi=hard -mthumb
set(CMAKE_ASM_FLAGS "-mcpu=cortex-m4 -g3 -DDEBUG -x assembler-with-cpp --specs=nano.specs \
-mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb")

# GCC
# -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32F401xC -c
# -I../Core/Inc -I../USB_HOST/App
# -I../USB_HOST/Target
# -I../Drivers/STM32F4xx_HAL_Driver/Inc
# -I../Drivers/STM32F4xx_HAL_Driver/Inc/Legacy
# -I../Middlewares/ST/STM32_USB_Host_Library/Core/Inc
# -I../Middlewares/ST/STM32_USB_Host_Library/Class/CDC/Inc
# -I../Drivers/CMSIS/Device/ST/STM32F4xx/Include
# -I../Drivers/CMSIS/Include
# -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity
# --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb
set(CMAKE_C_FLAGS "-mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG \
  -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity \
  -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb") #--specs=nano.specs

# Linker
# -mcpu=cortex-m4 -T"D:\perso\workspace\STM32CubeIDE\stm32f401c_disco\STM32F401VCTX_FLASH.ld"
# --specs=nosys.specs -Wl,-Map="${BuildArtifactFileBaseName}.map" -Wl,--gc-sections -static
# --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -Wl,--start-group -lc -lm -Wl,--end-group

set(CMAKE_EXE_LINKER_FLAGS "-mcpu=cortex-m4 -T ${CMAKE_SOURCE_DIR}/source/STM32F401VCTX_FLASH.ld \
  --specs=nosys.specs -Wl,-Map=${target_name}.map -Wl,--gc-sections -static \
  --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -Wl,--start-group -lc -lm -Wl,--end-group")
