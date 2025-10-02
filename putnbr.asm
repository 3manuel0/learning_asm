BITS 64
; 18446744073709551615
section .data
    numb: dq -99222
    errmsg: db "number exceded the int limit", 10 
    msglen equ $ - errmsg
section .bss
    val: resb 1
    x: resq 1
    numlen: resq 1
    buffer resb 11 
section .text
global _start
_start: 
    mov rax, [numb]
    len:
        inc byte [x]
        inc byte [numlen]
        xor rdx, rdx
        mov rcx, 10
        div rcx
        cmp rax, 0
        jne len
    putnbr:
        ; mov rax, 255
        dec qword [x]
        cmp qword [x], 10
        jg error ; jump if [x] > 10
        xor rdx, rdx
        mov rax, [numb]
        mov rcx, 10
        div rcx
        mov [numb], rax
        mov [val], dl ; rdx modulo 8 bits
        add byte [val], 48 ; 5 + 48-> 5 + '0'-> '5'
        mov rcx, [x]
        mov al, [val] 
        mov byte [buffer + rcx], al ; buffer[x] = al
        cmp qword [numb], 0
        je exit
        jmp putnbr
    exit:
        ; mov [numb], rdi
        mov rax, 1; write
        mov rdi, 1; fd 
        lea rsi, [buffer]; buff
        mov rcx, [numlen];len
        mov byte [buffer + rcx], byte 10; buffer[6] = '\n'
        inc qword [numlen]
        mov rdx, [numlen]; len
        syscall
        mov rax, 0x3c      ; exit(.)
        mov rdi, 0     ; exit status 0
        syscall        
    error:
        mov rax, 1; write()
        mov rdi, 1; fd
        lea rsi, errmsg ; buf
        mov rdx, msglen ; len
        syscall
        mov rax, 0x3c      ; exit(.)
        mov rdi, 0      ; exit status 0
        syscall    