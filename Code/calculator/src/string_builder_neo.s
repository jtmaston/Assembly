.include "macros.s"

.align 4
.text

.global build_neo

tpow:                       //tenpow
    mov X0, #1              // set X0 to 1, as the base power

    cmp X1, #0              // compare to 0 
    b.eq s
    r:
        mov X3, #10
        mul X0, X0, X3
        sub X1, X1, #1
        cmp X1, #0
        b.ne r
    s:
    ret

modt:       // modulo 10
    mov X1, #10
    udiv X2, X0, X1
    mul X2, X1, X2
    sub X0, X0, X2
    ret

trim:
    push lr

    retrim:
        mov X3, X0
        bl modt
        cmp X0, #0
        b.ne trimmed

    mov X1, #10
    udiv X0, X3, X1
    b retrim

    trimmed:
        pop lr
        ret

count:
    mov X1, X0
    mov X0, 0x0
    ctin:
        mov X2, 0xA
        udiv X1, X1, X2
        add X0, X0, 0x1
        cmp X1, 0x0
        b.ne ctin
    mov X1, X0 
    ret

cvrt:                           // convert
    udiv X4, X0, X2             // converting to chars and putting them into the buffer
    mul X5, X4, X2              
    sub X0, X0, X5              // remove the top digit

    mov X1, #10                 // move 10 into X1
    udiv X2, X2, X1             // then divide X2 with it

    add X4, X4, #48             // turn into char by means of adding '0'
    strb W4, [X26], #1           // and store that byte

    cmp X2, 0                   // stop when the number is 0
    b.ne cvrt
    ret



build_neo:
    mov X26, X0
    push lr
    mov X0, X27
    bl count

    sub X1, X1, #1
    bl tpow

    mov X2, X0
    mov X0, X27
    bl cvrt

    mov X0, X28
    cmp X0, #0        // check: do we have decimals to add?
    b.eq din

    mov W4, #46       // if so, let's add the decimal point
    strb W4, [X26], #1

    mov X0, X28
    bl trim
    mov X28, X0

    bl count
    

    sub X1, X1, #1
    bl tpow

    mov X2, X0
    mov X0, X28

    
    bl cvrt

    din:
    pop lr
    ret
