.include "macros.s"

.global strlen

.align 4
.text

_stop:
    pop X9
    pop X1
    pop lr
    ret

_step:
    pop  X9
    add  X9, X9, #1
    push X9

    ldrb W15, [X1], #1          ; read one char from X1, then increment the pointer
    cmp W15, #0

    beq _stop
    bne _step


strlen:                         ; X1 contains pointer to our data
    ;sub sp, sp, #16 
    push lr                     ; put the link register onto the stack
    push X1                     ; push the pointer to the prompt, in order to properly have it when returning

    mov X9, #-1                 ; push X9 onto the stack
    push X9                     ; sp is now at x9
    
    b _step