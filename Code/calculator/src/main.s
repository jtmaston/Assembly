# This example aims to make a small program to read user input and perform a simple addition.
# Very WIP.
# TODO:
# * Adding logic
# Done:
# * Printing ( I'm stubborn and actively refuse to use printf )
# * Input

.include "macros/macros.s"
.global _main, input_string, char_input

.align 4
.text
.arch armv8-a

_main:
    saveptr prompt                  ; get the pointer of the prompt, save in slot 1
    saveptr cursor                  ; get the pointer of the cursor, save in slot 2
    saveptr input_string            ; get the pointer of the cursor, save in slot 3
    str XZR, [X0]                   ; also initialize input_string with 0

    print #1                        ; print prompt
    print #2                        ; print cursor

    bl input                        ; branch to the input function

    #bl parse                       ; once returned from input, parse it

    mov sp, fp                      ; restore the sp and fp

    mov X0, #0                      ; set exit code 0
    mov X16, #1                     ; set SYS_EXIT
    svc 0                           ; execute 

.bss
.align 16
    input_string: .skip 101         ; reserve max 100 bytes

.data
.align 16
    prompt: .asciz "Welcome! \nThis is a simple calculator. Input your equation and it will solve it. \nEnjoy!\n"
    cursor: .asciz "> "
    

/*
 */
    
