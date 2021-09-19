.global print

.align 4
.text

.macro write
    mov X16, #4                 ; write
    mov X0,  #1                 ; to stdin
    svc 0    
.endm

.macro read                     ; NOTE: TODO
    mov X16, #3                 ; read
    mov X0,  #1                 ; from stdin
    mov X2,  #8                 ; size of 4 bytes
    svc 0
.endm


print:
    mov X1, #16
    mul X0, X0, X1
    ldr X1, [sp, X0]

    bl strlen                 ; find the length of the string to be printed.

    mov X2, X9
    write
