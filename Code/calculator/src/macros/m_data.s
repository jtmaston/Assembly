.macro getptr var
    adrp X0, \var@PAGE         
    add X0, X0, \var@PAGEOFF     ; load prompt_1 pointer into X0.
.endm

.macro saveptr var
    getptr \var
    push X0
.endm