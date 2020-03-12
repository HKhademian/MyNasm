%include "lib.inc"
global _main

; CONSTant data here
section .text
	MSG_INPUT_A	db "Enter number A: ", NULL
	MSG_INPUT_B	db "Enter number B: ", NULL
	MSG_PLUS		db "A+b= ", NULL
	MSG_MINUS		db CRLF, "A-b= ", NULL

; uninitialized data here
section .bss
	buffer resb 1000


; variables and initialized data
section .data


; program logic
section .code
_main:
	enter 0,0

	putstr MSG_INPUT_A
	getstr buffer, 15
	a2i 15, buffer
	mov edx, eax

	putstr MSG_INPUT_B
	getstr buffer, 15
	a2i 15, buffer
	mov ecx, eax

	mov eax, edx
	add eax, ecx
	i2a eax, buffer
	putstr MSG_PLUS
	putstr buffer

	mov eax, edx
	sub eax, ecx
	i2a eax, buffer
	putstr MSG_MINUS
	putstr buffer

  mov eax, 0 ; return 0
	leave
	ret
