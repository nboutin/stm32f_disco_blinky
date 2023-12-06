#!/bin/bash

# On error, exit immediately
set -e

source env_arm_gnu.sh

cmake -S . -B build/GNU/MinSizeRel -G Ninja --toolchain toolchain/arm_gcc_toolchain.cmake -DCMAKE_BUILD_TYPE=MinSizeRel --fresh

cmake --build build/GNU/MinSizeRel

