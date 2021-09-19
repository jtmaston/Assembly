# This example aims to make a small program to read user input and perform a simple addition.
# Very WIP.
# TODO:
# * Input
# * Adding logic
# Done:
# * Printing ( I'm stubborn and actively refuse to use printf )

.include "stack.s"
.global _main

.align 4
.text

.macro print_reg reg            ; todo: what on earth is this code? wrote it at 2am and can't remember *anything* about it.
    mov X5, X1                  ; save a copy of X1
    mov X1,  \reg               ; copy register into X1
    str X1, [sp, #64]           ; store X1 at sp +8
    mov X1, sp
    add X1, X1, #64

    mov X2,  #4
    write

    mov X1, X5                  ; and restore it

.endm

_main:
    adrp X0, prompt_1@PAGE
    add X0, X0, prompt_1@PAGEOFF   ; save pointers to the prompts onto the stack
    push

    adrp X0, prompt_2@PAGE       
    add X0, X0, prompt_2@PAGEOFF   ; ditto
    push

    mov X0, #0                      ; select stack slot 1 ( prompt_1 )
    bl print                        ; print it

    pop
    pop

    mov X0, #0                      ; set exit code 0
    mov X16, #1                     ; set SYS_EXIT
    svc 0                           ; execute 

.bss
    input_1: .long
    input_2: .long

.data
.align 16
    prompt_1: .asciz "Please enter first number: "
    prompt_2: .asciz "Please enter second number: "

/*
    Memory mapping:
    sp + 16: prompt_1*
    sp + 32: prompt_2*

 */
    
