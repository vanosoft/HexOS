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

IDT:
    ; exceptions
    IRQ ISR.fault
    IRQ ISR.fault
    IRQ ISR.fault
    IRQ ISR.trap
    IRQ ISR.trap
    IRQ ISR.fault
    IRQ ISR.fault
    IRQ ISR.fault
    IRQ ISR.fault
    IRQ ISR.fault
    IRQ ISR.fault
    IRQ ISR.fault
    IRQ ISR.fault
    IRQ ISR.fault
    IRQ ISR.fault
    IRQ 0 ; reserved
    IRQ ISR.fault
    IRQ ISR.fault
    IRQ ISR.fault
    IRQ ISR.fault
    IRQ ISR.fault
    IRQ ISR.fault
    IRQ 0 ; reserved
    IRQ 0 ; reserved
    IRQ 0 ; reserved
    IRQ 0 ; reserved
    IRQ 0 ; reserved
    IRQ ISR.fault
    IRQ ISR.fault
    IRQ ISR.fault
    IRQ 0 ; reserved
    IRQ ISR.fault
    IRQ ISR.fault
    ; PIC ints (16)
    IRQ ISR.timer
    IRQ ISR.ignore
    IRQ ISR.ignore
    IRQ ISR.ignore
    IRQ ISR.ignore
    IRQ ISR.ignore
    IRQ ISR.ignore
    IRQ ISR.ignore
    IRQ ISR.ignore
    IRQ ISR.ignore
    IRQ ISR.ignore
    IRQ ISR.ignore
    IRQ ISR.ignore
    IRQ ISR.ignore
    IRQ ISR.ignore
    IRQ ISR.ignore
    .pointer:
        dw @f-IDT-1
        dd IDT
    @@:

ISR:
    .fault:
        pushad
        pushf
        cli
        mov ah, [color.bsod]
        mov esi, bsod
        call printsz
        hlt
        jmp $-1
        popf
        popad
        iretd
    .trap:
        pushad
        pushf
        cli
        hlt
        jmp $-1
        popf
        popad
        iretd
    .ignore:
        pushad
        pushf
        cli
        popf
        popad
        iretd
    .timer:
        pushad
        pushf
        cli
        popf
        popad
        iretd
    .keyboard:
        pushad
        pushf
        cli
        mov dx, 0x60
        in byte al, dx
        mov byte [0xB8000], al
        mov byte [.keycode], al
        inc dx
        in byte al, dx
        and al, 1
        out byte dx, al
        popf
        popad
        iretd
        .keycode db ?
    ;

bsod:
db "                                                                                "
db " source: kernel                                                                 "
db "                                                                                "
db "                                                                                "
db "             ((((((                                                             "
db "           ((::::::(             ERROR OCCURRED                                 "
db "         ((:::::::(                                                             "
db "        (:::::::((         Error description:                                   "
db "        (::::::(               kernel caught unhandled exception                "
db " :::::: (:::::(            Patential reasons:                                   "
db " :::::: (:::::(              - Corrupted file system/kernel.hxe                 "
db " :::::: (:::::(              - This is an unstable release                      "
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
db "                                                                                ", 0x00