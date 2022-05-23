
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                              ;;
;; Copyright (C) HexOS author 2019-2022. All rights reserved.   ;;
;; Distributed under terms of the GNU General Public License    ;;
;;                                                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

__print_stringz__:
mov ah, 0x0E
__print_stringz__.__print_loop__:
lodsb
test al, al
jz __print_stringz__.__print_ending__
int 10h
jmp __print_stringz__.__print_loop__
__print_stringz__.__print_ending__:
ret
macro printsz charptr {
    push ax si
    mov si, charptr
    call __print_stringz__
    pop si ax
}
macro cls {
    push ax
    mov ax, 0003h
    int 10h
    pop ax
}

macro movs reg, src {
    push ax
    mov ax, src
    mov es, ax
    pop ax
}

newline equ 0Dh, 0Ah

EOF equ 128