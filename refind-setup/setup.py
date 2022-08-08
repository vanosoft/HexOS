try:
    import os
    pass
except:
    print("cannot import miscellaneous library")
    raise SystemExit(2)

try:
    cfg = open("/boot/efi/EFI/refind/refind.conf", "a")
except PermissionError:
    print("run sudo [command]")
    raise SystemExit(1)
except FileNotFoundError:
    print("warning: file refind.conf doesn't exist. Creting new by defaut")
    cfg = open("/boot/efi/EFI/refind/refind.conf", "w")
    pass

cfg.write("\n# HexOS detecting support\nmenuentry \"HexOS\"\n{\n\tloader /EFI/boot/hexldr.efi\n\ticon /EFI/refind/icons/os_hexos.png\n\tdisabled\n}\n")
cfg.close()
