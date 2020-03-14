%ifndef LIB_ASM
%define LIB_ASM

%define _start main
%define _main main

%macro End 0-1 0
	mov eax, %1
  ret
%endmacro

; backward compability
%define fgets GetStr

; backward compability
%define puts PutStr

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
	NEWLINE		DB		NEWL, NULL
section .code


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

; getstr buffer, length
%macro GetStr 2
	push %2;length
	push %1;buffer
	call read
%endmacro
extern read

;;; putstr (buffer, size)
;;; prints buffer with size to console
%macro PutStr 2
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
%macro PutStr 1
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
	PutStr edi, esi
	%%_skip:
	popad
%endmacro

%define PutNewLine PutStr NEWLINE

;;; get ascci char from console and set AL (no buffer)
;;; no flags and registers (except eax) changed
%macro GetCh 0
	push ecx
	push edx
	call _getch
	pop edx
	pop ecx
%endmacro
extern _getch

;;; get ascci char from console and set AL
;;; no flags and registers (except eax) changed
%macro GetChar 0
	push ecx
	push edx
	call _getchar@8
	pop edx
	pop ecx
%endmacro
extern _getchar@8 ; ch = getch()

;;; put ascii char on screen
%macro PutChar 1
	enter 0,0
	push DWORD %1
	call _putchar@8
	leave
%endmacro
extern _putchar@8 ; putchar(ch)

;;; beep(freq=440Hz, dur=500)
;;; beeps in freq(DWORD)Hz for dur(DWORD) ms
;;; no flags and registers changed
%macro Beep 0-2 440, 500
	push ecx
	push edx
	push eax
	push DWORD %2		; dur
	push DWORD %1		; freq
	call _Beep@8
	pop eax
	pop edx
	pop ecx
%endmacro
extern _Beep@8

%endif
