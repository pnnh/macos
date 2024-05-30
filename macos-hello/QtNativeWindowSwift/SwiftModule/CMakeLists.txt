
_swift_generate_cxx_header_target(
  SwiftModule_Header
  SwiftModule
  "${CMAKE_CURRENT_BINARY_DIR}/WindowDelegate-swift.h"
  SOURCES 
    ${CMAKE_CURRENT_SOURCE_DIR}/WindowDelegate.swift
    ${CMAKE_CURRENT_SOURCE_DIR}/ViewController.swift
  SEARCH_PATHS "${CMAKE_CURRENT_SOURCE_DIR}/include")

add_library(SwiftModule STATIC
    WindowDelegate.swift
    ViewController.swift)

add_dependencies(SwiftModule SwiftModule_Header)
set_target_properties(SwiftModule PROPERTIES Swift_MODULE_NAME "SwiftModule")
target_include_directories(SwiftModule PUBLIC "${CMAKE_CURRENT_BINARY_DIR}/include")
target_compile_options(SwiftModule PUBLIC "$<$<COMPILE_LANGUAGE:Swift>:-cxx-interoperability-mode=default>")

target_link_libraries(SwiftModule PUBLIC "-framework Foundation -framework AppKit")