cmake_minimum_required(VERSION 3.27)

project(hello LANGUAGES OBJC OBJCXX Swift C CXX VERSION 1.0.0)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_OSX_ARCHITECTURES "arm64;x86_64")

set(CMAKE_INCLUDE_CURRENT_DIR ON)

find_package(Qt6 COMPONENTS Core Qml Quick Gui Widgets REQUIRED)

qt_standard_project_setup(REQUIRES 6.5)

set(SOURCES
    # main.swift 
    # AppDelegate.swift 
    # ViewController.swift
    checkeredwindow.h
    checkeredwindow.cpp
    macwindow.h
    macwindow.mm
    main.cpp)

set(BIN "QtNativeWindow")

qt6_add_executable(${BIN}
    MANUAL_FINALIZATION
    ${SOURCES})

# 该句需要注释，否则会报panic错误
# target_compile_options(${BIN} PRIVATE -fobjc-arc)

target_link_libraries(${BIN} PRIVATE 
    Qt6::Core 
    Qt6::Gui 
    Qt6::Qml 
    Qt6::Quick 
    Qt6::Widgets 
    "-framework AppKit")
