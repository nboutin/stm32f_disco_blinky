cmake_minimum_required(VERSION 3.23)

project(
  blinky_cmake
  LANGUAGES C CXX
  VERSION 0.1.0)

include(toolchain/stm32f4_disco.cmake)

# --- target

set(target_name blinky_cmake)

add_executable(${target_name} source/main.cpp)
set_target_properties(${target_name} PROPERTIES SUFFIX ".axf")

target_compile_features(${target_name} PRIVATE cxx_std_14)
target_compile_options(${target_name} PRIVATE -Wall -Wextra -Wpedantic -Werror)
target_compile_options(${target_name} PRIVATE -fno-rtti -flto -funsigned-char -fshort-enums -fshort-wchar -fno-exceptions -ffunction-sections)

target_link_options(${target_name} PRIVATE -flto)

# --- install

include(GNUInstallDirs)
install(TARGETS ${target_name} EXPORT ${target_name})
