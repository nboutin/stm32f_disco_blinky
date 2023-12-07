
add_custom_command(TARGET ${target_name} POST_BUILD
  COMMENT "Compute binary size"
  WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
  COMMAND ${CMAKE_SIZE_UTIL} "${target_name}.elf"
)
