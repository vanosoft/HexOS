;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                              ;;
;; Copyright (C) HexOS author 2019-2022. All rights reserved.   ;;
;; Distributed under terms of the GNU General Public License    ;;
;;                                                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

format binary as "sec"

use16
org 7C00h

jmp boot_entry
nop


boot_entry:

mov ax, 3
int 10h

mov  ah, 02h
mov  al, 2Ch
mov  cx, 0002h
mov  bx, 7E00h
mov bp, 0
mov es, bp
int 13h

mov bp, 0x07E00
jmp 0000:7E00h

cli
hlt
jmp $-2

db 128

times 200h-2h-$+$$ db 00h

dw 0AA55h