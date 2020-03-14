%include "lib.inc"
global _main

; CONSTant data here
section .text
	MSG_ENTER		db "Please enter your message: ", CRLF, NULL
	MSG_MESSAGE	db "your message is: ", NULL
	MSG_LEAVE		db CRLF, "good bye!"
							db CRLF, NULL

; uninitialized data here
section .bss
	inputStorage resb 1000


; variables and initialized data
section .data


; program logic
section .code
_main:
	enter 0,0 ; enter main function

	PutStr MSG_ENTER
	GetStr inputStorage, 1000

	PutStr MSG_MESSAGE
	PutStr inputStorage

	PutStr MSG_LEAVE
	PutNewLine

	leave ; leave main function
	End 0 ; end of program with 0 as result
