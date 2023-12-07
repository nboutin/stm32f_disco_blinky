
# Generate map file
string(APPEND CMAKE_EXE_LINKER_FLAGS " -Wl,-Map=${target_name}.map -Wl,--print-memory-usage")
