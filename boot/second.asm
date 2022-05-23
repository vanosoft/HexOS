;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                              ;;
;; Copyright (C) HexOS author 2019-2022. All rights reserved.   ;;
;; Distributed under terms of the GNU General Public License    ;;
;;                                                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

format binary as "sec"

org 7E00h

use16

; header zone

jmp second_entry

nop

; import zone

include "second.inc"

; data zone

msg0 db "HexOS Second-stage Bootloader v2.2.1 by Ivan Chetchasov", newline
db "LOG: Loading HAT16 filetable", newline, 00h

bsod0:
db ""
db ""
db "             ((((((", newline
db "           ((::::::(   ERROR OCCURRED", newline
db "         ((:::::::(    At position:  0x000052D", newline
db "        (:::::::((", newline
db "        (::::::(       Reason: cannot load kernel", newline
db " :::::: (:::::(        Maybe your disk is corrupted", newline
db " :::::: (:::::(        So try to re-install system", newline
db " :::::: (:::::(        Or append file 'System/kernel.hex'", newline
db "        (:::::(        To your disk with other PC", newline
db "        (:::::(        (be careful, maybe virus killed", newline
db "        (:::::(        your PC, don`t infect other one!)", newline
db " :::::: (::::::(    ", newline
db " :::::: (:::::::((  ", newline
db " ::::::  ((:::::::( ", newline
db "           ((::::::(", newline
db "             ((((((", newline
db "", newline
db "Errcode: 0x000000D Errname: ERROR_CANNOT_LOAD_KERNEL", newline, 00h

; executable zone

second_entry:

cls

printsz msg0

mov ah, 02h
mov al, 08h
mov cx, 0012h; 0012h is correct
; dl was not modified
mov bx, 8100h
movs es, 0000h
int 13h

jc err0

mov sp, 810h
movs ds, 8100h
jmp 0000:8100h

err0:

; construct BSOD stylish
cls
MOV AH, 06h
XOR AL, AL
XOR CX, CX
MOV DX, 184Fh
MOV BH, 17h
INT 10h

; print data
printsz bsod0

jmp endall

endall:

cli
hlt
jmp $-2

; filler

times 200h*16-1+$-$$ db 00h

; magic

db EOF