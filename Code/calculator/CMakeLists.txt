cmake_minimum_required(VERSION 3.16)
cmake_policy(SET CMP0003 NEW)


set(PROJECT_VER "0.0.1")
set(CMAKE_OSX_ARCHITECTURES "arm64")

project(ASMCalc  VERSION "${PROJECT_VER}"
    LANGUAGES ASM
)

add_executable(ASMCalc
    src/io.s src/main.s src/strlen.s
)

target_include_directories(ASMCalc PRIVATE src)