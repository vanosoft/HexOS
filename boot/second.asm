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

mov ah, 0x02
mov al, 0x08
mov cx, 0x0C
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
printsz bsod

jmp endall

endall:

cli
hlt
jmp $-2

bsod:
db "                                                                                "
db " source: bootldr                                                                "
db "                                                                                "
db "                                                                                "
db "             ((((((                                                             "
db "           ((::::::(             ERROR OCCURRED                                 "
db "         ((:::::::(                                                             "
db "        (:::::::((         Error description:                                   "
db "        (::::::(               bootldr caught unhandled exception               "
db " :::::: (:::::(            Patential reasons:                                   "
db " :::::: (:::::(              - Corrupted file system/bootldr.hxe                "
db " :::::: (:::::(              - This is an unstable release                      "
db "        (:::::(            Ways to solve the problem:                           "
db "        (:::::(              - reinstall system                                 "
db "        (:::::(              - install stable bootldr                           "
db " :::::: (::::::(                                                                "
db " :::::: (:::::::((         If it is not unstable realise or                     "
db " ::::::  ((:::::::(        bootldr wasn`t touched, write me                     "
db "           ((::::::(       in Habr OS writing blog. Thanks.                     "
db "             ((((((                                                             "
db "                                                                                "
db "                                                                                "
db "                                                                                "
db "                                                                                "
db "                                                                                ", 0x00

db 128

times 200h*(0Ch-2)-$+$$ db 00h
