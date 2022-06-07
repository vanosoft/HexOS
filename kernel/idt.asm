macro IRQ IRP {
    dw IRP AND 65535
    dw 8
    db ?
    db 10001111b
    dw (IRP SHR 16) AND 65535
}

use32

curx dd 0
cury dd 0
winw dd 160
winh dd 50

color:
.normal db 0x0F
.error  db 0xFC
.block  db 0x70
.bsod   db 0x1F

handle_crlf:

printsz:
    mov ebx, 0xB8000
    .cycle:
        lodsb
        test al, al
        jz .end
        mov bh, 0x0D
        cmp al, bh
        jne .nocrlf
        mov bh, 0x0A
        cmp al, bh
        jne .nocrlf
        add dword [cury], 2
        mov dword [curx], 0
        jmp .cycle
        .nocrlf:
        push ebx
        add dword ebx, [curx]
        mov dword ecx, [cury]
        mov dword edx, [winw]
        imul ecx, edx
        add ebx, ecx
        mov word [ebx], ax
        add dword [curx], 2
        mov eax, [curx]
        mov ecx, [winw]
        cmp eax, ecx
        jl .nonl
        mov dword [curx], 0
        add dword [cury], 2
        .nonl:
        pop ebx
        jmp .cycle
    .end:
    ret

IDT:
    ; ISRs
    IRQ ISR._0
    IRQ ISR._1
    ; pointer
    .pointer:
        dw @f-IDT-1
        dd IDT
    @@:

ISR:
    ._0:
        pushad
	    mov esi, bsod_0
        mov byte ah, [color.bsod]
        call printsz
        cli
        hlt
        popad
        iret
    ._1:
        pushad
        popad
        iret
    ;

bsod_0:
db CRLF
db CRLF
db "             ((((((", CRLF
db "           ((::::::(", CRLF
db "         ((:::::::(", CRLF
db "        (:::::::((", CRLF
db "        (::::::(", CRLF
db " :::::: (:::::(", CRLF
db " :::::: (:::::(", CRLF
db " :::::: (:::::(", CRLF
db "        (:::::(", CRLF
db "        (:::::(", CRLF
db "        (:::::(", CRLF
db " :::::: (::::::(", CRLF
db " :::::: (:::::::((", CRLF
db " ::::::  ((:::::::(", CRLF
db "           ((::::::(", CRLF
db "             ((((((", CRLF
db CRLF
db "code: 00000000h mnemonic: #DE", CRLF, 00h