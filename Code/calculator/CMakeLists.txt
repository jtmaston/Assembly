cmake_minimum_required(VERSION 3.16)
cmake_policy(SET CMP0003 NEW)


set(PROJECT_VER "0.0.1")
set(CMAKE_OSX_ARCHITECTURES "arm64")

project(ASMCalc  VERSION "${PROJECT_VER}"
    LANGUAGES ASM CXX
)

SET(CMAKE_ASM_FLAGS  "${CMAKE_CASM_FLAGS} -g")


add_executable(ASMCalc
    src/io.s src/main.s src/strlen.s src/parser.s
)

#set_target_properties(ASMCalc
#    PROPERTIES
#        LINKER_LANGUAGE ASM
#        LANGUAGE ASM
#)
target_include_directories(ASMCalc PUBLIC src)
#
#
#add_executable(Tester
#    src/tests/tester.cpp
#)
#
#set_target_properties(Tester
#    PROPERTIES
#        LINKER_LANGUAGE CXX
#        LANGUAGE CXX
#)
#
#add_library(ASMCalcLib STATIC
#    src/io.s src/main.s src/strlen.s src/parser.s
#)
#target_include_directories(ASMCalcLib PUBLIC src)

#target_link_libraries(Tester PUBLIC ASMCalcLib)