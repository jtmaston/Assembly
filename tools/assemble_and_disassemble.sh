as $@ -o output.o
ld -macosx_version_min 11.0.0 -o output output.o -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _start -arch arm64
rm output.o
otool -tvVd output > disas.s
rm output