set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR ARM)

set(TOOLCHAIN_PREFIX arm-none-eabi-)
find_program(BINUTILS_FILEPATH ${TOOLCHAIN_PREFIX}gcc NO_CACHE)

if (NOT BINUTILS_FILEPATH)
    message(FATAL_ERROR "Toolchain not found")
endif ()

get_filename_component(TOOLCHAIN_PATH ${BINUTILS_FILEPATH} DIRECTORY)

# Without that flag CMake is not able to pass test compilation check
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

set(CMAKE_ASM_COMPILER ${TOOLCHAIN_PREFIX}gcc)
set(CMAKE_C_COMPILER ${TOOLCHAIN_PREFIX}gcc)
set(CMAKE_CXX_COMPILER ${TOOLCHAIN_PREFIX}g++)
# set(CMAKE_LINKER ${TOOLCHAIN_PREFIX}ld)
set(CMAKE_AR ${TOOLCHAIN_PREFIX}gcc-ar)
set(CMAKE_RANLIB ${TOOLCHAIN_PREFIX}gcc-ranlib)
set(CMAKE_OBJCOPY ${TOOLCHAIN_PATH}/${TOOLCHAIN_PREFIX}objcopy CACHE INTERNAL "objcopy tool")
set(CMAKE_SIZE_UTIL ${TOOLCHAIN_PATH}/${TOOLCHAIN_PREFIX}size CACHE INTERNAL "size tool")

execute_process(COMMAND ${CMAKE_C_COMPILER} -print-sysroot
    OUTPUT_VARIABLE TOOLCHAIN_SYSROOT OUTPUT_STRIP_TRAILING_WHITESPACE)
get_filename_component(TOOLCHAIN_SYSROOT ${TOOLCHAIN_SYSROOT} REALPATH)

# Default C compiler flags
set(CMAKE_C_FLAGS_DEBUG_INIT "-g3 -Og -Wall -pedantic -DDEBUG")
set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG_INIT}" CACHE STRING "" FORCE)
set(CMAKE_C_FLAGS_RELEASE_INIT "-O3 -Wall")
set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE_INIT}" CACHE STRING "" FORCE)
set(CMAKE_C_FLAGS_MINSIZEREL_INIT "-Os -Wall")
set(CMAKE_C_FLAGS_MINSIZEREL "${CMAKE_C_FLAGS_MINSIZEREL_INIT}" CACHE STRING "" FORCE)
set(CMAKE_C_FLAGS_RELWITHDEBINFO_INIT "-O2 -g -Wall")
set(CMAKE_C_FLAGS_RELWITHDEBINFO "${CMAKE_C_FLAGS_RELWITHDEBINFO_INIT}" CACHE STRING "" FORCE)
# Default C++ compiler flags
set(CMAKE_CXX_FLAGS_DEBUG_INIT "-g3 -Og -Wall -pedantic -DDEBUG")
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG_INIT}" CACHE STRING "" FORCE)
set(CMAKE_CXX_FLAGS_RELEASE_INIT "-O3 -Wall")
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE_INIT}" CACHE STRING "" FORCE)
set(CMAKE_CXX_FLAGS_MINSIZEREL_INIT "-Os -Wall")
set(CMAKE_CXX_FLAGS_MINSIZEREL "${CMAKE_CXX_FLAGS_MINSIZEREL_INIT}" CACHE STRING "" FORCE)
set(CMAKE_CXX_FLAGS_RELWITHDEBINFO_INIT "-O2 -g -Wall")
set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "${CMAKE_CXX_FLAGS_RELWITHDEBINFO_INIT}" CACHE STRING "" FORCE)

set(CMAKE_SYSROOT ${TOOLCHAIN_SYSROOT})
set(CMAKE_FIND_ROOT_PATH ${TOOLCHAIN_PATH})
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

# message(STATUS "TOOLCHAIN_PATH: ${TOOLCHAIN_PATH}")
# message(STATUS "CMAKE_SYSROOT: ${CMAKE_SYSROOT}")
