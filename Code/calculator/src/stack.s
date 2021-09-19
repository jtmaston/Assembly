.macro push
    sub sp, sp, #16             ; increase stack, keeping it aligned to 16 bytes
    str X0, [sp]                ; store the value there
.endm

.macro pop
    ldr X0, [sp]
    add sp, sp, #16
.endm

.macro pop_t times
    ldr X0, [sp]
    add sp, sp, #16
    pop #(\times-1)
.endm