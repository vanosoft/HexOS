use32

include "idt.inc"

align 10h

IDT:
ISR zrdiv_int
ISR debug_int
ISR nomsk_int
ISR brkpt_int
ISR ovflw_int
ISR bnrex_int
ISR invop_int
ISR devna_int
ISR dofau_int
ISR csgov_int
ISR intss_int
ISR sgnpr_int
ISR ssfau_int
ISR gpfau_int
ISR pgfau_int
ISR 0
ISR fpexc_int
ISR alchk_int
ISR mnchk_int
ISR smdex_int
ISR vrexc_int
ISR cpexc_int
ISR 0
ISR hiexc_int
ISR vcexc_int
ISR scexc_int
ISR 0
ISR tpfau_int
ISR fpuer_int
;
zrdiv_int:
    IRQ_START
    cli
    hlt
    jmp $-2
    IRQ_END
;
debug_int:
    IRQ_START
    jmp $
    IRQ_END
;
nomsk_int:
    IRQ_START
    cli
    hlt
    jmp $-2
    IRQ_END
;
brkpt_int:
    IRQ_START
    cli
    hlt
    jmp $-2
    IRQ_END
;
ovflw_int:
    IRQ_START
    jmp $
    IRQ_END
;
bnrex_int:
    IRQ_START
    cli
    hlt
    jmp $-2
    IRQ_END
;
invop_int:
    IRQ_START
    cli
    hlt
    jmp $-2
    IRQ_END
;
devna_int:
    IRQ_START
    cli
    hlt
    jmp $-2
    IRQ_END
;
dofau_int:
    IRQ_START
    cli
    hlt
    jmp $-2
    IRQ_END
;
csgov_int:
    IRQ_START
    cli
    hlt
    jmp $-2
    IRQ_END
;
intss_int:
    IRQ_START
    cli
    hlt
    jmp $-2
    IRQ_END
;
sgnpr_int:
    IRQ_START
    cli
    hlt
    jmp $-2
    IRQ_END
;
ssfau_int:
    IRQ_START
    cli
    hlt
    jmp $-2
    IRQ_END
;
gpfau_int:
    IRQ_START
    cli
    hlt
    jmp $-2
    IRQ_END
;
pgfau_int:
    IRQ_START
    cli
    hlt
    jmp $-2
    IRQ_END
;
; RESERVED
;
fpexc_int:
    IRQ_START
    cli
    hlt
    jmp $-2
    IRQ_END
;
alchk_int:
    IRQ_START
    cli
    hlt
    jmp $-2
    IRQ_END
;
mnchk_int:
    IRQ_START
    cli
    hlt
    jmp $-2
    IRQ_END
;
smdex_int:
    IRQ_START
    cli
    hlt
    jmp $-2
    IRQ_END
;
vrexc_int:
    IRQ_START
    cli
    hlt
    jmp $-2
    IRQ_END
;
cpexc_int:
    IRQ_START
    cli
    hlt
    jmp $-2
    IRQ_END
;
; RESERVED
;
hiexc_int:
    IRQ_START
    cli
    hlt
    jmp $-2
    IRQ_END
;
vcexc_int:
    IRQ_START
    cli
    hlt
    jmp $-2
    IRQ_END
;
scexc_int:
    IRQ_START
    cli
    hlt
    jmp $-2
    IRQ_END
;
; RESERVED
;
tpfau_int:
    IRQ_START
    cli
    hlt
    jmp $-2
    IRQ_END
;
fpuer_int:
    IRQ_START
    cli
    hlt
    jmp $-2
    IRQ_END
;