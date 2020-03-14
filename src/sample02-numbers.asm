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
	enter 0,0 ; enter main function

	PutStr MSG_INPUT_A
	GetStr buffer, 15
	a2i 15, buffer
	mov edx, eax

	PutStr MSG_INPUT_B
	GetStr buffer, 15
	a2i 15, buffer
	mov ecx, eax

	mov eax, edx
	add eax, ecx
	i2a eax, buffer
	PutStr MSG_PLUS
	PutStr buffer

	mov eax, edx
	sub eax, ecx
	i2a eax, buffer
	PutStr MSG_MINUS
	PutStr buffer
	PutNewLine

	leave ; leave main function
	End 0 ; end of program with 0 as result
