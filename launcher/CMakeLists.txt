cmake_minimum_required(VERSION 3.16)
project(GameLauncher LANGUAGES CXX)

set(APP_NAME "WSU-Game-Launcher")

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

set(QT_VERSION "6.7.2")
set(QT_INSTALL_DIR "${CMAKE_SOURCE_DIR}/third_party/Qt")

if(WIN32)
    set(AQT_PLATFORM "windows")
    set(AQT_ARCH "win64_msvc2019_64")
    set(QT_ARCH_DIR "msvc2019_64")
elseif(APPLE)
    set(AQT_PLATFORM "mac")
    set(AQT_ARCH "clang_64")
    set(QT_ARCH_DIR "macos")
elseif(UNIX)
    set(AQT_PLATFORM "linux")
    set(AQT_ARCH "linux_gcc_64")
    set(QT_ARCH_DIR "gcc_64")
else()
    message(FATAL_ERROR "Unsupported platform for Qt auto-download")
endif()

set(QT_PREFIX "${QT_INSTALL_DIR}/${QT_VERSION}/${QT_ARCH_DIR}")

if(NOT EXISTS "${QT_PREFIX}")
    message(STATUS "Qt ${QT_VERSION} not found, installing via aqtinstall...")
    find_program(PYTHON_EXE python3)
    if(NOT PYTHON_EXE)
        find_program(PYTHON_EXE python)
    endif()
    if(NOT PYTHON_EXE)
        message(FATAL_ERROR "python3/python not found; needed to run aqtinstall")
    endif()

    execute_process(
        COMMAND ${PYTHON_EXE} -m aqt install-qt ${AQT_PLATFORM} desktop ${QT_VERSION} ${AQT_ARCH}
                --outputdir ${QT_INSTALL_DIR}
        RESULT_VARIABLE AQT_RESULT
    )
    if(NOT AQT_RESULT EQUAL 0)
        message(FATAL_ERROR "aqtinstall failed. Ensure 'pip install aqtinstall' has been run.")
    endif()
endif()

list(PREPEND CMAKE_PREFIX_PATH "${QT_PREFIX}")

find_package(Qt6 REQUIRED COMPONENTS Widgets)

add_executable(${APP_NAME} main.cpp)
target_link_libraries(${APP_NAME} PRIVATE Qt6::Widgets)

if(WIN32)
    find_program(WINDEPLOYQT_EXE windeployqt HINTS "${QT_PREFIX}/bin")
    if(WINDEPLOYQT_EXE)
        add_custom_command(TARGET ${APP_NAME} POST_BUILD
            COMMAND ${WINDEPLOYQT_EXE} $<TARGET_FILE:${APP_NAME}>
        )
    endif()
elseif(APPLE)
    find_program(MACDEPLOYQT_EXE macdeployqt HINTS "${QT_PREFIX}/bin")
    if(MACDEPLOYQT_EXE)
        add_custom_command(TARGET ${APP_NAME} POST_BUILD
            COMMAND ${MACDEPLOYQT_EXE} $<TARGET_BUNDLE_DIR:${APP_NAME}>
        )
    endif()
endif()