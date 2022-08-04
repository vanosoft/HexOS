if ~ defined __LIBUEFI__
__LIBUEFI__ EQU 0

__clear_screen:
	mPrint __clear_string
	mReturn

__scankeys:
	mScankey __key_buf
	mPrint __key_buf+2
	mov si, word [__key_buf+2]
	mov [rbx], word si
	add rbx, 2
	loop __scankeys
	mReturn

__scanln:
	; scan key
	mScankey __key_buf
	; print key
	mPrint __key_buf+2
	; load key
	mov si, word [__key_buf+2]
	; if button is [Backspace], print [Space] and [Backspace]
	cmp si, word 8
	je .backspace
	; if button is [Enter-LF], end listening
	cmp si, word 13
	je .exit
	; otherwise, save character and repeat
	mov [rbx], word null
	; shift buffer pointer
	add rbx, 2
	jmp __scanln
.backspace:
	mov [__key_buf+2], word ' '
	mPrint __key_buf+2
	mPrint __bs_string
	; repeat
	jmp __scanln
.exit:
	; end the buffer and exit
	mov [rbx], word null
	mReturn

end if