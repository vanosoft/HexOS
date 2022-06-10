@ECHO OFF
fasm kernel\kernel.asm
fasm boot\boot.asm
fasm boot\second.asm
fasm collector.asm
copy collector.bin image.bin /b
copy collector.bin image.img /b
del collector.bin /s /q
echo Done. See file [image.img]