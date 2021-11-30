clang -O0 $@ -g -o output
otool -tvVd output > decomp.s
rm output