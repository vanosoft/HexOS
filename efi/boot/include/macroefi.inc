; text/plain
if ~ defined __MACROEFI__
__MACROEFI__ EQU 0

;; --- structures --- ;;

struc sString [value] {
	common
	if ~ value eq 
	du value
	end if
	du 0
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
.scancode dw 0
	end if
	if ~ utf eq 
.unicode du utf
	else
.unicode:
	end if
	du 0
}

;; --- macros --- ;;

macro mEntry _ofs {
	format pe64 dll efi
	entry _ofs
}

macro mInit on_error {
	InitializeLib
	jc on_error
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

macro mCompareStrings str1, str2 {
	lea rsi, [str1]
	lea rdi, [str2]
	mCall __compare_unicode_strings
}

macro mCompareStringsPrefixes str1, str2 {
	lea rsi, [str1]
	lea rdi, [str2]
	mCall __compare_unicode_strings_prefixes
}

macro mLenString _str, _dest {
	mov rbx, _str
	xor rcx, rcx
	mCall __length_unicode_string
	mov _dest, rcx
}

macro mEfidata {
	common
	section ".efitext" data readable writeable
	__crlf sString 13,10
	__key_buf sKey
	__empty_string sString
	__nl_seeked sString "\n"
	__bs_string sString 8, " ", 8, 0, 8
	__hex_prefix sString "0x"
	__hex_buf sString "0000000000000000"
	__clear_line sString 10, " " dup (79), 10
	__clear_string:
	repeat 26
		du 13,10
	end repeat
	du 0
	align 4
	__free_space rb 1024*384
	align 1
}

macro mExit status {
	if status eq 
	mov rax, 0
	else
	mov rax, status
	end if
	retn
}

macro pushaq {
	push rax rbx rcx rdx
	push rbp rsi rdi;rsp
}

macro popaq {
	pop rdi rsi rbp;rsp
	pop rdx rcx rbx rax
}

end if