// describes macros that manipulate data
                                
.macro getptr var               // gets a pointer to a label, returnx in X0
    ldr X0, =\var    
.endm

.macro saveptr var              // get pointer to label, pushing it onto the stack
    getptr \var
    push X0
.endm

.macro regsave
    push X19
    push X20
    push X21
    push X22
    push X23
    push X24
    push X25
    push X26
    push X27
    push X28
.endm

.macro regres
    pop X28
    pop X27
    pop X26
    pop X25
    pop X24
    pop X23
    pop X22
    pop X21
    pop X20
    pop X19
    
.endm