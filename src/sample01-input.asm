%include "lib.inc"
global _main

; CONSTant data here
section .text
	MSG_ENTER		db "Please enter your message: ", CRLF, NULL
	MSG_MESSAGE	db "your message is: ", NULL
	MSG_LEAVE		db CRLF, "good bye!"
							db CRLF, "press any key to exit ..."
							db CRLF, NULL

; uninitialized data here
section .bss
	inputStorage resb 1000


; variables and initialized data
section .data


; program logic
section .code
_main:
	enter 0,0

	putstr MSG_ENTER
	getstr inputStorage, 1000

	putstr MSG_MESSAGE
	putstr inputStorage

	putstr MSG_LEAVE
	getch

  mov eax, 0 ; return 0
	leave
	ret
