
set(target_name blinky_cmake)

add_executable(${target_name}
  application/source/main.cpp
  application/source/gpio.c
  application/source/error_handler.c
  system/source/stm32f4xx_it.c
  system/source/stm32f4xx_hal_msp.c
  system/source/syscalls.c
  system/source/sysmem.c
  # ---
  lib/CMSIS/Device/ST/STM32F4xx/Source/Templates/gcc/startup_stm32f411xe.s
  lib/CMSIS/Device/ST/STM32F4xx/Source/Templates/system_stm32f4xx.c
  lib/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal.c
  lib/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_cortex.c
  lib/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_gpio.c
  lib/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_rcc.c
  lib/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_rcc_ex.c
)

target_include_directories(${target_name} PRIVATE
  application/include
  system/include
  lib/CMSIS/Core/Include
  lib/CMSIS/Device/ST/STM32F4xx/Include
  lib/STM32F4xx_HAL_Driver/Inc
  lib/STM32F4xx_HAL_Driver/Inc/Legacy
)

target_compile_definitions(${target_name} PRIVATE USE_HAL_DRIVER STM32F411xE)

target_compile_features(${target_name} PRIVATE c_std_11 cxx_std_14)

# Optimization flags: place function and data in their own sections
string(APPEND CMAKE_C_FLAGS " -ffunction-sections -fdata-sections -flto")
string(APPEND CMAKE_CXX_FLAGS " -ffunction-sections -fdata-sections -flto")

string(APPEND CMAKE_CXX_FLAGS " -fno-exceptions -fno-rtti")

# Set linker script
string(APPEND CMAKE_EXE_LINKER_FLAGS " -T ${CMAKE_CURRENT_SOURCE_DIR}/linker/STM32F401VCTX_FLASH.ld -static -flto")

# Discard unused sections
string(APPEND CMAKE_EXE_LINKER_FLAGS " -Wl,--gc-sections")

# Use C math library
string(APPEND CMAKE_EXE_LINKER_FLAGS " -Wl,--start-group -lc -lm -Wl,--end-group")

include(../cmake/binary_size.cmake)

# --- install

include(GNUInstallDirs)
install(TARGETS ${target_name} EXPORT ${target_name})
