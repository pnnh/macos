cmake_minimum_required(VERSION 3.27)

project(QtQuickNativeWindow LANGUAGES OBJC OBJCXX Swift C CXX VERSION 1.0.0)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_OSX_ARCHITECTURES "arm64;x86_64")

set(CMAKE_INCLUDE_CURRENT_DIR ON)

find_package(Qt6 COMPONENTS Core Qml Quick Gui Widgets REQUIRED)

qt_standard_project_setup(REQUIRES 6.5)

set(SOURCES
    checkeredwindow.h
    checkeredwindow.cpp
    macwindow.h
    macwindow.mm
    main.cpp)

set(BIN "QtQuickNativeWindow")

qt6_add_executable(${BIN}
    MANUAL_FINALIZATION
    ${SOURCES})

qt6_add_qml_module(${BIN}
    URI quick
    VERSION 1.0
    QML_FILES
    views/main.qml)

target_link_libraries(${BIN} PRIVATE 
    Qt6::Core 
    Qt6::Gui 
    Qt6::Qml 
    Qt6::Quick 
    Qt6::Widgets 
    "-framework AppKit")
