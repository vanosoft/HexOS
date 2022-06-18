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

mov ah, 0x02
mov al, 0x10
mov cx, 0x0C
mov bx, 8100h
mov bp, 0
mov es, bp
int 13h

jc err0

mov sp, 0x08100
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

newline equ 0dh, 0ah

; data zone

msg0 db "HexOS Second-stage Bootloader v2.2.1 by Ivan Chetchasov", newline, 00h

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

times 0x01400+$$-$ db 00h