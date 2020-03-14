%ifidn __OUTPUT_FORMAT__, win32
	%include "lib-win.inc"
%elifidn __OUTPUT_FORMAT__, elf32
	%include "lib-elf.inc"
%endif
