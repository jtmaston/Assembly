# This example aims to make a small program to read user input and perform a simple addition.
# Very WIP.
# TODO:
# * Input
# * Adding logic
# Done:
# * Printing ( I'm stubborn and actively refuse to use printf )

.include "io.s"

.global _main

.align 4
.text


_main:
    print prompt_1              ; print the first input string
    read                        ; read user input

    print prompt_2              ; print second prompt string

    mov X0, #0                  ; set exit code 0
    mov X16, #1                 ; set SYS_EXIT
    svc 0                       ; execute 

.bss
    input_1: .long
    input_2: .long

.data
.align 4
    prompt_1: .asciz "Please enter first number: "
    prompt_2: .asciz "Please enter second number: "
    
    
