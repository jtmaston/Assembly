.include "macros.s"

.align 4
.text

.global build_neo

tpow:                           //TenPOW, calculates 10^[X1]
    mov X0, #1                  // set X0 to 1, as the base power
    cmp X1, #0                  // compare to 0, to know if we need to exit
    b.eq s                      // go to Stop ( I cannot name things, get over it )
    r:                          // Repeat ( I guess? names, man, they suck )
        mov X3, #10             // set up multiplication
        mul X0, X0, X3          // multiply
        sub X1, X1, #1          // decrement the power
        cmp X1, #0
        b.ne r                  // and if power is not 0, do it again
    s:
        ret

modt:                           // MODulo Ten, does X0 % 10
    mov X1, #10                 // move 10 into X1
    udiv X2, X0, X1             // divide the number by 10
    mul X2, X1, X2              // multiply the integer value by 10
    sub X0, X0, X2              // an substract
    ret

trim:                           // trims the trailing zeroes of decimals
    push lr

    retrim:                     // do it again
        mov X3, X0          
        bl modt
        cmp X0, #0              // if the last digit isn't 0, the trimming process is over
        b.ne trimmed            // go to the end of the function

    mov X1, #10                 // else, chop the trailing 0
    udiv X0, X3, X1
    b retrim

    trimmed:                    // and end
        mov X0, X3              // and return the value to what it's supposed to be
        pop lr
        ret

count:                          // conts the digits I
    mov X1, X0
    mov X0, 0x0
    ctin:                       // continue label
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
    mov X26, X0                 // move the output pointer into X26, to be used later
    push lr
    mov X0, X27                 // count the digits of the integer part
    bl count

    sub X1, X1, #1              // and generate a power of ten out of them
    bl tpow

    mov X2, X0                  // move the power of 10 into X2
    mov X0, X27                 // then restore the number
    bl cvrt                     // and convert it to a string

    mov X0, X28                 // load the decimals into X0
    cmp X0, #0                  // check: do we have decimals to add?
    b.eq din                    // if we don't, go to din ( from din-done, never said i knew how to name things )

    mov W4, #46                 // if we do, let's add the decimal point
    strb W4, [X26], #1

    mov X28, X0
    bl count
    cmp X0, #6                  // check if we have 6 decimals
    b.eq no_prefix              // and if we do, skip the prefixing part

    sub X2, X0, #6
    
    prefix:
        mov W4, #48
        strb W4, [X26], #1
        add X2, X2, #1
        cmp X2, #0
        b.ne prefix
    
    no_prefix:

    mov X0, X28                 // move the decimal points into x0
    bl trim                     // remove trailing zeroes
    mov X28, X0                 // then save the trimmed result into X28
    bl count                    // also count its digits

    sub X1, X1, #1              // and pretty much ditto above
    bl tpow

    mov X2, X0
    mov X0, X28
    bl cvrt

    din:
        pop lr
        ret
