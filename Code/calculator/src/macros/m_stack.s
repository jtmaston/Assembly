.macro push reg
    sub sp, sp, #16               // increase stack, keeping it aligned to 16 bytes
    str \reg, [sp]                // store the value there
.endm

.macro pop reg
    ldr \reg, [sp]
    add sp, sp, #16
.endm

.macro peek reg
    ldr \reg, [sp]
.endm

.macro get_slot reg, slot
    mov X19, #16
    mul X19, X19, slot
    ldr reg [fp, X19]
.endm