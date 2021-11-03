.macro print slot
    mov X1, \slot                   // select slot 1
    bl _print                        // print it
.endm

.macro write
    mov X16, #4                 // write
    mov X0,  #1                 // to stdin
    svc 0    
.endm


.macro read
    add X1, X1, X2                 // set offset to be read from.
    mov X16, #3                    // read
    mov X0,  #1                    // from stdin
    mov X2,  #101                  // up to 101 bytes ( to account for newline )
    svc 0
.endm

.macro clear
    mov X19, #0
    mov X20, #0
    mov X21, #0
    mov X22, #0
    mov X23, #0
    mov X24, #0
    mov X25, #0
    mov X26, #0
    mov X27, #0
    mov X28, #0
.endm