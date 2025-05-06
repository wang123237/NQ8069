L_Display_Calculator_Prog:
    LDA     #0
    LDX     #lcd_d8
    JSR     L_Dis_8Bit_DigitDot_Prog
    RTS
;=======================================================

L_Clr_0_Prog:
	LDX		#3
	LDA     #8
    STA     DINX
DISP_GET_INX_LOOP:
	LDA		DBUF, X
	AND		#0F0H
	LJNZ	RET;等于0继续，不等于退出
	LDA		DBUF+DFD
	AND		#07FH
	CMP		DINX;检查小数点位数是否大于最大值
	LJZ		RET;相等退出，不相等继续
	LDA		DBUF, X
	AND		#00FH
	ORA		#0A0H;清除高四位，保留低四位
	STA		DBUF, X
	DEC		DINX
	LJE		DINX, 1, RET;比较Dinx的值和1，相等退出
	LDA		DBUF, X
	AND		#0FH
	LJNZ	RET;低四位不等于0退出
	LDA		DBUF+DFD
	AND		#07FH;检查小数点位数是否大于最大值
	CMP		DINX
	LJZ		RET;相等退出，不相等继续
	LDA		DBUF, X
	AND		#0F0H
	ORA		#00AH
	STA		DBUF, X
	DEC		DINX
	DEX
	BRA		DISP_GET_INX_LOOP
;======================================================================
L_Display_FD_Prog:
	JSR		L_Clr_FD_Prog
    LDA     DBUF+DFD
    AND     #07H
    CLC
    CLD
    ROL
    TAX
    LDA     Table_FD+1,X
    PHA
    LDA     Table_FD,X
    PHA
    RTS
Table_FD:
	DW      L_Dis_lcd_T8_Prog-1
    DW      L_Dis_lcd_T8_Prog-1
    DW      L_Dis_lcd_T7_Prog-1
    DW      L_Dis_lcd_T6_Prog-1
    DW      L_Dis_lcd_T5_Prog-1
    DW      L_Dis_lcd_T4_Prog-1
    DW      L_Dis_lcd_T3_Prog-1
    DW      L_Dis_lcd_T2_Prog-1
    DW      L_Dis_lcd_T1_Prog-1

L_Clr_FD_Prog:
	JSR		L_Clr_lcd_T1_Prog
	JSR		L_Clr_lcd_T2_Prog
	JSR		L_Clr_lcd_T3_Prog
	JSR		L_Clr_lcd_T4_Prog
	JSR		L_Clr_lcd_T5_Prog
	JSR		L_Clr_lcd_T6_Prog
	JSR		L_Clr_lcd_T7_Prog
	JSR		L_Clr_lcd_T8_Prog
	RTS
;======================================================================
L_Display_NEG_Prog:
	LDA		DBUF+DFD
	AND		#080H
	LJZ		L_Display_NEG_Prog_RTS
	JE		DINX, 12, L_Display_NEG_Prog_RTS;相等跳转，不相等继续执行
	LDA		DINX
	CLC
	ROR
	TAX
	JNC		DISP_NEG_L;判断是低四位还是高四位，若为偶数处理低四位，否则处理高四位
	CLD
	CLC
	LDA		DBUF,X
	AND		#00FH
	ORA		#0B0H
	STA		DBUF,X
	RTS
DISP_NEG_L:
	LDA		DBUF,X
	AND		#0F0H
	ORA		#00BH
	STA		DBUF,X
L_Display_NEG_Prog_RTS:
    RTS
;==============================================================
L_Symbol_Prog:
    RTS
; =====================================================================
L_Copy_DBUF_TO_D1BUF_FD_Prog:
	LDA		DBUF+DFD
	STA		D1BUF+D1FD
	LDA		DBUF
	STA		D1BUF
	LDA		DBUF+1
	STA		D1BUF+1
	LDA		DBUF+2
	STA		D1BUF+2
	LDA		DBUF+3
	STA		D1BUF+3
	RTS
	;-----------------------------------
L_Copy_D1BUF_TO_DBUF_FD_Prog:
	LDA		D1BUF+D1FD
	STA		IBUF+IFD
	LDA		D1BUF
	STA		IBUF
	LDA		D1BUF+1
	STA		IBUF+1
	LDA		D1BUF+2
	STA		IBUF+2
	LDA		D1BUF+3
	STA		IBUF+3
	RTS
;=====================================================================	
L_Display_Number_IBUF_Prog:
	JSR		L_Copy_IBUF_TO_DBUF_FD_Prog
	JMP		L_Display_Number_Prog
	;-----------------------------------
L_Display_Number_BUF1_Prog:
	LDX		#(BUF1-RAM)
	JSR		L_Save_DBUF_Prog
	JMP		L_Display_Number_Prog
;=====================================================================
L_Copy_IBUF_TO_DBUF_FD_Prog:
	LDX		#(IBUF-RAM)
	LDA		RAM+IFD,X
	BRA		L_Save_DBUF_Prog_X
L_Save_DBUF_Prog:
	LDA		RAM+FD,X
L_Save_DBUF_Prog_X:
	STA		DBUF+DFD
	LDA		RAM,X
	STA		DBUF
	LDA		RAM+1,X
	STA		DBUF+1
	LDA		RAM+2,X
	STA		DBUF+2
	LDA		RAM+3,X
	STA		DBUF+3
	RTS
;=====================================================================
L_Display_Number_Prog:
	JSR		L_Copy_DBUF_TO_D1BUF_FD_Prog			
	;----------------------------------
    JSR     L_Clr_0_Prog
    JSR     L_Display_FD_Prog
    JSR     L_Display_NEG_Prog
	JSR		L_Symbol_Prog					
	;----------------------------------
L_Display_Number_Prog_DBUF:;DBUF+3存储的是高位数字
	LDA		DBUF+3
	AND     #F0H
	JSR		L_ROR_4Bit_Prog
    LDX     #lcd_d1
    JSR     L_Dis_8Bit_DigitDot_Prog
    LDA		DBUF+3
	AND     #0FH
    LDX     #lcd_d2
    JSR     L_Dis_8Bit_DigitDot_Prog


    LDA		DBUF+2
	AND     #F0H
	JSR		L_ROR_4Bit_Prog
    LDX     #lcd_d3
    JSR     L_Dis_8Bit_DigitDot_Prog
    LDA		DBUF+2
	AND     #0FH
    LDX     #lcd_d4
    JSR     L_Dis_8Bit_DigitDot_Prog


    LDA		DBUF+1
	AND     #F0H
	JSR		L_ROR_4Bit_Prog
    LDX     #lcd_d5
    JSR     L_Dis_8Bit_DigitDot_Prog
    LDA		DBUF+1
	AND     #0FH
    LDX     #lcd_d6
    JSR     L_Dis_8Bit_DigitDot_Prog


    LDA		DBUF
	AND     #F0H
	JSR		L_ROR_4Bit_Prog
    LDX     #lcd_d7
    JSR     L_Dis_8Bit_DigitDot_Prog
    LDA		DBUF
	AND     #0FH
    LDX     #lcd_d8
    JSR     L_Dis_8Bit_DigitDot_Prog
	RTS


