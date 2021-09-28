.include "macros.s"

.global print, read

.align 4
.text


read:
    push lr

    getptr input
    mov X1, X0

    mov X16, #3                    ; read
    mov X0,  #1                    ; from stdin
    mov X2,  #128                  ; size of 4 bytes
    svc 0

    push X1
    mov X1, #1
    bl print

    pop lr
    ret

print:                        ; uses X1, X0, X2, X9 ; needs X1 loaded with pointer to prompt
    push lr                   ; find the length of the string to be printed.  
    mov X9, #16
    mul X1, X1, X9
    ldr X1, [sp, X1]
   
    bl strlen
    
    mov X2, X9
    write

    pop lr
    ret
