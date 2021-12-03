.include "macros.s"

.align 4
.text
.global preprocess

rm:                             // removes a character, by shifting the array to the left
    ldrb W13, [X1], #1          // load the next character
    cmp W13, #0                 // is it '\0'?
    b.eq done                   // if it is, go to done

    strb w13, [X1, #-2]         // else, replace the previous character with it

    b rm                        // rinse and repeat
    done:                       // we should also remember to null-terminate the result
        strb wzr, [X1, #-2]
        ret X9                  // return to the address

preprocess:                     // the preprocessor is supposed to act upon the initial text
    peek X1                     // to remove whitespaces and segment the math into parantheses
    push lr

    mov X2, X1                  // copy X1, the pointer to the input string

    rmw:                        // remove whitespace
        ldrb W13, [X1], #1      // read a character
        cmp X13, #0             // if it's '\0', searching is done
        b.eq now

        cmp X13, #32            // if it's space
        adr X9, .               // << prepare a return for the branch
        add X9, X9, #16         // >>
        mov X2, X1              // save X1, as it gets destroyed by rm
        b.eq rm                 // remove the whitespace
        mov X1, X2              // restore X1

        b rmw                   // and try to remove more whitespaces

    now:                        // nowhite, whitespace removal process done
        pop lr
        ret

