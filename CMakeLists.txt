cmake_minimum_required(VERSION 4.0)
project(game_launcher LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.11 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.11)

qt_add_executable(${PROJECT_NAME}
  src/main.cpp
)

qt_add_qml_module(${PROJECT_NAME}
  URI GameLauncher
  VERSION 1.0
  QML_FILES
    qml/Main.qml
)

target_link_libraries(${PROJECT_NAME}
  PRIVATE
    Qt6::Quick
)
