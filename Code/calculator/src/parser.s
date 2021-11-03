.include "macros.s"

.align 4
.text
.global parse

_add:                           // adds numbers
    fadd D0, D0, D1    
    ret

_sub:                           // substract numbers 
    fsub D0, D0, D1
    ret

_mul:                           // multiply em
    fmul D0, D0, D1
    ret

_div:
    fdiv D0, D0, D1           // divide
    ret

_split:
    fcvtmu X27, D0               // get the integer part by truncating
    scvtf D1, X27                // then turn it into a .0000 float, to be able to do floating ops

    fsub D0, D0, D1             // remove the integer part of the number
    
    mov X3, #1000               // manually loading 1.000.000 into X3, for 6 digit precision
    mul X3, X3, X3
    scvtf D3, X3                // upcast to float, to be able to use it in ops

    fmul D0, D0, D3             // and finally, get the first 6 decimals of our number
    fcvtmu X28, D0              // then downcast back to integer

    // for a number such as xyz.abcdefg, it should be stored
    //      X27        |           X28
    //      xyz        |          abcdef

    ret


_stop:                          // called when numbers have been formed
    scvtf D0, X21
    scvtf D1, X22

    cmp W27, #43                // is it + ?
    beq _add                        

    cmp W27, #45                // is it - ?
    beq _sub

    cmp W27, #42                // is it * ?
    beq _mul

    cmp W27, #47                // is it / ?
    beq _div                    
                                
    ret                          

_adf:                           // add digit to first number
    cmp X13, #0                 // compare to '\0' for redundancy
    b.eq _stop                  
    mov X9, #10                 // load 10 into X9
    mul X21, X21, X9            // then multiply the first number with 10
    sub X10, X13, #48           // substract '0' from the character, obtaining int
    add X21, X21, X10           // add the digit to the number's end
    b cont                      // and move on

_ads:                           // add digit to second number
    cmp X13, #0                 // see above
    b.eq _stop

    mov X9, #10
    mul X22, X22, X9
    sub X10, X13, #48
    add X22, X22, X10
    b cont

_oper:                          // called when an operator has been found
    mov W27, W13                // save the operator
    mov X25, #1                 // set the operator found flag
    b cont                      // and move on

_step:
    ldrb W13, [X1], #1          // read one char from X1, then increment the pointer

    cmp W13, #32                // skip whitespace
    b.eq _step 

    sub X14, X13, #41           // check if char code is greater or equal to 42
    add X15, X13, #-48          // but smaller or equal to 48
                                // this means that it is an operator ( 42 is '*', 47 is '/' etc. see ascii table)
    mul X14, X14, X15           // multiply the two calculations. if the result is smaller than 0, the char is an operator

    cmp X14, #0                 // compare
    b.mi _oper                  // branch

    cmp X25, #0                 // check which number should the digit be added to
    b.eq _adf                   // if X25 is 0, add digit to first
    b.ne _ads                   // else add to second
cont:                           // continue label
    cmp X13, #0                 // compare to see if character is '\0'
    beq _stop                   // then stop
    bne _step                   // else continue
parse: 
    peek X1                     
    push lr     
    
    clear

    bl _step                    // start the actual parsing process
    bl _split

    getptr output              // get the output pointer @here

    bl build_neo

    getptr output
    strb wzr, [X26], #1          // null-terminate it
    //mov X0, X1
    pop lr                      // pop the link register
    ret                         // and return

