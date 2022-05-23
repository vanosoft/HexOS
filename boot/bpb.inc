;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                              ;;
;; Copyright (C) HexOS author 2019-2022. All rights reserved.   ;;
;; Distributed under terms of the GNU General Public License    ;;
;;                                                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

db      'HEXOS   '      ; db 8
dw      512             ; bytes per sector
db      1               ; sectors per cluster
dw      1               ; number of reserver sectors
db      2               ; count of FAT data structures
dw      224             ; count of 32-byte dir. entries (224*32 = 14 sectors)
dw      2880            ; count of sectors on the volume (2880 for 1.44 mbytes disk)
db      0f0h            ; f0 - used for removable media
dw      9               ; count of sectors by one copy of FAT
dw      18              ; sectors per track
dw      2               ; number of heads
dd      0               ; count of hidden sectors
dd      0               ; count of sectors on the volume (if > 65535)
db      0               ; int 13h drive number
db      0               ; reserved
db      29h             ; Extended boot signature
db      0               ; Volume serial number
db      'HEXOS      '   ; Volume label (db 11)
db      'HAT16   '      ; file system type (db 8)
