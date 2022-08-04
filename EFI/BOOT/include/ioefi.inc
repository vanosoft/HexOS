macro mPrint [_str] {
    if ~_str eq 
    forward
	uefi_call_wrapper ConOut, OutputString, ConOut, _str
	end if
}

macro mClear {
	if ~ 0 eq 1
	mCall __clear_screen
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

macro mScankeys _buffer, _times {
	if ~ _buffer eq 
	if ~ _times eq 
		mov rcx, _times
		mov rbx, _buffer
		call __scankeys
	end if
	end if
}

macro mScanln _buffer {
	if ~ buffer eq 
	mov rbx, _buffer
	call __scanln
	end if
}