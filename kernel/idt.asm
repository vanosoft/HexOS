macro IRQ IRP {
    dw IRP AND 65535
    dw GDT.code
    db ?
    db 01110001b
    dw (IRP SHR 16) AND 65535
}

IDT: dw 0
    .size dw @f-GDT-1
    .linear dd GDT
    ; ISRs
    IRQ ISR._0
    IRQ ISR._1
    ; pointer
    .pointer:
        dw GDT.size
        dd GDT
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
