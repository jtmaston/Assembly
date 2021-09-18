as -g -o output.o $@ 
ld -macosx_version_min 11.3.0 -o output output.o -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path`  -arch arm64
rm output.o
./output