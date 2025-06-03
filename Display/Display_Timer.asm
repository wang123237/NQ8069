L_Display_Positive_Timer_Sec_Prog:
	LDA		R_Timer_Sec
	JMP		L_Display_lcd_Prog_Normal_Min
;======================================
L_Display_Positive_Timer_Min_Prog:
	LDA		R_Timer_Min
	JMP		L_Display_lcd_Prog_Normal_Timer
;=====================================
L_Display_Positive_Timer_Hr_Prog:
	LDA		R_Timer_Hr
	JMP		L_Display_lcd_Prog_Normal_Timer
;=====================================
L_Display_Timer_Ms_Prog:
L_Display_Positive_Timer_Ms_Prog:
	BBS5	Sys_Flag_D,L_Display_Timer_Ms_Prog_RTS
	BBS6	Sys_Flag_A,L_Display_Timer_Ms_Prog_RTS
	LDA		R_Timer_Ms
	
	JMP		L_Display_lcd_Prog_Normal_Sec

L_Display_Positive_Timer_ST_Prog:
    LDA     #5
    JSR     L_Display_lcd_d10_Prog_Normal
    LDA     #15
    JSR     L_Display_lcd_d9_Prog_Normal
    JSR     L_Dis_lcd_9H_Prog
L_Display_Timer_Ms_Prog_RTS:
	RTS
L_Display_Positive_Timer_LR_Prog:
    LDA     #20
    JSR     L_Display_lcd_d10_Prog_Normal
    LDA     #18
    JSR     L_Display_lcd_d9_Prog_Normal
    ; JSR     L_Dis_lcd_9H_Prog
	RTS


L_Display_Positive_Timer_Sec_Prog_Measurement:
	LDA		R_Timer_Sec_Measurement
	JMP		L_Display_lcd_Prog_Normal_Min
;======================================
L_Display_Positive_Timer_Min_Prog_Measurement:
	LDA		R_Timer_Min_Measurement
	JMP		L_Display_lcd_Prog_Normal_Timer
;=====================================
L_Display_Positive_Timer_Hr_Prog_Measurement:
	LDA		R_Timer_Hr_Measurement
	JMP		L_Display_lcd_Prog_Normal_Timer
;=====================================
L_Display_Timer_Ms_Prog_Measurement:
L_Display_Positive_Timer_Ms_Prog_Measurement:
	LDA		R_Timer_Ms_Measurement
	JMP		L_Display_lcd_Prog_Normal_Sec
; ;上面是正计时显示函数
; ;==========================================
; L_Display_Destive_Timer_Sec_Prog:
; 	LDA		R_Timer_Sec_Countdown
; 	JMP		L_Display_lcd_Prog_Normal_Sec
; ;======================================
; L_Display_Destive_Timer_Min_Prog:
; 	LDA		R_Timer_Min_Countdown
; 	JMP		L_Display_lcd_Prog_Normal_Min
; ;=====================================
; L_Display_Destive_Timer_Hr_Prog:
; 	LDA		R_Timer_Hr_Countdown
; 	JMP		L_Display_lcd_Prog_Normal_Timer
	
; L_Display_Destive_Timer_TR_Symbol_Prog:
;     LDA     #15
;     JSR     L_Display_lcd_d10_Prog_Normal
;     LDA     #18
;     JSR     L_Display_lcd_d9_Prog_Normal
; 	JSR		L_Dis_lcd_10H_Prog
;     JSR     L_Dis_lcd_9H_Prog
; 	RTS