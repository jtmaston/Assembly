// This example aims to make a small program to read user input and perform a simple addition.
// Very WIP.
// TODO:
//   * Parantheses 
//   * General code cleanup
// Done:
//   * Printing ( I'm stubborn and actively refuse to use printf )
//   * Input
//   * Addition & substraction
//   * Multiplcation
//   * Division
//   * Negative numbers


.include "macros.s"
.global _enter, _calculate, input_string, output

.align 4
.text
.arch armv8-a

_enter:

    saveptr prompt                  // << 
    saveptr cursor                  // save the pointers to the many prompts
    saveptr output                  //
    saveptr input_string            // >>
    print #1                        // print the welcome prompt
    
loop:
    print #2                        // print cursor
    peek X0                         // get the address of input_string into X9
    str XZR, [X0]                   // also initialize input_string with 0
    bl input                        // branch to the input function
    bl parse                        // once returned from input, parse it
    print #3                        // print the result

    cmp X3, #1
    b.eq loop                       // and go back to the beginning

    mov sp, fp                      // restore the sp to fp
    exit

_calculate:                         // wrapper in order to be used as a C function
    regsave                         // save the callee-saved regs

    push fp                         // save the frame pointer
    mov fp, sp                      
    push lr

    mov X2, X0
    saveptr output
    push X2

    bl parse                        // parse the input

    pop X1                          // remove the output pointer
    pop X1                          // remove X2 
    
    pop lr                          // prepare to return
    pop fp
    
    regres                          // restore the saved registers
    getptr output                   // get the output pointer
    ret                             // and return
    

.bss
.align 16
    input_string: .skip 101         // reserve max 100 bytes
    output: .skip 10000

.data
.align 16
    prompt: .asciz "Welcome! \nThis is a simple calculator. Input your equation and it will solve it. \nEnjoy!"
    cursor: .asciz "\n> "
    //input_string: .asciz "3+3"            // NOTE: whitespace broken.
