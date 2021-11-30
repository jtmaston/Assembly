output:
(__TEXT,__text) section
_main:
0000000100003f80	sub	sp, sp, #0x10           // move the stack pointer down by 10
0000000100003f84	mov	w8, #0x0                // load 0 into register 8
0000000100003f88	str	wzr, [sp, #0xc]         // add zero at offset 12
0000000100003f8c	mov	w9, #0x20               // move 32 into register 9
0000000100003f90	str	w9, [sp, #0x8]          // store r9 at address 8
0000000100003f94	mov	w9, #0x2a               // move 42 in register 9
0000000100003f98	str	w9, [sp, #0x4]          // store register 9 at address 4
0000000100003f9c	ldr	w9, [sp, #0x8]          // load address 8 into register 9
0000000100003fa0	ldr	w10, [sp, #0x4]         // load address 4 into register 10
0000000100003fa4	add	w9, w9, w10             // add registers 9 and 10, save into 9
0000000100003fa8	str	w9, [sp, #0x8]          // store 9 at address 8
0000000100003fac	mov	x0, x8                  // move register 8 into register 0
0000000100003fb0	add	sp, sp, #0x10           // move the stack pointer up by 10
0000000100003fb4	ret                         // return 

// Register 8:  used to return 0, no memory position.
// Register 9:  GP
// Register 10: GP

// Memory addresses:
//  sp + 12: 0
//  sp + 8 : a
//  sp + 4 : b

// Flow:
/*
    const 32   -> register 9
    register 9 -> sp + 8
    const 42   -> register 9
    register 9 -> sp + 4

    sp + 8     -> register 9
    sp + 4     -> register 10
    r9 (+) r10 -> register 9
    register 9 -> sp + 8

*/

/*
    Associated c program:
        int main()
        {
            int a = 32//
            int b = 42//

            a = a + b//

            return 0//
        }

 */