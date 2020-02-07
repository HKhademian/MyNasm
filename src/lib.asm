extern read,itoa,atoi,write

NULL	EQU 0
CR		EQU 0DH
LF		EQU 0AH
TAB		EQU `\t`

; getstr buffer, length
%macro getstr 2
	push %2;length
	push %1;buffer
	call read
%endmacro

; backward compability
%define fgets getstr

; i2a value, buffer
%macro i2a 2
	push %1;value
	push %2;buffer
	call itoa
%endmacro

; a2i length, buffer
%macro a2i 2
	push %1;length
	push %2;buffer
	call atoi
%endmacro

; backward compability
%define puts putstr

; putstr buffer, size
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

; putstr buffer
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
