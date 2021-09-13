clang++ -O0 $@ -o output
otool -tvVd output > decomp.s
rm output