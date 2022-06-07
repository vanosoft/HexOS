; typedef struct {
; 	 uint16 address_0_15;
;	 uint16 selector;
;	 uint8 reserved;
;	 uint8 type;
;	 uint16 address_16_31;
; } IntDesc;

struc ISR address {
    .address_low dw (address AND 65536)
    .selector dw 8
    .rezerved db 0
    .type db 8Eh
    .address_high dw (address SHR 16 AND 65536)
}

struc IDTR address {
    .limit dw 256*8
    .base dd address
}

;    irq_base = 0x20;
;	irq_count = 16;
;	outportb(0x20, 0x11);
;	outportb(0x21, irq_base);
;	outportb(0x21, 4);
;	outportb(0x21, 1);
;	outportb(0xA0, 0x11);
;	outportb(0xA1, irq_base + 8);
;	outportb(0xA1, 2);
;	outportb(0xA1, 1);

macro SETUPIRQ {
    out 20h, 11h
    out 21h, 20h
    out 21h, 4
    out 21h, 1
    out 0A0h, 11h
    out 0A1h, 28h
    out 0A1h, 2
    out 0A1h, 1
}

macro IRQ_START {
    pushad
}

macro IRQ_END {
    mov al, 20h
    out 20h, al
    out 0A0h, al
    popad
    iret
}