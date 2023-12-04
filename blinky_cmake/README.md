# STM32F4_disco board - Blinky with CMake

## Credit

https://github.com/vpetrigo/arm-cmake-toolchains

## Setup

1. Download https://developer.arm.com/Tools%20and%20Software/GNU%20Toolchain > AArch32 bare-metal target (arm-none-eabi)
2. Download https://github.com/ninja-build/ninja/releases

## Build

Generate:

    source build_env.sh
    cmake -S . -B build/MinSizeRel -G Ninja --toolchain toolchain/arm_gcc_toolchain.cmake -DCMAKE_BUILD_TYPE=MinSizeRel

Build:

    cmake --build build/MinSizeRel
    cmake --install build --prefix ~/.local
