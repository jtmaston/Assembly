// describes macros that manipulate data
                                
.macro getptr var               // gets a pointer to a label, returnx in X0
    adr X0, \var         
.endm

.macro saveptr var              // get pointer to label, pushing it onto the stack
    getptr \var
    push X0
.endm
