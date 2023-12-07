set(cpu cortex-m4)

add_compile_options(--target=arm-arm-none-eabi -mcpu=${cpu} -mthumb)
add_compile_options($<$<COMPILE_LANGUAGE:ASM>:-masm=auto>)

add_link_options(--cpu=${cpu})

