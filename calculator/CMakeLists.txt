cmake_minimum_required(VERSION 3.16)
cmake_policy(SET CMP0003 NEW)

project(Assembly
    LANGUAGES ASM C
)

set(PROJECT_VER "0.0.1")
set(CMAKE_OSX_ARCHITECTURES "arm64")


add_executable(ASMCalc
    src/main.s src/io.s src/strlen.s src/parser.s src/string_builder_neo.s src/preprocessor.s
)

if(UNIX AND NOT APPLE)
    set_target_properties(ASMCalc PROPERTIES LINK_FLAGS "-e _enter -nostdlib")
endif()

if(APPLE)
    set_target_properties(ASMCalc PROPERTIES LINK_FLAGS "-e _enter")
endif()

set_target_properties(ASMCalc PROPERTIES ASM_FLAGS "-g")

add_executable(Tester 
    Tests/test.c
)
set_target_properties(Tester
    PROPERTIES
        LANGUAGE CXX
)

add_library(ASMCalcLib STATIC
    src/io.s src/main.s src/strlen.s src/parser.s src/string_builder_neo.s src/preprocessor.s
)

target_link_libraries(Tester ASMCalcLib)
if(APPLE)
    target_include_directories(ASMCalc PUBLIC src/macros/darwin)
    target_include_directories(ASMCalcLib PUBLIC src/macros/darwin)
endif()

if(UNIX AND NOT APPLE)
    target_include_directories(ASMCalc PUBLIC src/macros/linux)
    target_include_directories(ASMCalcLib PUBLIC src/macros/linux)
endif()

