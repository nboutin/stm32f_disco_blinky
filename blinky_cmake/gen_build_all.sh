#!/bin/bash

# On error, exit immediately
set -e

# while getopts 'gb' flag; do
#   case "${flag}" in
#     g)
#       gen()
#       ;;
#     b)
#       build()
#       ;;
#   esac
# done

main() {
  gen
  build
}

gen() {
  source env_arm_gnu.sh
  cmake -S . -B build/GNU/MinSizeRel -G Ninja --toolchain toolchain/arm_gcc_toolchain.cmake -DCMAKE_BUILD_TYPE=MinSizeRel

  source env_armclang.sh
  cmake -S . -B build/ARMClang/MinSizeRel -G "MinGW Makefiles" --toolchain toolchain/armclang_toolchain.cmake -DCMAKE_BUILD_TYPE=MinSizeRel
}

build() {
  source env_arm_gnu.sh
  cmake --build build/GNU/MinSizeRel

  source env_armclang.sh
  cmake --build build/ARMClang/MinSizeRel
}

main
