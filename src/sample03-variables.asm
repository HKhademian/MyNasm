%include "lib.asm"
global _main

; CONSTant data here
section .text
	MSG_INPUT_A	DB "Enter number A: ", NULL
	MSG_INPUT_B	DB "Enter number B: ", NULL
	MSG_PLUS		DB "A+b= ", NULL
	MSG_MINUS		DB CRLF, "A-b= ", NULL

; uninitialized data here
section .bss
	buffer RESB 1000


; variables and initialized data
section .data
	myA DD 0
	myB DD 0


; program logic
section .code
_main:
	enter 0,0

	putstr MSG_INPUT_A
	getstr buffer, 15
	a2i 15, buffer
	mov [myA], eax

	putstr MSG_INPUT_B
	getstr buffer, 15
	a2i 15, buffer
	mov [myB], eax

	mov eax, [myA]
	add eax, [myB]
	i2a eax, buffer
	putstr MSG_PLUS
	putstr buffer

	mov eax, [myA]
	sub eax, [myB]
	i2a eax, buffer
	putstr MSG_MINUS
	putstr buffer

  mov eax, 0 ; return 0
	leave
	ret
