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
	enter 0,0

	; program starts here
	putstr MSG

  mov eax, 0 ; return 0
	leave
	ret
