BITS 64
; 18446744073709551615
section .data
    numb: dq 6744073709
    errmsg: db "number exceeded the 10 chracter limit", 0xa 
    msglen equ $ - errmsg
section .bss
    buffer resb 11 
section .text
global _start
_start: 
    mov rax, [numb] ; rax = numb
    len:
        inc r8
        inc r9
        xor rdx, rdx
        mov rcx, 10
        div rcx
        cmp rax, 0
        jne len
    putnbr:
        ; mov rax, 255
        dec r8
        cmp r8, 10
        jg error ; jump if r8 > 10
        xor rdx, rdx ; rdx = 0 
        mov rax, [numb] ; rax = *p
        mov rcx, 10
        div rcx
        mov [numb], rax
        mov r11b, dl ; rdx modulo 8 bits
        add byte r11b, 48 ; 5 + 48-> 5 + '0'-> '5'
        mov rcx, r8
        mov byte [buffer + rcx], byte r11b ; buffer[rcx] = r11b
        cmp qword [numb], 0 ; 64 bit
        je exit
        jmp putnbr
    exit:
        ; mov [numb], rdi
        mov rax, 1; write
        mov rdi, 1; fd 
        lea rsi, [buffer]; buff
        mov rcx, r9; len
        mov byte [buffer + rcx], byte 10; buffer[rcx] = '\n'
        inc qword r9
        mov rdx, r9; len
        syscall
        mov rax, 0x3c  ; exit(.)
        mov rdi, 0     ; exit status 0
        syscall        
    error:
        mov rax, 1; write()
        mov rdi, 1; fd
        lea rsi, errmsg ; buf
        mov rdx, msglen ; len
        syscall
        mov rax, 0x3c ; exit(.)
        mov rdi, 0   ; exit status 0
        syscall    