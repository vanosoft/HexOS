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

printsz:
    mov ebx, 0xB8000
    .cycle:
        lodsb
        cmp al, 00h
        je .end
        push ebx
        add ebx, [curx]
        add [curx], 2
        mov word [ebx], ax
        pop ebx
        jmp .cycle
    .end:
    ret

get_eip:
pop eax
ret

IDT:
    ; ISRs
    IRQ ISR._0
    IRQ ISR._1
    IRQ ISR._2
    ; pointer
    .pointer:
        dw @f-IDT-1
        dd IDT
    @@:

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
        call printsz
        cli
        hlt
        popad
        iret
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
        popad
        iret
    ;

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
db "             ((((((                                                             "
db "                                                                                "
db "                                                                                "
db "                                                                                "
db "                                                                                "
db "                                                                                "
db "                                                                                ", 0x00
bsod_1_plus:
db "code: 00000001h mnemonic: #NMI                                                  ", 0x00
