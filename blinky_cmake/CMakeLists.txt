cmake_minimum_required(VERSION 3.23)

project(
  blinky_cmake
  LANGUAGES C CXX
  VERSION 0.1.0)

include(toolchain/stm32f4_disco.cmake)

# --- target

set(target_name blinky_cmake)

add_executable(${target_name}
  source/main.cpp
  source/RTE/Device/STM32F411VETx/startup_stm32f411xe.s
  source/RTE/Device/STM32F411VETx/system_stm32f4xx.c
  source/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal.c
  source/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_gpio.c
  source/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_cortex.c
  source/_reset_hardware.c
  source/newlib/source/_exit.c
  source/newlib/source/_syscalls.c
  source/newlib/source/_sbrk.c
)

target_include_directories(${target_name} PRIVATE
  source/RTE/_Target_1
  source/RTE/Device/STM32F411VETx
  source/STM32F4xx/include
  source/ARM/CMSIS/Core/Include
  source/STM32F4xx_HAL_Driver/Inc
)

set_target_properties(${target_name} PROPERTIES SUFFIX ".axf")

target_compile_options(${target_name} PRIVATE -DSTM32F411xE -D_RTE_)
target_compile_features(${target_name} PRIVATE c_std_11 cxx_std_14)
target_compile_options(${target_name} PRIVATE -Wall -Wextra -Wpedantic -Werror)

# -flto
target_compile_options(${target_name} PRIVATE -funsigned-char -fshort-enums -fshort-wchar -fno-exceptions
  -ffunction-sections -fdata-sections)
# target_compile_options(${target_name} PRIVATE -nostdlib)
target_compile_options(${target_name} PRIVATE $<$<COMPILE_LANGUAGE:CXX>:-fno-rtti>)

# target_link_options(${target_name} PRIVATE -flto)

target_link_options(${PROJECT_NAME} PRIVATE
  # $<$<COMPILE_LANG_AND_ID:C,GNU>:"SHELL:-T ${CMAKE_SOURCE_DIR}/source/ldscripts/mem.ld">
  # $<$<COMPILE_LANG_AND_ID:C,GNU>:"SHELL:-T ${CMAKE_SOURCE_DIR}/source/ldscripts/sections.ld">
  "SHELL:-T ${CMAKE_SOURCE_DIR}/source/ldscripts/mem.ld"
  "SHELL:-T ${CMAKE_SOURCE_DIR}/source/ldscripts/sections.ld"
)

# target_link_libraries(${target_name} PRIVATE ${CMAKE_SOURCE_DIR}/source/c_w.l)

# --- install

include(GNUInstallDirs)
install(TARGETS ${target_name} EXPORT ${target_name})
