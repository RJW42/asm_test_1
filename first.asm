org 0x7c00
start:
	mov bx, 0
repeat:
	CALL writeint
	inc bx 
	push bx
	CALL newline	
	CALL pause
	pop bx
	jmp repeat

newline:
	mov al, 0x0a
	mov ah, 0x0e
	mov bx, 0x000f
	int 0x10
	ret

pause:
	mov cx, 0fh
	mov dx, 4240h
	mov ah, 86h
	int 15h
	ret

writeint:
	mov ax, bx
writeint_while:
	test ax, ax
	je writeint_end ; while ax > 0
	
	push ax;
	mov al, 0x31 ; debug
	mov ah, 0x0e
	mov bx, 0x00f 
	int 0x10 ; end of debug 
	pop ax;
	
	mov cl, 0xa
	div cl ; al = ax / 10 ah = ax % 10
	mov ah, 0x0;

	push ax;
	mov al, 0x31 ; debug
	mov ah, 0x0e
	mov bx, 0x00f 
	int 0x10 ; end of debug 
	pop ax;

	jmp writeint_while
writeint_end:
	ret

;end:
;	int 0x20

;fizz:
;	db "Fizz",0
;buzz:
;	db "Buzz",0

	db 0x55,0xaa
