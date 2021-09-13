# Addition example, dumps result as the return code

.global _start

.align 2
.text
_start:
    mov X0, #1      ; load 1 into register 0
    mov X1, #1      ; load 2 into register 1
    add X0, X0, X1  ; store value into 0, add regs 0 and 1


    mov X16, #1     ; set SYS_EXIT
    svc 0           ; execute

var1: .word
var2: .word

.data
    
    
    
