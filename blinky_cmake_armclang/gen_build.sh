#!/bin/bash

# On error, exit immediately
set -e

source env_armclang.sh

cmake -S . -B build/ARMClang/MinSizeRel -G "MinGW Makefiles" --toolchain toolchain/armclang_toolchain.cmake -DCMAKE_BUILD_TYPE=MinSizeRel --fresh

cmake --build build/ARMClang/MinSizeRel

