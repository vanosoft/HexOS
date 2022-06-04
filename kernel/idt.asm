macro IRQ IRP {
    dw IRP AND 65535
    dw 8
    db ?
    db 10001111b
    dw (IRP SHR 16) AND 65535
}

IDT: dw 0
    .size dw @f-IDT-1
    .linear dd IDT
    ; ISRs
    IRQ ISR._0
    IRQ ISR._1
    ; pointer
    .pointer:
        dw IDT.size
        dd IDT
    @@:

ISR:
    ._0:
        pushad
        popad
        iret
    ._1:
        pushad
        popad
        iret
    ;
