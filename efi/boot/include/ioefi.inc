; text/plain

macro mPrint [_str] {
    if ~_str eq 
    forward
	uefi_call_wrapper ConOut, OutputString, ConOut, _str
	end if
}

macro mClear {
	if ~ 0 eq 1
	mPrint __clear_string
	end if
}

macro mNewline [times_] {
	if times_ eq 
	mPrintln
	else
	repeat times_
		mPrintln
	end repeat
	end if
}

macro mPrintln [_str] {
	if ~ _str eq 
	forward
	mPrint _str
	mPrint __crlf
	else
	mPrint __crlf
	end if
}

macro mScankey _key {
	if ~ _key eq 
	mov [_key], dword 0
@@:
	uefi_call_wrapper ConIn, ReadKeyStroke, ConIn, _key
	cmp dword [_key], 0
	jz @b
	end if
}

macro mScanln _buffer {
	if ~ buffer eq 
	mov rbx, _buffer
	mov rcx, rbx
	call __scanln
	end if
}

macro mWaitkey _key {
	if ~ _key eq 
	push rsi
	mov si, _key
	call __wait_key
	pop rsi
	end if
}

macro mPrinthexln _number, _prefix {
	if ~ _number eq 
	push rax
	mov eax, _number
	mCall __gen_hex
	if ~ _prefix eq cFalse
	mPrint __hex_prefix
	end if
	mPrintln __hex_buf
	pop rax
	end if
}

macro mPrinthex _number, _prefix {
	if ~ _number eq 
	push rax
	mov eax, _number
	mCall __gen_hex
	if ~ _prefix eq cFalse
	mPrint __hex_prefix
	end if
	mPrint __hex_buf
	pop rax
	end if
}

macro mClearln {
	mPrint __clear_line
}

macro mGetMMap _mmap {
	uefi_call_wrapper BootServices, GetMemoryMap, qword _mmap, qword _mmap+8, qword _mmap+8+cUefiMMapSize, qword _mmap+8+cUefiMMapSize+8, qword _mmap+8+cUefiMMapSize+8+8
}