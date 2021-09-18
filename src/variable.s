# Addition example, dumps result as the return code

.global _start

.align 4
.text

_print:
    mov X16, #4     ; write
    mov X0,  #1     ; to stdin
    svc 0           ; execute
    ret

_read:
    mov X16, #3     ; read
    mov X0,  #1     ; from stdin
    mov X2,  #4
    svc 0

    ret


_start:
    adrp X1, prompt_1@PAGE
    add X1, X1, prompt_1@PAGEOFF
    mov X2, #27
    BL _print
    

    adrp X1, input_1@PAGE
    add X1, X1, input_1@PAGEOFF

    BL _read


    adrp X1, input_1@PAGE
    add X1, X1, input_1@PAGEOFF

    mov X2, X1


    adrp X1, prompt_2@PAGE
    add X1, X1, prompt_2@PAGEOFF
    mov X2, #27
    BL _print
    
    adrp X1, input_2@PAGE
    add X1, X1, input_2@PAGEOFF

    BL _read

    mov X1, X2

    mov X2, #10
    BL _print
    

    /*BL _print

    
    adrp X1, prompt_2@PAGE
    add X1, X1, prompt_2@PAGEOFF
    mov X2, #27
    BL _print
    BL _read

    str X1, [sp, 0x04]*/


    /*adrp X1,    input@PAGE
    add X1, X1, input@PAGEOFF

    #mov X0, X1
    str X1, [sp, 0x4]
    ldr X0, [sp, 0x4]*/


    /*adrp X1, prompt_1@PAGE
    add X1, X1, prompt_1@PAGEOF
    mov X2, 28
    BL _print
    BL _read

    adrp X1, input@PAGE
    add X1, X1, input@PAGEOFF

    mov X2, #3
    BL _print

    # exit*/
    mov X0, #0
    mov X16, #1        ; set SYS_EXIT
    svc 0              ; execute


.bss
    input_1: .long
    input_2: .long

.data
.align 4
    prompt_1: .ascii "Please enter first number: "
    prompt_2: .ascii "Please enter second number: "
    
