BITS 64
section .bss
    buffer resb 1024
    flushbuf resb 1024
section .text
global _start
_start:
    mov rax, 0 ; read
    mov rdi, 0 ;
    lea rsi, [buffer]
    mov rdx, 10
    mov r8, rax
    syscall
    .flush:
        mov rax, 0;
        mov rdi, 0;
        lea rsi, [flushbuf]
        mov rdx, 1024
        syscall
        cmp rax, 1024
        jg .flush
    mov rax, 1
    mov rdi, 1
    lea rsi, [flushbuf]
    mov rdx, 10
    syscall
    mov rax, 0x3c ; exit(.)
    mov rdi, 0   ; exit status 0
    syscall 