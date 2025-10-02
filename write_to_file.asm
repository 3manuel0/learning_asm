section .rodata
file:
    db "test.txt", 0
text:
    db "anger builds", 10
global _start
section .text
_start:
    mov rax, 2  ; open(...)   
    mov rdi, file ; file
    mov rsi, 65    ; flags
    mov rdx, 0o666  ; mode 
    syscall      

    mov rdi, rax ;storing fd in rdi
    
    mov rax, 1  ; write(...)
    mov rsi, text ; buf
    mov rdx, 13   ; len
    syscall      

    ;close(fd)
    mov rax, rdi     
    syscall 

    ; exit(0)
    mov rax, 0x3c      ; exit(.)
    mov rdi, 0      ; exit status 0
    syscall        
