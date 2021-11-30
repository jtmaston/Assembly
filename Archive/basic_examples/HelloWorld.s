.global _start

.align 2
.text
_start:

    # write system call

    mov X16, #4     // write
    mov X0,  #1     // to stdin
    adr X1, message // text
    mov X2,  #13    // which is 13 bytes long
    svc 0           // execute


    # exit syscall 
    mov X16, #1     // set SYS_EXIT
    mov X0, #0      // exit code is 0
    svc 0           // execute

message: .ascii "Hello, world!"

.data
    
    
    
