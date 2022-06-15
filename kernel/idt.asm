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

<<<<<<< Updated upstream
=======
handle_crlf:

>>>>>>> Stashed changes
printsz:
    mov ebx, 0xB8000
    .cycle:
        lodsb
<<<<<<< Updated upstream
        cmp al, 00h
        je .end
        push ebx
        add ebx, [curx]
        add [curx], 2
        mov word [ebx], ax
=======
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
>>>>>>> Stashed changes
        pop ebx
        jmp .cycle
    .end:
    ret

<<<<<<< Updated upstream
get_eip:
pop eax
ret

=======
>>>>>>> Stashed changes
IDT:
    ; ISRs
    IRQ ISR._0
    IRQ ISR._1
<<<<<<< Updated upstream
    IRQ ISR._2
=======
>>>>>>> Stashed changes
    ; pointer
    .pointer:
        dw @f-IDT-1
        dd IDT
    @@:

<<<<<<< Updated upstream
dumpeax:
.h dd 0x1F411F45
.l dd 0x1F3A1F58
dumpebx:
.h dd 0x1F421F45
.l dd 0x1F3A1F58
dumpecx:
.h dd 0x1F431F45
.l dd 0x1F3A1F58
dumpedi:
.h dd 0x1F531F45
.l dd 0x1F3A1F49
dumpesi:
.h dd 0x1F441F45
.l dd 0x1F3A1F49

ISR:
    ._0: ; #DE
        pushad
        mov ah, [color.bsod]
        mov esi, bsod_0
        call printsz
        mov ah, [color.block]
        mov esi, bsod_0_plus
=======
ISR:
    ._0:
        pushad
	    mov esi, bsod
        mov byte ah, [color.bsod]
>>>>>>> Stashed changes
        call printsz
        cli
        hlt
        popad
        iret
<<<<<<< Updated upstream
    ._1: ; #DB
        pushad
        cli
        hlt
        popad
        iret
    ._2:
        pushad
        mov ah, [color.bsod]
        mov esi, bsod_1
        call printsz
        mov ah, [color.block]
        mov esi, bsod_1_plus
        call printsz
        cli
        hlt
=======
    ._1:
        pushad
>>>>>>> Stashed changes
        popad
        iret
    ;

<<<<<<< Updated upstream
bsod_0:
db "                                                                                "
db "                                                                                "
db "             ((((((                                                             "
db "           ((::::::(             ERROR OCCURRED                                 "
db "         ((:::::::(                                                             "
db "        (:::::::((         Error description:                                   "
db "        (::::::(               Kernel shot attempt to divide by zero            "
db " :::::: (:::::(            Patential reasons:                                   "
db " :::::: (:::::(              - Corrupted file system/kernel.hex                 "
db " :::::: (:::::(              - This is an IDT test                              "
db "        (:::::(            Ways to solve the problem:                           "
db "        (:::::(              - reinstall system                                 "
db "        (:::::(              - install stable kernel                            "
db " :::::: (::::::(                                                                "
db " :::::: (:::::::((         If it is not unstable realise or                     "
db " ::::::  ((:::::::(        kernel was not touched, write me                     "
db "           ((::::::(       in Habr OS writing blog. Thanks.                     "
db "             ((((((                                                             "
db "                                                                                "
db "                                                                                "
db "                                                                                "
db "                                                                                "
db "                                                                                "
db "                                                                                ", 0x00
bsod_0_plus:
db "code: 00000000h mnemonic: #DE                                                   ", 0x00

bsod_1:
db "                                                                                "
db "                                                                                "
db "             ((((((                                                             "
db "           ((::::::(             ERROR OCCURRED                                 "
db "         ((:::::::(                                                             "
db "        (:::::::((         Error description:                                   "
db "        (::::::(               Kernel shot attempt to raise NMI                 "
db " :::::: (:::::(            Patential reasons:                                   "
db " :::::: (:::::(              - Corrupted file system/kernel.hex                 "
db " :::::: (:::::(              - This is an IDT test                              "
db "        (:::::(            Ways to solve the problem:                           "
db "        (:::::(              - reinstall system                                 "
db "        (:::::(              - install stable kernel                            "
db " :::::: (::::::(                                                                "
db " :::::: (:::::::((         If it is not unstable realise or                     "
db " ::::::  ((:::::::(        kernel was not touched, write me                     "
db "           ((::::::(       in Habr OS writing blog. Thanks.                     "
=======
bsod:
db "                                                                                "
db "                                                                                "
db "                                                                                "
db "                           FATAL ERROR OCCURRED                                 "
db "             ((((((                                                             "
db "           ((::::::(   Potential causes:                                        "
db "         ((:::::::(     - Corrupted file 'system/kernel.hxe'                    "
db "        (:::::::((      - It is unstable OS image                               "
db "        (::::::(        - Bad sectors in disk                                   "
db " :::::: (:::::(                                                                 "
db " :::::: (:::::(        Ways to resolve:                                         "
db " :::::: (:::::(         - Reinstall OS                                          "
db "        (:::::(         - Use tool 'repair' in bootable image                   "
db "        (:::::(                                                                 "
db "        (:::::(        Also, please, make a bugreport on email                  "
db " :::::: (::::::(       chetvano@gmail.com or my whatsapp phone                  "
db " :::::: (:::::::((     number +79653533222. Thank you for rep!                  "
db " ::::::  ((:::::::(                                                             "
db "           ((::::::(                                                            "
>>>>>>> Stashed changes
db "             ((((((                                                             "
db "                                                                                "
db "                                                                                "
db "                                                                                "
db "                                                                                "
<<<<<<< Updated upstream
db "                                                                                "
db "                                                                                ", 0x00
bsod_1_plus:
db "code: 00000001h mnemonic: #NMI                                                  ", 0x00
=======
db "                                                                                ", 00h
>>>>>>> Stashed changes
