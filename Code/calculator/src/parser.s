.include "macros.s"

.align 4
.text
.global parse

_add:                           // adds numbers
    add X0, X21, X22    
    ret

_sub:                           // substract numbers 
    sub X0, X21, X22
    ret

_mul:                           // multiply em
    mul X0, X21, X22            // TODO:
    ret

_div:
    scvtf s21, X21              // divide em. Technically, this should use the
    scvtf s22, X22              // floating point registers and set the

    fdiv s0, s22, s21           // floating flag correctly
    mov X24, #1                 // TODO:
    ret

_stop:                          // called when numbers have been formed
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


dcount:                         // count digits by dividing the number by 10
    cmp X0, #0                  // compare to '\0'
    b.eq done                   // stop
    
    mov X1, #10                 // auxiliary register to be able to multiply
    
    mul X2, X2, X1              // and then multiply it
    udiv X0, X0, X1             // then divide the result by it
    b dcount

done:
    udiv X2, X2, X1             // we're interested in a power of ten smaller than the number
    ret                         // so divide by 10 again

bstr:                           // BuildSTRing, builds the output string y taking the digits 
    udiv X4, X0, X2             // converting to chars and putting them into the buffer
    mul X5, X4, X2              
    sub X0, X0, X5              // remove the top digit

    mov X1, #10                 // move 10 into X1
    udiv X2, X2, X1             // then divide X2 with it

    add X4, X4, #48             // turn into char by means of adding '0'
    strb W4, [X3], #1           // and store that byte

    
    cmp X2, 0                   // stop when the number is 0
    b.eq done
    b.ne bstr

parse: 
    peek X1                     // X21, X22 store the operands
    push lr                     // X20 stores the text length counter
    mov X24, #0                 // X24 stores a flag that signifies "we need a float register"
                                // X23 is the operator register
    mov X25, #0                 // X25 designates if digits are assigned to the first number or the second one
    
    mov X21, #0                 // initialize the operands. Not needed but redundancy is good.
    mov X22, #0

    bl _step                    // start the actual parsing process
    
    mov X2, X0                  // save X0, since it's trashed by saveptr
    saveptr output              // get the output pointer
    mov X0, X2                  // restore X0
    mov X19, X0
    push X0                     // push the pointer onto the stack
    mov X2, #1                  // initialzie X2
    bl dcount                   // count the digits
    pop X10                      // restore the pointer off the stack
    

    pop X3                      // pop off the stack into X3. Push is wrapped in saveptr on line 129
    mov X10, X3
    mov X0, X19
    bl bstr                     // build the string

    strb wzr, [X3], #1          // null-terminate it
    mov X0, X19
    pop lr                      // pop the link register
    ret                         // and return

