.MACRO	LJNZ Addr
	.local _add
	BEQ		_add
	JMP		Addr
	_add:
.ENDMACRO
;===============================================================.
.MACRO	JNZ Addr									;ZΪ0��ת
	BNE		Addr
.ENDMACRO