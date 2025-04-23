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
;================================================================
.MACRO	LJZ	Addr
	.local _add
	BNE		_add
	JMP		Addr
	_add:
.ENDMACRO
;=================================================================
.MACRO	JE	Ram,Val,Addr,R							
	.if(.blank(R))
	LDA		Ram
	CMP		#Val
	BEQ		Addr
	.else
	LDA		Ram
	CMP		Val
	BEQ		Addr
	.endif
.ENDMACRO
.MACRO	LJE	Ram,Val,Addr,R
	.local	_add
	.if(.blank(R))
	LDA		Ram
	CMP		#Val
	BNE		_add
	JMP		Addr
	.else
	LDA		Ram
	CMP		Val
	BNE		_add
	JMP		Addr
	.endif
	_add:
.ENDMACRO
;=========================================================
.MACRO	JNC	Addr									;CΪ0��ת
	BCC		Addr
.ENDMACRO