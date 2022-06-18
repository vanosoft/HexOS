;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                              ;;
;; Copyright (C) HexOS author 2019-2022. All rights reserved.   ;;
;; Distributed under terms of the GNU General Public License    ;;
;;                                                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

format binary as "hxe"

; MACROS

macro movs reg, src {
    push ax
    mov ax, src
    mov reg, ax
    pop ax
}

; HEADER
org 0x8100

jmp p32
nop

db "system/kernel.hex", 00h
times 243-$+$$ db 00h

dd 00000000h
dd 00000000h
dd 00001000h
db 10000000b

; IMPORTS

include "fs.inc"
include "str.inc"

; DATA

osname db "HexOS", 00h
osver  db "v0.9.4", 00h
oscopy db "Ivan Chetchasov Vladimirovich 2019-2022 (c) All rights reserved.", 00h

; SYSDATA

GDT: dw 0
    .size dw @f-GDT-1
    .linear dd GDT
    .code = $ - GDT
        dw -1,0
        db 0,9ah,0cfh,0
    .data = $ - GDT
        dw -1,0
        db 0,92h,0cfh,0
    .pointer:
        dw GDT.size
        dd GDT
    @@:

p32:

cli
lidt fword [IDT.pointer]
lgdt fword [GDT.pointer]
mov eax, cr0
or al, 1
mov cr0,eax 
jmp 8:pmode

include "idt.asm"

pmode:
mov ax, 16
mov ds, ax
mov ss, ax
movs gs, ax
call main
cli
hlt
jmp $-2

main:
    ret

db 128

times 2000h-$+$$ db 00h