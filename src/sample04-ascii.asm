%include "lib.inc"
global _main

; CONSTant data here
section .text
	MSG_INP			DB "Enter any key to see its ascii code: ", NULL
	MSG_RES			DB " is ", NULL

; uninitialized data here
section .bss
	buffer	RESB 1000


; variables and initialized data
section .data


; program logic
section .code
_main:
	enter 0,0

	putstr MSG_INP
	getchar

	i2a eax, buffer
	putstr MSG_RES
	putstr buffer

  mov eax, 0 ; return 0
	leave
	ret
