cmake_minimum_required(VERSION 3.27)

project(QtNativeWindowSwift LANGUAGES OBJC OBJCXX Swift C CXX VERSION 1.0.0)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_OSX_ARCHITECTURES "arm64;x86_64")

set(CMAKE_INCLUDE_CURRENT_DIR ON)
include_directories (${CMAKE_BINARY_DIR})

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules")
include(AddSwift)

find_package(Qt6 COMPONENTS Core Qml Quick Gui Widgets REQUIRED)

qt_standard_project_setup(REQUIRES 6.5)


set(BIN "QtNativeWindowSwift")

add_subdirectory(SwiftModule)

set(SOURCES  
    main.cpp
    CppModule/checkeredwindow.h
    CppModule/checkeredwindow.cpp
    CppModule/qwindowTest.h
    CppModule/qwindowTest.cpp)

qt6_add_executable(${BIN}
    MANUAL_FINALIZATION
    ${SOURCES})

add_dependencies(${BIN} SwiftModule)
     
target_link_libraries(${BIN} PRIVATE 
    Qt6::Core 
    Qt6::Gui 
    Qt6::Qml 
    Qt6::Quick 
    Qt6::Widgets
    SwiftModule)
