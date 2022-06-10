;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                              ;;
;; Copyright (C) HexOS author 2019-2022. All rights reserved.   ;;
;; Distributed under terms of the GNU General Public License    ;;
;;                                                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

format binary as "hex"

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

; EXECUTABLE

; switch to P-mode

p32:

cli                     ; NO more interrupts
lgdt fword[GDT.pointer] ; Load GDT
mov eax, cr0            ; Where my CR0?
or al, 1                ; set lowest bit
mov cr0,eax             ; apply changes
jmp GDT.code:pmode     ; jump next

include "idt.asm"

pmode:

use32

; I also need to set data segment

mov ax, GDT.data
mov ds, ax
; stack segment
mov ss, ax
; graphic segment
movs gs, ax

lidt fword [IDT.pointer]

; Call 32-bit kernel

call main

; footer, just halt
; because os mustn`t
; reach this part of
; code so maybe fatal
; error happened.

cli
hlt
jmp $-2

; 32-BIT PART
main:
    mov eax, 0
    idiv eax
    ret

; FILLER

times 1000h-$+$$-1 db 00h

; MAGIC

db EOF
