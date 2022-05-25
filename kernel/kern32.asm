;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                              ;;
;; Copyright (C) HexOS author 2019-2022. All rights reserved.   ;;
;; Distributed under terms of the GNU General Public License    ;;
;;                                                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

use32

main:

mov ebx, 0000B8000h
mov ah, 07
mov al, "O"
mov word [ebx], ax
mov al, "K"
mov word [ebx + 2], ax
ret
