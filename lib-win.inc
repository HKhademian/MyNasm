%ifndef LIB_ASM
%define LIB_ASM

;;; basic constant and values declration
section .text
	NULL			EQU		0
	CR				EQU		0DH
	LF				EQU		0AH ; `\n`
	TAB				EQU		`\t`
	SPC				EQU		' '
	DOT				EQU		'.'
	%define		CRLF	CR,LF
	%define		NEWL	CR,LF
	NEWLINE		DB		NL, NULL
section .code


; getstr buffer, length
%macro getstr 2
	push %2;length
	push %1;buffer
	call read
%endmacro
extern read

; backward compability
%define fgets getstr

; i2a value, buffer
%macro i2a 2
	push %1;value
	push %2;buffer
	call itoa
%endmacro
extern itoa

; a2i length, buffer
%macro a2i 2
	push %1;length
	push %2;buffer
	call atoi
%endmacro
extern atoi

; backward compability
%define puts putstr

;;; putstr (buffer, size)
;;; prints buffer with size to console
%macro putstr 2
	;; wish to use mov+sub insteadof push to preserve
	;; parameters order but mov cant opperate on mem2mem
	; mov DWORD [ESP-4], DWORD %2			; size
	; mov DWORD [ESP-8], DWORD %1			; buffer
	; sub ESP, 8											; allocate space
	;; call write(buffer, size)
	push DWORD %2 ; size
	push DWORD %1 ; buffer
	call write
%endmacro
extern write

;;; putstr buffer
;;; prints buffer with any size (\0 terminat) to console
%macro putstr 1
	pushad
	lea edi, [%1]
	cmp edi, NULL				; if buffer==NULL then goto skip
	je %%_skip
	mov esi, edi
	dec esi
	%%_get_length:
		inc esi
		cmp BYTE [esi], NULL
		jne %%_get_length
		sub esi, edi			;len = lastP - firstP
		;dec esi					;remove NULL
	cmp esi, 0					; if len<=0 then goto skip
	jle %%_skip
	putstr edi, esi
	%%_skip:
	popad
%endmacro

;;; get ascci char from console and set AL
;;; no flags and registers (except eax) changed
%macro getch 0
	push ecx
	push edx
	call _getch
	pop edx
	pop ecx
%endmacro
extern _getch ; ch = getch()

;;; getch also display it
%macro getchar 0
	getch
	putch eax
%endmacro

;;; put ascii char on screen
%macro putch 1
	enter 0,0
	push DWORD %1
	call putchar
	leave
%endmacro
extern putchar ; putchar(ch)

;;; prints new line
;;; %define putln putcstr LF

;;; beep(freq=440Hz, dur=500)
;;; beeps in freq(DWORD)Hz for dur(DWORD) ms
;;; no flags and registers changed
%macro beep 0-2 440, 500
	push ecx
	push edx
	push eax
	push DWORD %2		; dur
	push DWORD %1		; freq
	call Beep
	pop eax
	pop edx
	pop ecx
%endmacro
extern Beep

%endif
