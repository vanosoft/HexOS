build:
	fasm BOOTX64.asm
image: build
	mkdir tmp
	mkdir tmp/efi
	mkdir tmp/efi/boot
	cp BOOTX64.efi tmp/efi/boot/BOOTX64.efi
	genisoimage -o ./image.iso -V BACKUP -R -J ./tmp
	rm tmp/efi/boot/*
	rmdir tmp/efi/boot tmp/efi tmp
	cls
dump: build
	hd BOOTX64.efi