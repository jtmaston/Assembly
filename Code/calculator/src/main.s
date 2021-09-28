# This example aims to make a small program to read user input and perform a simple addition.
# Very WIP.
# TODO:
# * Input
# * Adding logic
# Done:
# * Printing ( I'm stubborn and actively refuse to use printf )

.include "macros.s"
.global _main, input_string, char_input

.align 4
.text


_main:
    getptr prompt_2
    push X0

    getptr prompt_1
    push X0

    getptr input_string
    mov X9, #0
    str X9, [X0]

    mov X1, #1
    bl print
    bl input

    mov X1, #2
    bl print
    bl input

    pop X0
    pop X0

    mov X0, #0                    ; set exit code 0
    mov X16, #1                   ; set SYS_EXIT
    svc 0                         ; execute 

.data
.align 16
    prompt_1: .asciz "Please enter the first number: "
    prompt_2: .asciz "Please enter second number: "

    input_string: .skip 800 ; reserve 100 bytes
    char_input: .skip 8

/*
 */
    
