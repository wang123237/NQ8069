;============================================================
L_control_Beep_prog:
	LDA		R_Voice_Unit;闹铃持续的次数时间
	BEQ		L_control_Beep_prog_out
	INC		R_Alarm_Clock_Open_Beep_Time
	LDA		R_Alarm_Clock_Open_Beep_Time
	CMP		#2
	BCS		L_Open_Beep_Prog
L_control_Beep_prog_out:
	RTS
	

; ;---------------------------------------------------------------------
L_Open_Beep_Prog:
	LDA		#0
	STA		R_Alarm_Clock_Open_Beep_Time
	BBR7	P_TMRCTRL,L_Open_Beep_Prog_1
	DEC		R_Voice_Unit
L_Close_Beep_Prog:	
	LDA		#$00  	
	STA		P_AUD
	RMB7	P_TMRCTRL	;关闭声音输出
	RMB0	P_SYSCLK ;Weak	
	PB3_PB3_NOMS
	; LDA		#0
	; STA		P_PB
	RTS
;--------------------------------------
L_Open_Beep_Prog_1:
	PB3_PWM
	LDA		#$80	
	STA		P_DIVC		
	SMB0	P_SYSCLK ;STRONG
	LDA		#$FF   
	STA		P_AUD
	SMB7	P_TMRCTRL	;打开声音输出
	RTS
;==========================================
L_Scankey_Short_ST_SP_Press_Prog_Alarm:
;====================================================
L_Scankey_Close_Alarm_Beep:
	LDA		Sys_Flag_C
	AND		#10h
	BEQ		L_Scankey_Close_Alarm_Beep_OUT
	JSR		L_Close_Beep_Prog
	LDA		#0
	STA		R_Voice_Unit
	STA		R_Close_Beep_Time
	RMB4	Sys_Flag_C
	LDA		R_Snz_Frequency
	BNE		L_Scankey_Close_Alarm_Beep_2
	LDA		#0
	STA		R_Snz_Time
	RMB7	Sys_Flag_C
L_Scankey_Close_Alarm_Beep_2:
	; JSR		L_Display_Normal_Prog
	BBS3	Sys_Flag_A,L_Scankey_Close_Alarm_Beep_OUT
	; JSR		L_Display_Set_Mode_Prog
L_Scankey_Close_Alarm_Beep_OUT:	
	RTS








L_Control_Beep_prog_Auto_Exit:;多久自动退出响闹,如果没有则按每秒给值
	LDA		Sys_Flag_C
	AND		#10H
	BEQ		L_Scankey_Close_Alarm_Beep_OUT
	DEC		R_Close_Beep_Time
	LDA		R_Close_Beep_Time;定时器
	BEQ		L_Scankey_Short_ST_SP_Press_Prog_Alarm
	EN_LCD_IRQ
	LDA		#2
	STA		R_Voice_Unit
	BBS4	Sys_Flag_D,L_Scankey_Close_Alarm_Beep_OUT
    RTS
