;======================================================================
;非设置模式下吗,任何模式Mode键按下触发，更改显示模式,计算器模式下，非0情况下清零
;如果按键则跳转回时间模式
;======================================================================
L_Scankey_Mode_Press_Prog:
	BBS7	Sys_Flag_A,L_Scankey_Mode_Press_Prog_TO_Clock_Mode
	LDA		R_Mode
	CMP		#1
	BNE		
	JSR		L_Clr_All_DisRam_Prog
	RMB0	Sys_Flag_C
	RMB5	Sys_Flag_D
	LDA		R_Mode
	CMP		#4
	BCS		L_Scankey_Mode_Press_Prog_Clr
	INC		R_Mode
	RMB0	Sys_Flag_B
	RMB5	Sys_Flag_D
L_Scankey_Mode_Press_Prog_1:	
	JMP		L_Display_Prog
L_Scankey_Mode_Press_Prog_Clr:
	LDA		#0
	STA		R_Mode
	BRA		L_Scankey_Mode_Press_Prog_1

L_Scankey_Mode_Press_Prog_TO_Clock_Mode:
	LDA		R_Mode
	CMP		#1
	BEQ		
	LDA		#0
	STA		R_Mode
	JSR		L_Dis_All_DisRam_Prog
	JSR		L_Display_Time_Prog
	RTS
L_Scankey_Mode_Press_Prog_Calculator:
	LDA		BUF1
	ORA		BUF1+1
	ORA		BUF1+2
	ORA		BUF1+3
	ORA		BUF1+4
	ORA		BUF1+5
	BNE		L_Scankey_Mode_Press_Prog_Calculator_RTS

L_Scankey_Mode_Press_Prog_Calculator_RTS:
	LDX		#(BUF1+1-RAM)
	JSR		L_Clear_BUF_Prog
	JSR		L_Display_Calculator_Prog
	RTS
;======================================================================
;非设置模式下吗,时钟模式按下/号键，显示日期
;======================================================================
L_Clock_First_Press_Prog:
	LDA		P_Scankey_value
	CMP		#D_Date_Press
	BNE		L_Clock_First_Press_Prog_OUT
	JSR		L_Display_Time_Date_Prog
	SMB6	Sys_Flag_A
L_Clock_First_Press_Prog_OUT:
	RTS
;======================================================================
;非设置模式下吗,闹钟模式，短按ST/SP键切换闹钟界面和整点报时界面，无按键音
;短按RESET，在整点报时界面，开启或关闭整点报时，按下触发
;在闹钟界面,按下触发闹铃模式的切换，关闭，普通和贪睡
;======================================================================
L_Alarm_First_Press_Prog:
	LDA		P_Scankey_value
	CMP		#D_Alm_Press
	BEQ		L_Alarm_First_Press_Prog_Alm_Press
	CMP		#D_Sig_Press
	BEQ		L_Alarm_First_Press_Prog_Sig_Press
	CMP		#D_Beep_Test_Press
	BEQ		L_Alarm_First_Press_Prog_Beep_Test_Press
	RTS



L_Alarm_First_Press_Prog_Alm_Press:
	RMB7	Sys_Flag_C
	LDA		#0
	STA		R_Snz_Time
	STA		R_Snz_Frequency;进入闹钟时间的设置会清除贪睡
	LDA		R_Alarm_Mode
	CMP		#2
	BCS		L_Alarm_First_Reset_Press_Prog_Alarm_Prog_Clr
	INC		R_Alarm_Mode
	JMP		L_Dis_Alm_Snz_Symbol_Prog
L_Alarm_First_Reset_Press_Prog_Alarm_Prog_Clr:
	LDA		#0
	STA		R_Alarm_Mode
	JMP		L_Clr_Alm_Snz_Symbol_Prog
;======================================================
L_Alarm_First_Press_Prog_Sig_Press:	

	BBS1	Sys_Flag_C,L_Alarm_First_Reset_Press_Prog_Every_Hour_Mode_Close
	SMB1	Sys_Flag_C
	JMP		L_Dis_lcd_Sig_Prog
L_Alarm_First_Reset_Press_Prog_Every_Hour_Mode_Close:
	RMB1	Sys_Flag_C
	JMP		L_Clr_lcd_Sig_Prog
;------------------------------------------
L_Alarm_First_Press_Prog_Beep_Test_Press:
	SMB6	Sys_Flag_A
	LDA		#2
	STA		R_Voice_Unit
	RTS
;======================================================================
;非设置模式下吗,第二时间模式，长按RESET，进入设置模式
;======================================================================
L_Clock_Twice_First_Press_Prog:
	RTS
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
	SMB6	Sys_Flag_A
	JSR		L_Display_Positive_Timer_Hr_Prog
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
L_Positive_Timer_Midway_Measurement_1:
	JMP		L_Display_Prog
L_Positive_Timer_Midway_Measurement:
	BBS5	Sys_Flag_D,L_Positive_Timer_Midway_Measurement_2
	SMB5	Sys_Flag_D
	BRA		L_Positive_Timer_Midway_Measurement_1
L_Positive_Timer_Midway_Measurement_2:
	RMB5	Sys_Flag_D
	BRA		L_Positive_Timer_Midway_Measurement_1