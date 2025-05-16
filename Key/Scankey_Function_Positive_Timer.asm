;======================================================================
;非设置模式下吗,正计时模式，短按ST/SP键，开始或停止计时，存在按键音
;短按RESET，在计时途中，中途测量被设置，再次按下被取消
;======================================================================
L_Positive_Timer_First_Press_Prog:
	LDA		P_Scankey_value
	CMP		#D_ST_SP_Press
	BEQ		L_Positive_Timer_First_ST_SP_Press_Prog
	CMP		#D_Reset_Press
	BEQ		L_Positive_Timer_First_RESET_Press_Prog
	CMP		#D_ST_Hour_Press
	BEQ		L_Positive_Timer_First_Press_Prog_ST_Hour_Press
	RTS
;--------------------------------------------------
L_Positive_Timer_First_Press_Prog_ST_Hour_Press:
	JSR		L_Clr_All_8Bit_Prog
	JSR		L_Clr_col_Prog
	SMB6	Sys_Flag_A
    RMB5    Sys_Flag_A

    BBR5    Sys_Flag_D,L_Positive_Timer_First_Press_Prog_ST_Hour_Press_1
	JSR		L_Display_Positive_Timer_Hr_Prog_Measurement
	RTS
L_Positive_Timer_First_Press_Prog_ST_Hour_Press_1:
    JSR     L_Display_Positive_Timer_Hr_Prog
    RTS
L_Positive_Timer_First_ST_SP_Press_Prog:
	BBS0	Sys_Flag_D,L_Positive_Timer_First_SP_Press_Prog
	SMB0	Sys_Flag_D
	EN_LCD_IRQ
	JSR		L_Display_Prog;消除瞄点问题
L_Positive_Timer_First_ST_SP_Press_Prog_OUT:
	RTS
L_Positive_Timer_First_SP_Press_Prog:
	RMB0	Sys_Flag_D
	RMB6	Sys_Flag_D
	BBS5	Sys_Flag_D,L_Positive_Timer_First_SP_Press_Prog_OUT
	JMP		L_Display_Prog
L_Positive_Timer_First_SP_Press_Prog_OUT:
	JSR		L_Dis_col_Prog
	RTS
;----------------------------------------------------
L_Positive_Timer_First_RESET_Press_Prog:
	SMB5	Sys_Flag_A
	BBS0	Sys_Flag_D,L_Positive_Timer_Midway_Measurement;判断此时正计时是否运行
	BBS5	Sys_Flag_D,L_Positive_Timer_Midway_Measurement_2
	LDA		#0
	STA		R_Timer_Sec
	STA		R_Timer_Min
	STA		R_Timer_Hr
	STA		R_Timer_Ms
	STA		R_Timer_X_1
	STA		Sys_Flag_D
L_Positive_Timer_Midway_Measurement_1:
	JMP		L_Display_Prog
L_Positive_Timer_Midway_Measurement:
	BBS5	Sys_Flag_D,L_Positive_Timer_Midway_Measurement_2
	SMB5	Sys_Flag_D
    LDA     R_Timer_Hr
    STA     R_Timer_Hr_Measurement
    LDA     R_Timer_Min
    STA     R_Timer_Min_Measurement
    LDA     R_Timer_Sec
    STA     R_Timer_Sec_Measurement
    LDA     R_Timer_Ms
    STA     R_Timer_Ms_Measurement
	BRA		L_Positive_Timer_Midway_Measurement_1
L_Positive_Timer_Midway_Measurement_2:
	RMB5	Sys_Flag_D
	BRA		L_Positive_Timer_Midway_Measurement_1