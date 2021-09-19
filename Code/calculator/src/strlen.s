.global strlen

.align 4
.text
_calc_strlen:
    str lr, [sp, #32]           ; store link register for return to strlen

    ldr X9, [sp, #16]           ; read the counter from memory
    add X9, X9, #1              ; increment by 1
    str X9, [sp, #16]           ; and then re-save it

    
    ldrb W15, [X1], #1          ; read one char from X1, then increment the pointer
    cmp W15, #0                 ; have we found \0?

    beq _abort                  ; yes, then stop.
    bne _calc_strlen            ; no, recurse and keep searching

    ldr lr, [sp, #32]           ; guarantee safe return
    ret

_abort:
    
    ldr lr, [sp, 32]            ; go back to _lenstr's pc
    ret

strlen:
    sub sp, sp, #16             ; make sure stack isn't overwritten

    mov X5, X1                  ; save X1, so we don't have to adrp it again
    mov X9, #-1                 ; start the counter with -1, since first thing we do is increment it

    sub sp, sp, #48             ; allocate space for the lr and for the counter ( and one extra slot for sanity )
    str lr, [sp]                ; save the link register
    str X9, [sp, #16]            ; write counter to memory

    bl _calc_strlen             ; calculate the length of thr string
    

    ldr lr, [sp]                ; load the link register
    add sp, sp, #48             ; de-allocate memory

    mov X1, X5                  ; re-load X1

    add sp, sp, #16
    ret