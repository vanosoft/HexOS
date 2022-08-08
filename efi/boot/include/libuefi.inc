; text/plain

section ".eficode" code executable readable

__scanln:
	pushaq
	mScankey __key_buf
	popaq
	mov bp, word [__key_buf+2]
	cmp bp, word kEnter
	je .exit
	cmp bp, word kBackspace
	je .bs
	mPrint __key_buf+2
	mov [rbx], word bp
	add rbx, 2
	jmp __scanln
.exit:
	;mPrintln
	mov [rbx], word cNull
	ret
.bs:
	cmp rbx, rcx
	je __scanln
	mPrint __bs_string
	sub rbx, 2
	mov [rbx], word cNull
	jmp __scanln

__wait_key:
	push rax
	; scan key
	mScankey __key_buf
	; compare with target
	mov ax, word [__key_buf+2]
	cmp ax, si
	mCall __wait_key
	pop rax
	ret

__gen_hex:
    mov rdi,__hex_buf
    mov rcx, 16
.P1:
	rol eax, 8
    mov bx, ax
    and bx, 0Fh
    add bx, 30h
    cmp bx, 39h
    jna .P2
    add bx, 7
.P2: mov [rdi], word bx
    add rdi, 2
    dec rcx
    jnz .P1
    ret

__compare_unicode_strings:
	rep cmpsw
	mov rbx, rsi
	mCall __length_unicode_string
	mov rcx, rdx
	mov rbx, rdi
	mCall __length_unicode_string
	cmp rcx, rdx
	ret

__compare_unicode_strings_prefixes:
	repnz cmpsw
	ret

__length_unicode_string:
	mov ax, word [rbx]
	test ax, ax
	jz .exit
	inc rcx
	add rbx, 2
	jmp __length_unicode_string
.exit:
	ret