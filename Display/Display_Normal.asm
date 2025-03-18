;=================================
L_Display_lcd_d13_Prog_Normal:
	LDX		#lcd_d13
	JMP		L_Dis_8Bit_DigitDot_Prog
L_Display_lcd_d11_Prog_Normal:
	LDX		#lcd_d11
	JMP		L_Dis_8Bit_DigitDot_Prog
L_Display_lcd_d12_Prog_Normal:
	LDX		#lcd_d12
	JMP		L_Dis_8Bit_DigitDot_Prog
;==================================
L_Clr_Time_Week_Prog:
	JSR     L_Clr_lcd_d11_Prog
    JSR     L_Clr_lcd_d12_Prog
    JMP     L_Clr_lcd_d13_Prog
;===============================
L_Clr_lcd_Prog:
    JSR     L_Clr_Day_Prog
    JSR     L_Clr_Month_Prog
    JMP     L_Clr_lcd_D2_Prog
;==================================

L_Clr_Hr_Prog:
    LDA		#AAH
    BRA     L_Clr_lcd_Prog_Normal_Timer
L_Display_lcd_Prog_Normal_Hr:;显示闹钟时钟小时的lcd_5，lcd6
    JSR		L_12_24_Prog
L_Display_lcd_Prog_Normal_Timer:;显示定时器小时的显示函数
    JSR		L_A_HexToHexD
L_Clr_lcd_Prog_Normal_Timer:
	PHA
	AND		#$0F
    LDX     #lcd_d5
    JSR		L_Dis_8Bit_DigitDot_Prog
	LDX		#lcd_d6
L_Display_lcd_Prog_Normal_1:
	PLA
	JSR		L_ROR_4Bit_Prog
	BEQ		L_Display_lcd_Prog_Normal_Hr_1
	JMP		L_Dis_8Bit_DigitDot_Prog
L_Display_lcd_Prog_Normal_Hr_1:
	LDA		#10
	JMP		L_Dis_8Bit_DigitDot_Prog
;=======================================
L_Display_lcd_Prog_Normal_Day:;显示日期的lcd_7，lcd4=8
    JSR		L_A_HexToHexD
	PHA
	AND		#$0F
    LDX     #lcd_d7
    JSR		L_Dis_8Bit_DigitDot_Prog
	LDX		#lcd_d8
	BRA		L_Display_lcd_Prog_Normal_1
;===============================================  
L_Clr_Day_Prog:
    LDA		#AAH
    BRA     L_Clr_lcd_Prog_Normal_ms  
L_Display_lcd_Prog_Normal_ms:;显示秒数的lcd_7，lcd8
    JSR		L_A_HexToHexD
L_Clr_lcd_Prog_Normal_ms:
	PHA
	AND		#$0F
    LDX     #lcd_d7
    JSR		L_Dis_8Bit_DigitDot_Prog
	LDX		#lcd_d8
	BRA		L_Display_lcd_Prog_Normal
;=================================
L_Clr_Month_Prog:
    LDA		#0AH
    BRA     L_Clr_lcd_Prog_Normal_Month
L_Display_lcd_Prog_Normal_Month:;显示秒数的lcd_5，lcd6
    JSR		L_A_HexToHexD
L_Clr_lcd_Prog_Normal_Month:
	PHA
	AND		#$0F
    LDX     #lcd_d9
    JSR		L_Dis_8Bit_DigitDot_Prog
	LDX		#lcd_d10
    PLA
    JSR		L_ROR_4Bit_Prog
	BEQ		L_Clr_lcd_Prog_Month
	JSR     F_DispSymbol
    RTS	
L_Clr_lcd_Prog_Month:
	JMP		F_ClrpSymbol
;====================================
L_Clr_Sec_Prog:
    LDA		#AAH
	BRA		L_Clr_lcd_Prog_Normal_Sec
L_Display_lcd_Prog_Normal_Sec:;显示秒数的lcd_1，lcd2
    JSR		L_A_HexToHexD
L_Clr_lcd_Prog_Normal_Sec:
	PHA
	AND		#$0F
    LDX     #lcd_d1
    JSR		L_Dis_8Bit_DigitDot_Prog
	LDX		#lcd_d2
L_Display_lcd_Prog_Normal:
	PLA
	JSR		L_ROR_4Bit_Prog
	JMP		L_Dis_8Bit_DigitDot_Prog	
;=======================================
L_Clr_Year_Prog:
    JSR		L_Clr_Hr_Prog
L_Clr_Min_Prog:
    LDA		#AAH
    BRA     L_Clr_lcd_Prog_Normal_Min
L_Display_lcd_Prog_Normal_Min:;显示秒数的lcd_3，lcd4
    JSR		L_A_HexToHexD
L_Clr_lcd_Prog_Normal_Min:
	PHA
	AND		#$0F
    LDX     #lcd_d3
    JSR		L_Dis_8Bit_DigitDot_Prog
	LDX		#lcd_d4
	BRA		L_Display_lcd_Prog_Normal    


