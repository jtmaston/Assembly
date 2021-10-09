# Load / Store example

.global _start

.align 2
.text
_start:
    mov X0, #1         // load 1 into register 0
    mov X1, #23        // load 2 into register 1

    str X1, [sp, 0x28] // store the value of X1 at address 0x28
    ldr X0, [sp, 0x28] // load address 0x28 into X1

    mov X16, #1        // set SYS_EXIT
    svc 0              // execute


.data
.align 4
    
    
