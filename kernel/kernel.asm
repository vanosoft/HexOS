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
org 0x08100

jmp p32
nop
times 4-$+$$ db 0x00
dw 0x0DEC0
namestart:
db "system/kernel.hxe", 0x00
nameend:
times 229-namestart+nameend db 00h
dd 0
dd 0
dd EOF-start
dd 1
dd 0
dd 0
db 11000100b

start:

; IMPORTS

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
;; setup ;;
; setup segment registers
mov ax, 16
mov ds, ax
mov ss, ax
mov gs, ax
mov fs, ax
mov es, ax
; init timer chip (100 Hz)
mov byte al, 0x36
mov dword edx, 0x43
out byte dx, al
mov dword eax, 11930
mov dword edx, 0x40
out byte dx, al
mov byte al, ah
out byte dx, al
; setup first PIC
mov dx, 0x20
mov al, 0x11
out byte dx, al
inc dx
mov al, 0x20
out byte dx, al
mov al, 0x04
out byte dx, al
mov al, 0x01
out byte dx, al
; setup second PIC
mov dx, 0xA0
mov al, 0x11
out byte dx, al
inc dx
mov al, 0x28
out byte dx, al
mov al, 0x02
out byte dx, al
dec al
out byte dx, al
; clear general-purpose registers
xor eax, eax
xor ebx, ebx
xor ecx, ecx
xor edx, edx
xor esi, esi
xor edi, edi
xor ebp, ebp
; call kernel main
call main
cli
hlt
jmp $-2

main:
    ; mov eax, 0
    ; idiv eax
    ret

EOF:

times 2000h-$+$$ db 00h