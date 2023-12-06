cmake_minimum_required(VERSION 3.23)

project(
  blinky_cmake_gnu_c
  LANGUAGES C ASM
  VERSION 0.1.0)

set(CMAKE_EXPORT_COMPILE_COMMANDS true)
include(toolchain/stm32f4_disco.cmake)

# --- target

set(target_name blinky_cmake_gnu_c)

add_executable(${target_name}
  source/main.c
  source/RTE/Device/STM32F411VETx/startup_stm32f411xe.s
  source/RTE/Device/STM32F411VETx/system_stm32f4xx.c
  source/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal.c
  source/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_gpio.c
  source/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_cortex.c
  # source/_reset_hardware.c
  # source/newlib/source/_exit.c
  # source/newlib/source/_syscalls.c
  # source/newlib/source/_sbrk.c
)

target_include_directories(${target_name} PRIVATE
  source/RTE/_Target_1
  source/RTE/Device/STM32F411VETx
  source/STM32F4xx/include
  source/ARM/CMSIS/Core/Include
  source/STM32F4xx_HAL_Driver/Inc
)

set_target_properties(${target_name} PROPERTIES SUFFIX ".axf")

target_compile_features(${target_name} PRIVATE c_std_11 cxx_std_14)

target_compile_definitions(${target_name} PRIVATE STM32F411xE _RTE_)

# set(CMAKE_ASM_FLAGS "-mcpu=${cpu} -mfpu=${fpu} -mfloat-abi=${float-abi} -x assembler-with-cpp")
# set(CMAKE_C_FLAGS "-mcpu=${cpu} -mfpu=${fpu} -mfloat-abi=${float-abi}")
# set(CMAKE_CXX_FLAGS "-mcpu=${cpu} -mfpu=${fpu} -mfloat-abi=${float-abi}")
# set(CMAKE_EXE_LINKER_FLAGS "-mcpu=${cpu} -mfpu=${fpu} -mfloat-abi=${float-abi}")

# target_compile_options(${target_name} PRIVATE -Wall -Wextra -Wpedantic -Werror)
# target_compile_options(${target_name} PRIVATE -funsigned-char -fshort-enums -fshort-wchar -fno-exceptions)
# target_compile_options(${target_name} PRIVATE -flto -ffunction-sections -fdata-sections --specs=nano.specs)
# target_compile_options(${target_name} PRIVATE $<$<COMPILE_LANGUAGE:CXX>:-fno-rtti>)
# target_compile_options(${target_name} PRIVATE $<$<COMPILE_LANGUAGE:ASM>:-x assembler-with-cpp>)

# These prevent absolute paths from appearing in build artifacts.
# Absolute paths are build-host specific and can result in different
# binaries or inability to use or examine artifacts between hosts.
# add_compile_options(
# 	"-fdebug-prefix-map=${CMAKE_SOURCE_DIR}=."
# 	"-ffile-prefix-map=${CMAKE_SOURCE_DIR}=."
# )

target_link_options(${target_name} PRIVATE -flto)
target_link_options(${target_name} PRIVATE --specs=nosys.specs -Wl,--gc-sections -static -Wl,--start-group -lc -lm -Wl,--end-group)

target_link_options(${PROJECT_NAME} PRIVATE
  "SHELL:-T ${CMAKE_SOURCE_DIR}/source/ldscripts/mem.ld"
  "SHELL:-T ${CMAKE_SOURCE_DIR}/source/ldscripts/sections.ld"
  -Wl,-Map=blinky_cmake.map
)

# --- install

include(GNUInstallDirs)
install(TARGETS ${target_name} EXPORT ${target_name})
