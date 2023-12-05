set(cpu cortex-m4)
set(fpu fpv4-sp-d16)
set(float-abi hard)

message(STATUS "CMAKE_C_COMPILER_ID: ${CMAKE_C_COMPILER_ID}")

add_compile_options(
  -mcpu=${cpu}
  $<$<COMPILE_LANG_AND_ID:C,GNU>:-mfpu=${fpu}>
  -mfloat-abi=${float-abi}
  $<$<COMPILE_LANGUAGE:ASM>:"-masm=auto">
  -mthumb
)

add_link_options(
  $<$<COMPILE_LANG_AND_ID:C,ARMClang>:"--cpu=${cpu}">
  $<$<COMPILE_LANG_AND_ID:C,GNU>:"-mcpu=${cpu} -mfpu=${fpu} -mfloat-abi=${float-abi}">
)

# set(CMAKE_ASM_FLAGS "-mcpu=${cpu} -mfpu=${fpu} -mfloat-abi=${float-abi}")
# set(CMAKE_C_FLAGS "-mcpu=${cpu} -mfpu=${fpu} -mfloat-abi=${float-abi}")
# set(CMAKE_EXE_LINKER_FLAGS "-mcpu=${cpu} -mfpu=${fpu} -mfloat-abi=${float-abi}")
