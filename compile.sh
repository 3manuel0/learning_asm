# nasm -f elf64 -o test.o write_to_file.asm &&\

# nasm -f elf64 -o test.o putnbr.asm &&\
nasm -f elf64 -o test.o read.asm &&\

ld test.o -o test --dynamic-linker /lib64/ld-linux-x86-64.so &&\

# ld test.o -o test \
#     -lc \
#     --dynamic-linker /lib/x86_64-linux-gnu/ld-linux-x86-64.so.2

./test

