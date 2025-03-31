;=================================
L_Display_lcd_d10_Prog_Normal:
	LDX		#lcd_d10
	JSR		L_Dis_8Bit_DigitDot_Prog
	RTS
L_Display_lcd_d9_Prog_Normal:
	LDX		#lcd_d9
	JSR		L_Dis_8Bit_DigitDot_Prog
	RTS
L_Clr_Time_Week_Prog:
	LDA     #10
    JSR		L_Display_lcd_d9_Prog_Normal
	LDA     #10
    JSR		L_Display_lcd_d10_Prog_Normal
	LDX     #lcd_9H	
    JSR		F_ClrpSymbol
    LDX     #lcd_10I	
    JSR		F_ClrpSymbol
	LDX     #lcd_10H		
    JSR		F_ClrpSymbol
    LDX     #lcd_10J	
    JSR		F_ClrpSymbol
	RTS
;===============================
L_Display_lcd_Prog_Normal_Hr:;显示闹钟时钟小时的lcd_5，lcd6
    JSR		L_12_24_Prog
L_Display_lcd_Prog_Normal_Timer:;显示定时器小时的显示函数
    JSR		L_A_HexToHexD
	PHA
	AND		#$0F
    LDX     #lcd_d2
    JSR		L_Dis_8Bit_DigitDot_Prog
	LDX		#lcd_d1
L_Display_lcd_Prog_Normal_1:
	PLA
	JSR		L_ROR_4Bit_Prog
	BEQ		L_Display_lcd_Prog_Normal_Hr_1
	JSR		L_Dis_8Bit_DigitDot_Prog
	RTS
L_Display_lcd_Prog_Normal_Hr_1:
	LDA		#10
	JSR		L_Dis_8Bit_DigitDot_Prog
	RTS


L_Display_lcd_Prog_Normal_Day:
	PHA
	AND		#$0F
    LDX     #lcd_d8
    JSR		L_Dis_8Bit_DigitDot_Prog
	LDX		#lcd_d7
	BRA		L_Display_lcd_Prog_Normal_1
L_Display_lcd_Prog_Normal_Month:
	PHA
	AND		#$0F
    LDX     #lcd_d5
    JSR		L_Dis_8Bit_DigitDot_Prog
	LDX		#lcd_d4
	BRA		L_Display_lcd_Prog_Normal_1
;====================================
L_Display_lcd_Prog_Normal_Sec:;显示秒数的lcd_1，lcd2
    JSR		L_A_HexToHexD
L_Clr_lcd_Prog_Normal_Sec:
	PHA
	AND		#$0F
    LDX     #lcd_d8
    JSR		L_Dis_8Bit_DigitDot_Prog
	LDX		#lcd_d7
L_Display_lcd_Prog_Normal:
	PLA
	JSR		L_ROR_4Bit_Prog
	JSR		L_Dis_8Bit_DigitDot_Prog
	RTS

;=======================================
L_Display_lcd_Prog_Normal_Min:;显示秒数的lcd_3，lcd4
    JSR		L_A_HexToHexD
L_Clr_lcd_Prog_Normal_Min:
	PHA
	AND		#$0F
    LDX     #lcd_d5
    JSR		L_Dis_8Bit_DigitDot_Prog
	LDX		#lcd_d4
	BRA		L_Display_lcd_Prog_Normal 

;=============================================
L_Clr_All_8Bit_Prog:
	LDA		#10
	LDX		#lcd_d1
	JSR     L_Dis_8Bit_DigitDot_Prog
	LDA		#10
	LDX		#lcd_d2
	JSR     L_Dis_8Bit_DigitDot_Prog
	LDA		#10
	LDX		#lcd_d3
	JSR     L_Dis_8Bit_DigitDot_Prog
	LDA		#10
	LDX		#lcd_d4
	JSR     L_Dis_8Bit_DigitDot_Prog
	LDA		#10
	LDX		#lcd_d5
	JSR     L_Dis_8Bit_DigitDot_Prog
	LDA		#10
	LDX		#lcd_d6
	JSR     L_Dis_8Bit_DigitDot_Prog
	LDA		#10
	LDX		#lcd_d7
	JSR     L_Dis_8Bit_DigitDot_Prog
	LDA		#10
	LDX		#lcd_d8
	JSR     L_Dis_8Bit_DigitDot_Prog
	JSR		L_Clr_lcd_T1_Prog
	JSR		L_Clr_lcd_T2_Prog
	JSR		L_Clr_lcd_T3_Prog
	JSR		L_Clr_lcd_T4_Prog
	JSR		L_Clr_lcd_T5_Prog
	JSR		L_Clr_lcd_T6_Prog
	JSR		L_Clr_lcd_T7_Prog
	JSR		L_Clr_lcd_T8_Prog
	RTS
