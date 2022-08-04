if ~ defined __MACROEFI__
__MACROEFI__ EQU 0


;; --- constants --- ;;
true EQU 1
false EQU 0
null EQU 0
nl EQU 13,10
____ EQU 
left equ @b
right EQU @f

;; --- structures --- ;;

struc sString [value] {
	common
	if ~ value eq 
	. du value, null
	else
	. du null
	end if
}

struc sStrbuf _len {
	if ~ len eq 
.len dq _len*2
.val rw _len
	else
.len dq 1024*2
.val rw 1024
	end if
}

struc sKey scan, utf {
	if ~ scan eq 
.scancode dw scan
	else
.scancode dw null
	end if
	if ~ utf eq 
.unicode du utf
	else
.unicode:
	end if
	du null
}

;; --- macros --- ;;

macro mEntry _ofs {
	format pe64 dll efi
	entry _ofs
}

macro mInit {
	InitializeLib
	jnc @f
	mExit EFI_SUCCESS
@@:
}

macro mReturn [data] {
	if ~ data eq 
	forward
	push data
	end if
	common
	ret
}

; may be extensioned in future
macro mCall func {
	common
	if ~ func eq 
	call func
	else
	nop
	end if
}

macro mEfidata {
	common
	mSect .fidata, data
	__crlf sString nl
	__key_buf sKey null, null
	__empty_string sString ""
	__nl_seeked sString "\n"
	__bs_string sString 8
	__clear_string:
	repeat 26
		du nl
	end repeat
	du null
	align 4
	__free_space rb 1024*384
	align 1
}

macro mExit status {
	if status eq 
	mov eax, EFI_SUCCESS
	else
	mov eax, status
	end if
	retn
}

macro mAnonymous [definition] {
	common
@@	definition
}

macro mSect name, type {
	if type eq data
	section '.#name' data readable writable
	else if type eq code
	section '.#name' code executable readable
	else if type eq text
	section '.#name' code executable readable
	else if type eq fixup
	section '.#name' fixups data discardable
	end if
}

include "ioefi.inc"
include "efitime.inc"

end if