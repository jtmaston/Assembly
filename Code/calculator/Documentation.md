# ASMCalc

## General architecture
* ASMCalc is spread out amongst a few files. These are: 
    * main.s: contains the main program
    * strlen.s: contains an own implementation of the strlen function
    * macros.s : contains useful macros
    * io.s    : macros to read and write to console, as well as functions to do that.
* Functions are as such:
    * strlen:
        - x1 contains pointer to the string whose lengh has to be known
        - x0 returns length
        - Warning! Requires null terminator!
    * print:
        - prints from memory, relative to the sp of the function0.
        - X1 signifies the slot (3 -> 2 -> 1 -> sp ), basically a 16-byte offset from the sp.
        - Slot must contain a pointer to the string to be printed
        - Warning! Requires null terminator! ( uses strlen )
    * input:
        - reads from stdin and places into a shared buffer input_string. Limited to 100 characters. Each subsequent read is appended to the end of the older one ( this is temporary, while the calculator works on a prompt by prompt basis )

* Macros: because Mach-O is a special child, I've written some push and pop macros for stack manipulation. These respect the guidelines given in the ARMv8 ISA overview.
    * getptr:
        - gets a pointer to a value in the .data section.
        - takes a "var" argument with the label whose address must be found
        - address is stored in X0
    * push:
        - pushes a value onto the stack, by decrementing the sp by 16, then storing the value at that location.
        - takes reg as the argument with the register whose contents must be pushed to the stack.
    * pop:
        - pops a value off the stack, by reading at sp and then incrementing sp by 16.
        - takes reg as the register where the data must be copied to.
    * write:
        - wrapped for the "write" syscall.
        - takes X1 with pointer to the data to be written
        - takes X2 with length of data to be written
    * read:
        - reads up to 100 bytes from stdin.
        - takes X1 with a pointer to the place where the data can be read to.