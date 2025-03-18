L_Display_Positive_Timer_Sec_Prog:
	LDA		R_Timer_Sec
	JMP		L_Display_lcd_Prog_Normal_Sec
;======================================
L_Display_Positive_Timer_Min_Prog:
	LDA		R_Timer_Min
	JMP		L_Display_lcd_Prog_Normal_Min
;=====================================
L_Display_Positive_Timer_Hr_Prog:
	LDA		R_Timer_Hr
	JMP		L_Display_lcd_Prog_Normal_Timer
;=====================================

L_Display_Positive_Timer_ST_Prog:
    LDA     #5
    JSR     L_Display_lcd_d13_Prog_Normal
    LDA     #15
    JSR     L_Display_lcd_d12_Prog_Normal
    JMP     L_Dis_lcd_12H_Prog
L_Display_Positive_Timer_SPL_Prog:
    LDA     #5
    JSR     L_Display_lcd_d13_Prog_Normal
    LDA     #21
    JSR     L_Display_lcd_d12_Prog_Normal
    LDA		#20
	JSR		L_Display_lcd_d11_Prog_Normal
	RTS

;上面是正计时显示函数

L_Display_Timer_Ms_Prog:
	; BBR0	Sys_Flag_D,L_Display_Positive_Timer_Ms_Prog_OUT
	LDA		R_Mode
	CMP		#2
	BNE		L_Display_Positive_Timer_Ms_Prog_OUT
	BBS5	Sys_Flag_D,L_Display_Positive_Timer_Ms_Prog_OUT
	LDA		R_Timer_Ms
	CMP		#100
	BCS		L_Display_Timer_Ms_Prog_1
	JSR		L_Display_lcd_Prog_Normal_ms
L_Display_Positive_Timer_Ms_Prog_OUT:
	RTS
L_Display_Timer_Ms_Prog_1:
	LDA		#0
	JSR		L_Display_lcd_Prog_Normal_ms
	RTS
;==========================================
L_Display_Destive_Timer_Sec_Prog:
	LDA		R_Timer_Sec_Countdown
	JMP		L_Display_lcd_Prog_Normal_Sec
;======================================
L_Display_Destive_Timer_Min_Prog:
	LDA		R_Timer_Min_Countdown
	JMP		L_Display_lcd_Prog_Normal_Min
;=====================================
L_Display_Destive_Timer_Hr_Prog:
	LDA		R_Timer_Hr_Countdown
	JMP		L_Display_lcd_Prog_Normal_Timer
	
L_Display_Destive_Timer_TR_Symbol_Prog:
    LDA     #15
    JSR     L_Display_lcd_d13_Prog_Normal
    LDA     #18
    JSR     L_Display_lcd_d12_Prog_Normal
	JSR		L_Dis_lcd_13H_Prog
    JMP     L_Dis_lcd_12H_Prog