set(cpu cortex-m4)
set(fpu fpv4-sp-d16)
set(float-abi hard)

message(STATUS "CMAKE_C_COMPILER_ID: ${CMAKE_C_COMPILER_ID}")

# add_compile_options(
#   # $<$<COMPILE_LANGUAGE:ASM>:-masm=auto>
#   -mcpu=${cpu} -mthumb
#   -mfpu=${fpu} -mfloat-abi=${float-abi}
# )

# add_link_options(
#   $<$<COMPILE_LANG_AND_ID:C,ARMClang>:"--cpu=${cpu}">
#   $<$<COMPILE_LANG_AND_ID:C,GNU>:"-mcpu=${cpu} -mfpu=${fpu} -mfloat-abi=${float-abi}">
# )

set(CMAKE_ASM_FLAGS "-mcpu=${cpu} -mfpu=${fpu} -mfloat-abi=${float-abi} -x assembler-with-cpp")
set(CMAKE_C_FLAGS "-mcpu=${cpu} -mfpu=${fpu} -mfloat-abi=${float-abi}")
set(CMAKE_CXX_FLAGS "-mcpu=${cpu} -mfpu=${fpu} -mfloat-abi=${float-abi}")
set(CMAKE_EXE_LINKER_FLAGS "-mcpu=${cpu} -mfpu=${fpu} -mfloat-abi=${float-abi}")
