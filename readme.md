# ASMCalc

## What's this?

A basic calculator app, written in AARCH64 assembly, as a learning experiment. I've written it targetting MacOS and Linux, using the syscalls specific to each OS. Since I'm not quite sure how Windows syscalls work, this is all for now.

## Can I use this?
Of course! The code is all documented, you should be able to follow it even if you've never seen AARCH64 assembly. I use CMake in order to link code and stuff so that it just works. I know it's overkill, but I like it that way.

## What does everything mean?
The files are organized in such way that both a standalone executable ( ASMCalc ) and a Tester program are built. The Tester is simply designed to test the calculator using pseudo-random numbers. If for some strange reason you want to use the calculator's parser and stuff as a standalone function, you could link ASMCalcLib into a regular C program.


## Will this break my computer?
Maybe, maybe not. I've tested the code on MacOS and Ubuntu ARM, and it seems stable, however, as I'm a beginner, no guarantees can be made. I learned how to write this code by decompiling stuff, so perhaps it's even inefficient asf. Don't break your stuff, kids, but if you do, don't come yelling at me! 