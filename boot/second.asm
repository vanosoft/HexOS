;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                              ;;
;; Copyright (C) HexOS author 2019-2022. All rights reserved.   ;;
;; Distributed under terms of the GNU General Public License    ;;
;;                                                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

format binary as "sec"

org 7E00h
start:
use16

; header zone

jmp second_entry

nop

; import zone

include "second.inc"

; executable zone

second_entry:

cls

;printsz msg0

mov ah, 02h
mov al, 08h
mov cx, 0012h; 0012h is correct
; dl was not modified
mov bx, 8100h
movs es, 0000h
int 13h

jc err0

mov sp, 8100h
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

bsod:
db "Source: second-stage bootloader                                                 "
db "                                                                                "
db "             ((((((                                                             "
db "           ((::::::(             ERROR OCCURRED                                 "
db "         ((:::::::(                                                             "
db "        (:::::::((         Error description:                                   "
db "        (::::::(               Kernel reached unsolving situation               "
db " :::::: (:::::(            Patential reasons:                                   "
db " :::::: (:::::(              - Corrupted file system/kernel.hex                 "
db " :::::: (:::::(              - This is an unstable realise                      "
db "        (:::::(            Ways to solve the problem:                           "
db "        (:::::(              - reinstall system                                 "
db "        (:::::(              - install stable kernel                            "
db " :::::: (::::::(                                                                "
db " :::::: (:::::::((         If it is not unstable realise or                     "
db " ::::::  ((:::::::(        kernel was not touched, write me                     "
db "           ((::::::(       in Habr OS writing blog. Thanks.                     "
db "             ((((((                                                             "
db "                                                                                "
db "                                                                                "
db "                                                                                "
db "                                                                                "
db "                                                                                "
db "                                                                                "
db "                                                                                ", 0x00

db 128

times 200h*(0Ch-2)-$+$$ db 00h
