// describes macros that manipulate data
                                
.macro getptr var               // gets a pointer to a label, returnx in X0
    adrp X0, \var@PAGE         
    add X0, X0, \var@PAGEOFF
.endm

.macro saveptr var              // get pointer to label, pushing it onto the stack
    getptr \var
    push X0
.endm