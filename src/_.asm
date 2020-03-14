%include "lib.inc"
global _main

; constant data here
section .text
	MSG db "Hello World!", CR, LF, NULL

; uninitialized data here
section .bss


; variables and initialized data
section .data


; program logic
section .code
; int main() function, program starts here
_main:
	enter 0,0 ; enter main function

	; program starts here
	PetStr MSG
	PutNewLine

	leave ; leave main function
	End 0 ; end of program with 0 as result
