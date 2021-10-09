.include "macros.s"

.global _print, input

.align 4
.text


input:                          // reads into input_string
    peek X0                     // save the pointer to input_string
    push lr                     // save link register
    push X0                     

    mov X1, X0                  // strlen takes X1 as parameter
    bl strlen                   // find length of the string that has already been written.
    mov X2, X0                  // move the read length into X2, for "read" from later

    peek X1                     // get the pointer again, from memory into X1
    read                        // and read user input

    peek X1                     // get pointer
    bl strlen                   // find length of read string
    
    sub X0, X0, #1              //
    peek X2                     //
    str WZR, [X2, X0]           // and null-terminate it

    pop X0                      // pop X0, as it is no longer needed
    pop lr                      // pop lr and return
    ret

_print:                         // takes X1 as the memory "slot" from which a string to be printed.
    push lr                     // this is relative to the program's frame pointer
    sub X1, X1, #1              // because slots *technically* start from 0, substract 1 from the slot num
    mov X9, #-16                // slots are in 16-bytes offsets
    mul X1, X1, X9              // so get the actual offset from the slot 
    sub X2, fp, #32             // substract 32 from the fp, since that's where sp is at the beginnin of the prog
    ldr X1, [X2, X1]            // load the pointer from the slot
                                
    bl strlen                   // detects the length of a null-terminated string
    
    mov X2, X0                  // after you got the length, set up write
    write                       // and write

    pop lr
    ret
