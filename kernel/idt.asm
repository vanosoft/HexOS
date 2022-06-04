macro IRQ IRP {
    dw IRP AND 65535
    dw 8
    db ?
    db 10001111b
    dw (IRP SHR 16) AND 65535
}

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
	mov eax, 0xb8000
	mov byte [eax], '/'
        popad
        iret
    ._1:
        pushad
        popad
        iret
    ;
