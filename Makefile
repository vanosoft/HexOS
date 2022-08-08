# text/plain

build: build-efi-boot
	@clear
build-efi-boot:
	@fasm ./efi/boot/bootx64.asm
	@cp ./efi/boot/bootx64.efi ./efi/boot/hexldr.efi
	@clear
	@echo EFI bootloader was built successfully
load-for-refind: build
	@sudo cp . /boot/efi -r
setup-refind: load-refind-icon
	@sudo py refind-setup/setup.py
	@clear
	@echo HexOS detecting for rEFInd set up successfully!
load-refind-icon:
	@sudo cp ./refind-setup/os_hexos.png /boot/efi/EFI/refind/icons/os_hexos.png
