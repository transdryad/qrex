bits 64
org 0x08048000

ehdr:                                     ; Elf64_Ehdr
            db  0x7F, "ELF", 2, 1, 1, 0   ;   e_ident
    times 8 db  0
            dw  2                         ;   e_type
            dw  62                        ;   e_machine
            dd  1                         ;   e_version
            dq  _start                    ;   e_entry
            dq  phdr - $$                 ;   e_phoff
            dq  0                         ;   e_shoff
            dd  0                         ;   e_flags
            dw  ehdrsize                  ;   e_ehsize
            dw  phdrsize                  ;   e_phentsize
            dw  1                         ;   e_phnum
            dw  0                         ;   e_shentsize
            dw  0                         ;   e_shnum
            dw  0                         ;   e_shstrndx

ehdrsize    equ $ - ehdr

phdr:                                     ; Elf64_Phdr
            dd  1                         ;   p_type
            dd  7                         ;   p_flags
            dq  0                         ;   p_offset
            dq  $$                        ;   p_vaddr
            dq  $$                        ;   p_paddr
            dq  filesize                  ;   p_filesz
            dq  filesize                  ;   p_memsz
            dq  0x1000                    ;   p_align

phdrsize    equ     $ - phdr
section .data
    string1 db  "QREX64, a linux elf64 executeable within a qr code, by Hazel Viswanath.", 0xa, 0
    string2 db  "Are you a member of Hack Club? (y/n)", 0xa, 0
    string3 db  "Thank you for your input: ", 0
    string4 db  "Thank you for trying out QREX64. Yay Hack Club!", 0xa, 0

section .bss
    buffer resb 16

section .text
    length:
        xor     rcx, rcx            ; zero rcx
        not     rcx                 ; set rcx = -1
        xor     al,al               ; zero the al register (initialize to NUL)
        cld                         ; clear the direction flag
        repnz   scasb               ; get the string length (dec rcx through NUL)
        not     rcx                 ; rev all bits of negative results in absolute value
        dec     rcx                 ; -1 to skip the null-terminator, rcx contains length
        mov     rdx, rcx
        ret

    write:
        mov rsi, rdi ; string in source
        call length
        mov rax, 0x1 ; write to command
        mov rdi, rax ; dest to stdout (1)
        syscall      ; hello kernel please help
        ret

    _start:

        mov     rdi, string1        ; string1 to destination index
        call write
        mov     rdi, string2        ; same for string2
        call write
        xor eax, eax      ; rax <- 0 (syscall number for 'read')
        xor edi, edi      ; stdin file descriptor
        mov rsi, buffer
        lea edx, [buffer]
        syscall
        mov rdi, string3
        call write
        mov rdi, buffer
        call write
        mov rdi, string4
        call write
        xor     rdi,rdi             ; zero rdi (rdi hold return value)
        mov     di, 0x0
        mov     rax, 0x3c           ; set syscall number to 60 (0x3c hex)
        syscall                     ; call kernel

filesize      equ     $ - $$
