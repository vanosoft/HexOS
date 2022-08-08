; text/plain

if ~ defined cUefipIncluded

cUefipIncluded EQU 1

macro mDefMacros {
	include "include/eficonst.inc"
	include "include/macroefi.inc"
	include "include/ioefi.inc"
}

macro mDefSystem {
	include "include/sysuefi.inc"
}

macro mDefLibrary {
	include "include/libuefi.inc"
}

else

display "UEFI+ library already included!"

end if
