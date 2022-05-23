@ECHO OFF
fasm boot\boot.asm
fasm boot\second.asm
fasm kernel\kernel.asm
fasm collector.asm
copy collector.bin image.bin
del collector.bin /s /q
echo Done. See file [image.bin]