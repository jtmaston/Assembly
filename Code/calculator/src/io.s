.macro print prompt

    adrp X1, \prompt@PAGE       ; armv8 is a twat, this is how .data is accessed
    add X1, X1, \prompt@PAGEOFF ; neat.

    bl strlen                 ; find the length of the string to be printed.

    mov X2, X9
    mov X16, #4                 ; write
    mov X0,  #1                 ; to stdin
    svc 0                       ; execute
.endm

.macro print_reg reg            ; todo: what on earth is this code? wrote it at 2am and can't remember *anything* about it.
    mov X5, X1                  ; save a copy of X1
    mov X1,  \reg               ; copy register into X1
    str X1, [sp, #64]           ; store X1 at sp +8
    mov X1, sp
    add X1, X1, #64

    mov X2,  #4                 ; length
    mov X16, #4                 ; write
    mov X0,  #1                 ; to stdin
    svc 0                       ; execute

    mov X1, X5                  ; and restore it

.endm

.macro read                     ; NOTE: TODO
    mov X16, #3                 ; read
    mov X0,  #1                 ; from stdin
    mov X2,  #8                 ; size of 4 bytes
    svc 0
.endm