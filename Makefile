
build:
	fasm efi/boot/bootx64.asm
	cls
dump: build
	hd efi/boot/bootx64.efi
