; typedef struct {
; 	 uint16 address_0_15;
;	 uint16 selector;
;	 uint8 reserved;
;	 uint8 type;
;	 uint16 address_16_31;
; } IntDesc;

macro IRQ IRP {
    dw IRP AND 65535
    dw 8
    db ?
    db 10001111b
    dw (IRP SHR 16) AND 65535
}

macro ISR IRP {IRQ IRP}

struc IDTPTR address {
    .limit dw 256*8
    .base dd address
}

macro IRQ_START {
    pushad
}

macro IRQ_END {
    popad
    iret
}