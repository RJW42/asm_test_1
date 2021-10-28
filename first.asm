org 0x7c00
start:
	mov bx, 1
repeat:
	mov ax, bx
	push bx 
	mov ah, 0x00
	mov [is_divisible], ah

	; Check if bx is divisible by 3 
	mov cl, 0x03
	div cl ; AL = AX / 3 AH = AX % 3
	cmp ah, 0
	je display_fizz

repeat_buzz:
	pop bx 
	push bx 
	mov ax, bx

	; Check if divisible by 5 
	mov cl, 0x05 
	div cl 
	cmp ah, 0 
	je display_buzz
	

repeat_num:
	; If neither write num 
	mov ah, [is_divisible]
	cmp ah, 0x01
	je repeat_end
	pop ax 
	push ax
	CALL display_number

repeat_end:	
	CALL newline	
	CALL pause
	
	pop bx
	inc bx 
	jmp repeat

display_fizz:
	mov ah, 0x01
	mov [is_divisible], ah
	mov bx, fizz
	CALL display_word
	jmp repeat_buzz

display_buzz:
	mov ah, 0x01 
	mov [is_divisible], ah 
	mov bx, buzz
	CALL display_word
	jmp repeat_num

display_word:
	mov al, [bx]
	test al, al
	je display_word_end 
	push bx
	mov ah, 0x0e
	mov bx, 0x000f 
	int 0x10 
	pop bx 
	inc bx 
	jmp display_word
display_word_end:
	ret

newline:
	push ax
	push bx 
	mov al, 0x0a
	mov ah, 0x0e
	mov bx, 0x0f
	int 0x10
	mov al, 0x0d
	int 0x10
	pop ax 
	pop bx
	ret

pause:
	mov cx, 0ah
	mov dx, 4240h
	mov ah, 86h
	int 15h
	ret

display_char:
	push ax 
	push bx 
	push cx 
	push dx 
	push si 
	push di 
	mov ah, 0x0e ; Load AH with code for terminal output 
	mov bx, 0x000f ; Load BH page zero and BL color (graphic mode)
	int 0x10 ; call the bios for displaying one char 
	pop di 
	pop si 
	pop dx
	pop cx 
	pop bx 
	pop ax
	ret 

display_number:
	mov dx, 0
	mov cx, 10
	div cx 
	push dx 
	cmp ax, 0
	je display_number_1 
	call display_number 
display_number_1:
	pop ax 
	add al, '0'
	call display_char 
	ret 

fizz:
	db "Fizz", 0

buzz:
	db "Buzz", 0

is_divisible:
	db 0