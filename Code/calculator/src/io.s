.include "macros.s"

.global print, input

.align 4
.text


input:                          ; takes X1 with the pointer to the string to be read to
    push lr

    getptr input_string
    push X0                     ; save X0, so we don't have to get the pointer again.

    mov X1, X0
    bl strlen                   ; find length of the string that has already been written.
    mov X2, X0

    peek X0
    mov X1, X0
    read

    pop X0
    pop lr
    ret

print:                         ; takes X1 as the memory "slot" from which a string to be printed.
    push lr                    ; this is relative tot the sp of each function. Dont' go calling 
    mov X9, #16                ; main's slots from a second function!
    mul X1, X1, X9
    ldr X1, [sp, X1]
   
    bl strlen                  ; detects the length of a null-terminated string
    
    mov X2, X0
    write

    pop lr
    ret
