%include "lib.inc"
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
	enter 0,0 ; enter main function

	PutStr MSG_INPUT_A
	GetStr buffer, 15
	a2i 15, buffer
	mov [myA], eax

	PutStr MSG_INPUT_B
	GetStr buffer, 15
	a2i 15, buffer
	mov [myB], eax

	mov eax, [myA]
	add eax, [myB]
	i2a eax, buffer
	PutStr MSG_PLUS
	PutStr buffer

	mov eax, [myA]
	sub eax, [myB]
	i2a eax, buffer
	PutStr MSG_MINUS
	PutStr buffer
	PutNewLine

	leave ; leave main function
	End 0 ; end of program with 0 as result
