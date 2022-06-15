;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                              ;;
;; Copyright (C) HexOS author 2019-2022. All rights reserved.   ;;
;; Distributed under terms of the GNU General Public License    ;;
;;                                                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

format binary as "sec"

org 7E00h

jmp start
nop

db "system/bootsec.hex", 0x00
times 243-$+$$ db 00h

dd 00000000h
dd 00000000h
dd 00001000h
db 10000000b

start:
use16

jmp second_entry
nop

printsz:
mov ah, 0x0E
.cycle:
lodsb
test al, al
jz .end
int 10h
jmp .cycle
.end:
ret

second_entry:

cls

;printsz msg0

mov ah, 0x02
mov al, 0x10
mov cx, 0x0C
; dl was not modified
mov bx, 8100h
mov bp, 0
mov es, bp
int 13h

jc err0

mov sp, 0x08100
mov bp, 0x00810
mov ds, bp
jmp 0000:8100h

err0:

; construct BSOD stylish
MOV AH, 06h
XOR AL, AL
XOR CX, CX
MOV DX, 184Fh
MOV BH, 17h
INT 10h

; print data
mov si, bsod
call printsz

jmp endall

endall:

cli
hlt
jmp $-2

; data zone

msg0 db "HexOS Second-stage Bootloader v2.2.1 by Ivan Chetchasov", newline, 00h

bsod0:
db newline
db newline
db "             ((((((", newline
db "           ((::::::(   ERROR OCCURRED", newline
db "         ((:::::::(", newline
db "        (:::::::((", newline
db "        (::::::(       Reason: cannot load kernel", newline
db " :::::: (:::::(        Maybe your disk is corrupted", newline
db " :::::: (:::::(        So try to re-install system", newline
db " :::::: (:::::(        Or append file 'System/kernel.hex'", newline
db "        (:::::(        To your disk with other PC", newline
db "        (:::::(        (be careful, maybe virus killed", newline
db "        (:::::(        your PC, don`t infect other one!)", newline
db " :::::: (::::::(", newline
db " :::::: (:::::::((", newline
db " ::::::  ((:::::::(", newline
db "           ((::::::(", newline
db "             ((((((", newline
db newline
db "Errcode: 0000000Dh Errname: ERROR_CANNOT_LOAD_KERNEL", newline, 00h

; filler

times 200h*0x2C/4-1+start-$ db 00h

; magic

db EOF
