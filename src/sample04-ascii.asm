%include "lib.inc"
global _main

; CONSTant data here
section .text
	MSG_INP			DB "Enter any key to see its ascii code: ", NULL
	MSG_RES			DB " : It is ", NULL

; uninitialized data here
section .bss
	buffer	RESB 1000


; variables and initialized data
section .data


; program logic
section .code
_main:
	enter 0,0 ; enter main function

	PutStr MSG_INP
	GetCh
	;PutChar eax

	i2a eax, buffer
	PutStr MSG_RES
	PutStr buffer
	PutNewLine

	leave ; leave main function
	End 0 ; end of program with 0 as result
