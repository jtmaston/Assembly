.macro getptr var
    adrp X0, \var@PAGE         
    add X0, X0, \var@PAGEOFF     ; load prompt_1 pointer into X1.
.endm

.macro push reg
    sub sp, sp, #16             ; increase stack, keeping it aligned to 16 bytes
    str \reg, [sp]                ; store the value there
.endm

.macro pop reg
    ldr \reg, [sp]
    add sp, sp, #16
.endm

.macro peek reg
    ldr \reg, [sp]
.endm

.macro write
    mov X16, #4                 ; write
    mov X0,  #1                 ; to stdin
    svc 0    
.endm