;======================================================================
;非设置模式下吗,任何模式Mode键按下触发，更改显示模式
;======================================================================
L_Scankey_Mode_Press_Prog:
	JSR		L_Beep_1s
	SMB5	Sys_Flag_A
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

;======================================================================
;非设置模式下吗,时钟模式短按Reset无反应，长按进入时间设置模式
;短按ST/SP键切换12/24小时制，全部没有按键音,按下触发
;======================================================================
L_Clock_First_Press_Prog:
	LDA		P_Scankey_value
	CMP		#D_ST_SP_Press
	BEQ		L_Clock_First_ST_SP_Press_Prog
	CMP		#D_Reset_Press
	BEQ		L_Clock_First_Press_Prog_OUT
	SMB5	Sys_Flag_A
L_Clock_First_Press_Prog_OUT:
	RTS
L_Clock_First_ST_SP_Press_Prog:	
	SMB5	Sys_Flag_A
	BBS2	Sys_Flag_B,L_Clock_First_Press_PM_Prog
	SMB2	Sys_Flag_B
	JMP		L_Display_Time_Hr_Prog
L_Clock_First_Press_PM_Prog:
	RMB2	Sys_Flag_B
	JMP		L_Display_Time_Hr_Prog
;======================================================================
;非设置模式下吗,闹钟模式，短按ST/SP键切换闹钟界面和整点报时界面，无按键音
;短按RESET，在整点报时界面，开启或关闭整点报时，按下触发
;在闹钟界面,按下触发闹铃模式的切换，关闭，普通和贪睡
;======================================================================
L_Alarm_First_Press_Prog:
	LDA		P_Scankey_value
	CMP		#D_ST_SP_Press
	BEQ		L_Alarm_First_ST_SP_Press_Prog
	CMP		#D_Reset_Press
	BEQ		L_Alarm_First_Reset_Press_Prog
	SMB5	Sys_Flag_A
L_Alarm_First_ST_SP_Press_Prog:
	SMB5	Sys_Flag_A
	BBS0	Sys_Flag_C,L_Alarm_First_Press_Change_Prog;如果为1跳转整点报时切换为闹钟界面
	SMB0	Sys_Flag_C
	JMP		L_Display_Alarm_Hourly_Prog
L_Alarm_First_Press_Change_Prog:
	RMB0	Sys_Flag_C
	JMP		L_Display_Alarm_Prog
;------------------------------------
L_Alarm_First_Reset_Press_Prog:;
	JSR		L_Beep_1s
	BBS0	Sys_Flag_C,L_Alarm_First_Reset_Press_Prog_Every_Hour_Mode
	RMB7	Sys_Flag_C
	LDA		#0
	STA		R_Snz_Time
	STA		R_Snz_Frequency;清除贪睡的标志位
	LDA		R_Alarm_Mode
	CMP		#2
	BCS		L_Alarm_First_Reset_Press_Prog_Alarm_Prog_Clr
	INC		R_Alarm_Mode
	JMP		L_Dis_Alm_Snz_Symbol_Prog
L_Alarm_First_Reset_Press_Prog_Alarm_Prog_Clr:
	LDA		#0
	STA		R_Alarm_Mode
	JMP		L_Clr_Alm_Snz_Symbol_Prog
L_Alarm_First_Reset_Press_Prog_Every_Hour_Mode:
	SMB5	Sys_Flag_A
	BBS1	Sys_Flag_C,L_Alarm_First_Reset_Press_Prog_Every_Hour_Mode_Close
	SMB1	Sys_Flag_C
	JMP		L_Dis_lcd_Sig_Prog
L_Alarm_First_Reset_Press_Prog_Every_Hour_Mode_Close:
	RMB1	Sys_Flag_C
	JMP		L_Clr_lcd_Sig_Prog
;======================================================================
;非设置模式下吗,正计时模式，短按ST/SP键，开始或停止计时，存在按键音
;短按RESET，在计时途中，中途测量被设置，再次按下被取消
;======================================================================
L_Positive_Timer_First_Press_Prog:
	SMB5	Sys_Flag_A
	JSR		L_Beep_1s
	LDA		P_Scankey_value
	CMP		#D_ST_SP_Press
	BEQ		L_Positive_Timer_First_ST_SP_Press_Prog
	CMP		#D_Reset_Press
	BEQ		L_Positive_Timer_First_RESET_Press_Prog
	SMB5	Sys_Flag_A
	RTS
;--------------------------------------------------
L_Positive_Timer_First_ST_SP_Press_Prog:
	BBS0	Sys_Flag_D,L_Positive_Timer_First_SP_Press_Prog
	SMB0	Sys_Flag_D
	CLR_TMR2_IRQ_FLAG
	TMR2_ON
	EN_TMR2_IRQ
	; LDA		#0
	; STA		R_Timer_Ms
	JSR		L_Display_Prog;消除瞄点问题
L_Positive_Timer_First_ST_SP_Press_Prog_OUT:
	RTS
L_Positive_Timer_First_SP_Press_Prog:
	RMB0	Sys_Flag_D
	DIS_TMR2_IRQ
	TMR2_OFF
	BBS5	Sys_Flag_D,L_Positive_Timer_First_SP_Press_Prog_OUT
	JMP		L_Display_Prog
L_Positive_Timer_First_SP_Press_Prog_OUT:
	JSR		L_Dis_col_Prog
	JMP		L_Dis_lcd_Timer_Zheng_Prog
;----------------------------------------------------
L_Positive_Timer_First_RESET_Press_Prog:
	SMB5	Sys_Flag_A
	BBS0	Sys_Flag_D,L_Positive_Timer_Midway_Measurement
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
;======================================================================
;非设置模式下吗,第二时间模式，长按RESET，进入设置模式
;======================================================================
L_Clock_Twice_First_Press_Prog:
	LDA		P_Scankey_value
	CMP		#D_Reset_Press
	BEQ		L_Clock_Twice_First_Press_Prog_OUT
	SMB5	Sys_Flag_A
L_Clock_Twice_First_Press_Prog_OUT:
	RTS
;======================================================================
;非设置模式下吗,倒计时模式，长按RESET，进入设置模式，ST/SP开始或停止计时
;======================================================================
L_Desitive_Timer_First_Press_Prog:
	SMB5	Sys_Flag_A
	LDA		P_Scankey_value
	CMP		#D_Reset_Press
	BEQ		L_Desitive_Timer_First_Reset_Press_Prog
	CMP		#D_ST_SP_Press
	BEQ		L_Desitive_Timer_First_ST_SP_Press_Prog
	RTS
L_Desitive_Timer_First_ST_SP_Press_Prog:
	BBS1	Sys_Flag_D,L_Desitive_Timer_First_ST_SP_Press_Prog_ST
	SMB1	Sys_Flag_D
	BBS2	Sys_Flag_D,L_Clock_Twice_First_Press_Prog_OUT;是否进入过倒计时功能
	SMB2	Sys_Flag_D
	LDA		R_Timer_Hr_Countdown
	ORA		R_Timer_Min_Countdown
	BNE		L_Clock_Twice_First_Press_Prog_OUT
	LDA		#24
	STA		R_Timer_Hr_Countdown
	LDA		#0
	STA		R_Timer_Min_Countdown
	STA		R_Timer_Min_Countdown
	JMP		L_Display_Destive_Timer_Prog
L_Desitive_Timer_First_ST_SP_Press_Prog_ST:
	RMB1	Sys_Flag_D
	RTS
L_Desitive_Timer_First_Reset_Press_Prog:
	BBS1	Sys_Flag_D,L_Desitive_Timer_First_Reset_Press_Prog_1
	RMB2	Sys_Flag_D
	LDA		R_Timer_Hr_Backup
	STA		R_Timer_Hr_Countdown
	LDA		R_Timer_Min_Backup
	STA		R_Timer_Min_Countdown
	RMB5	Sys_Flag_A
	LDA		#0
	STA		R_Timer_Sec_Countdown
	JMP		L_Display_Prog
			
L_Desitive_Timer_First_Reset_Press_Prog_1:
	RTS