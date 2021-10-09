// This example aims to make a small program to read user input and perform a simple addition.
// Very WIP.
// TODO:
//   * Multiplcation and division
//   * Parantheses 
//   * Negative numbers
//   * General code cleanup
// Done:
//   * Printing ( I'm stubborn and actively refuse to use printf )
//   * Input
//   * Addition & substraction


.include "macros.s"
.global _main, input_string, output

.align 4
.text
.arch armv8-a

_main:
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

    b loop                          // and go back to the beginning

    mov sp, fp                      // restore the sp and fp

    mov X0, #0                      // set exit code 0
    mov X16, #1                     // set SYS_EXIT
    svc 0                           // execute 

.bss
.align 16
    input_string: .skip 101         // reserve max 100 bytes
    output: .skip 10000

.data
.align 16
    prompt: .asciz "Welcome! \nThis is a simple calculator. Input your equation and it will solve it. \nEnjoy!"
    cursor: .asciz "\n> "
    newline: .asciz ""
    #input_string: .asciz "123*4"
