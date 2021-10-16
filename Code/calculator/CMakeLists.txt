cmake_minimum_required(VERSION 3.16)
cmake_policy(SET CMP0003 NEW)

project(Assembly
    LANGUAGES ASM C
)

set(PROJECT_VER "0.0.1")
set(CMAKE_OSX_ARCHITECTURES "arm64")

set(OG_FLAGS "${CMAKE_ASM_FLAGS}")
SET(CMAKE_ASM_FLAGS  "${CMAKE_CASM_FLAGS} -g -e _enter")


add_executable(ASMCalc
    src/io.s src/main.s src/strlen.s src/parser.s src/string_builder.s
)
target_include_directories(ASMCalc PUBLIC src/macros)

add_executable(Tester 
    Tests/test.c
)
#set_target_properties(Tester
#    PROPERTIES
#        LINKER_LANGUAGE CXX
#        LANGUAGE CXX
#)

add_library(ASMCalcLib STATIC
    src/io.s src/main.s src/strlen.s src/parser.s src/string_builder.s
)
target_include_directories(ASMCalcLib PUBLIC src/macros)

target_link_libraries(Tester ASMCalcLib)