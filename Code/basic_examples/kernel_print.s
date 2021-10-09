# This example aims to make a small program to read user input and perform a simple addition.
# Very WIP.
# TODO:
# * Input
# * Adding logic
# Done:
# * Printing ( I'm stubborn and actively refuse to use printf )



.global _main

.align 4
.text

.macro print_reg reg            // todo: what on earth is this code? wrote it at 2am and can't remember *anything* about it.
    mov X5, X1                  // save a copy of X1
    mov X1,  \reg               // copy register into X1
    str X1, [sp, #64]           // store X1 at sp +8
    mov X1, sp
    add X1, X1, #64

    mov X2,  #4                 // length
    mov X16, #4                 // write
    mov X0,  #1                 // to stdin
    svc 0                       // execute

    mov X1, X5                  // and restore it

.endm


.macro print prompt

    adrp X1, \prompt@PAGE       // armv8 is a twat, this is how .data is accessed
    add X1, X1, \prompt@PAGEOFF // neat.

    bl _lenstr                  // find the length of the string to be printed.

    mov X2, X9
    mov X16, #4                 // write
    mov X0,  #1                 // to stdin
    svc 0                       // execute
.endm

.macro read                     // NOTE: TODO
    mov X16, #3                 // read
    mov X0,  #1                 // from stdin
    mov X2,  #8                 // size of 4 bytes
    svc 0
.endm

_calc_strlen:
    str lr, [sp, #32]           // store link register for return to strlen

    ldr X9, [sp, #16]           // read the counter from memory
    add X9, X9, #1              // increment by 1
    str X9, [sp, #16]           // and then re-save it

    
    ldrb W15, [X1], #1          // read one char from X1, then increment the pointer
    cmp W15, #0                 // have we found \0?

    beq _abort                  // yes, then stop.
    bne _calc_strlen            // no, recurse and keep searching

    ldr lr, [sp, #32]           // guarantee safe return
    ret

_abort:
    
    ldr lr, [sp, 32]            // go back to _lenstr's pc
    ret

_lenstr:
    mov X5, X1                  // save X1, so we don't have to adrp it again
    mov X9, #-1                 // start the counter with -1, since first thing we do is increment it

    sub sp, sp, #48             // allocate space for the lr and for the counter ( and one extra slot for sanity )
    str lr, [sp]                // save the link register
    str X9, [sp, 16]            // write counter to memory

    bl _calc_strlen             // calculate the length of thr string
    

    ldr lr, [sp]                // load the link register
    add sp, sp, #48             // de-allocate memory

    mov X1, X5                  // re-load X1
    ret

_main:
    print prompt_1              // print the first input string
    read                        // read user input

    print prompt_2              // print second prompt string

    mov X0, #0                  // set exit code 0
    mov X16, #1                 // set SYS_EXIT
    svc 0                       // execute

.bss
    input_1: .long
    input_2: .long

.data
.align 4
    prompt_1: .asciz "Please enter first number: "
    prompt_2: .asciz "Please enter second number: "
    
    
