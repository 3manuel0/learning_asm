nasm -f elf64 -o test.o write_to_file.asm &&\
ld -o test test.o -dynamic-linker /lib64/ld-linux-x86-64.so

