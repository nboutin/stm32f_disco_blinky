set(cpu cortex-m4)
set(fpu fpv4-sp-d16)
set(float-abi hard)

add_compile_options(-mcpu=${cpu} -mfpu=${fpu} -mfloat-abi=${float-abi} -mthumb)
add_compile_options($<$<COMPILE_LANGUAGE:ASM>:-masm=auto>)

add_link_options(-mcpu=${cpu} -mfpu=${fpu} -mfloat-abi=${float-abi})

# set(CMAKE_ASM_FLAGS "-mcpu=${cpu} -mfpu=${fpu} -mfloat-abi=${float-abi}")
# set(CMAKE_C_FLAGS "-mcpu=${cpu} -mfpu=${fpu} -mfloat-abi=${float-abi}")
# set(CMAKE_EXE_LINKER_FLAGS "-mcpu=${cpu} -mfpu=${fpu} -mfloat-abi=${float-abi}")
