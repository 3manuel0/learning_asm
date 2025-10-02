BITS 64
section .data
    numb: dq 7155
    val: db 0
    x: dq 0
section .bss
    buffer resb 11 
section .text
global _start
_start:
        mov rax, [numb]
        len:
            inc byte [x]
            xor rdx, rdx
            mov rcx, 10
            div rcx
            cmp rax, 0
            jne len
    putnbr:
        ; mov rax, 255
        dec byte [x]
        mov rax, [numb]
        xor rdx, rdx
        mov rcx, 10
        div rcx
        mov [numb], rax
        mov [val], dl
        add byte [val], 48
        mov rcx, [x]
        mov al, [val] 
        mov byte [buffer + rcx], al
        cmp qword [numb], 0
        je exit
        jmp putnbr
    exit:
        ; mov [numb], rdi
        mov rax, 1
        mov rdi, 1
        lea rsi, [buffer]
        mov rdx, 11
        syscall
        mov rax, 0x3c      ; exit(.)
        mov rdi, 0      ; exit status 0
        syscall        