//TODO: this file is deprecated and will be removed next commit


.include "macros.s"

.align 4
.text

.global build

done:
    udiv X2, X2, X1             // we're interested in a power of ten smaller than the number
    ret                         // so divide by 10 again

dcount:                         // count digits by dividing the number by 10
    cmp X0, #0                  // compare to '\0'   FIXME: wtf?
    b.eq done                   // stop
    
    mov X1, #10                 // auxiliary register to be able to multiply
    
    mul X2, X2, X1              // and then multiply it
    udiv X0, X0, X1             // then divide the result by it
    b dcount

run:

    udiv X4, X0, X2             // converting to chars and putting them into the buffer
    mul X5, X4, X2              
    sub X0, X0, X5              // remove the top digit

    mov X1, #10                 // move 10 into X1
    udiv X2, X2, X1             // then divide X2 with it

    add X4, X4, #48             // turn into char by means of adding '0'
    strb W4, [X3], #1           // and store that byte

    
    cmp X2, 0                   // stop when the number is 0
    b.ne run
    ret

build:
    push lr

    bl bstr                     // build the string

    pop lr
    ret

zero:
    mov X15, #48
    strb W15, [X3], #1

    mov X15, #10
    udiv X13, X13, X15

    cmp X13, #10
    b.ne zero
    mov X30, X14
    ret

bstr:
    push lr
    mov W25, W0
    lsr X0, X0, #32

    push X0                     // push the pointer onto the stack
    mov X2, #1                  // initialzie X2
    bl dcount                   // count the digits
    pop X0                      // restore the pointer off the stack

    bl run

    mov W4, #46
    strb W4, [X3], #1

    mov W0, W25

    push X0                     // push the pointer onto the stack
    mov X2, #1                  // initialzie X2
    bl dcount                   // count the digits
    pop X0                      // restore the pointer off the stack

    mov X13, #1000
    mul X13, X13, X13

    udiv X13, X13, X2
    cmp X13, #0
    adr X14, .
    add X14, X14, #12
    b.ne zero

    bl run

    pop lr
    ret