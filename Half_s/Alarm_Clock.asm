L_Alarm_Prog:;闹钟判断的时间是贪睡闹钟时间，而正常闹钟时间作为显示闹钟时间
	LDA		R_Alarm_Mode
	BEQ		L_Alarm_Prog_OUT
	BBS4	Sys_Flag_C,L_Alarm_Prog_OUT

	LDA		R_Time_Sec
	BNE		L_Alarm_Prog_OUT
	LDA		R_Time_Hr
	CMP		R_Alarm_Clock_Hr
	BNE		L_Alarm_Prog_OUT
	LDA		R_Time_Min
	CMP		R_Alarm_Clock_Min
	BNE		L_Alarm_Prog_OUT

L_Alarm_Control_Prog:	
	LDA		R_Alarm_Mode
	CMP		#2
	BNE		L_Alarm_Control_Prog_2
	SMB7	Sys_Flag_C
	LDA		#D_Snz_Frequency
	STA		R_Snz_Frequency
	LDA		#D_Snz_Time
	STA		R_Snz_Time
L_Alarm_Control_Prog_2:
	BBR4	Sys_Flag_D,L_Alarm_Prog_1
	JSR		L_Scankey_Close_Timer_Beep
	
	
L_Alarm_Prog_1:
	SMB4	Sys_Flag_C
	LDA		#D_Beep_Open_Last_Time_Alarm
	STA		R_Close_Beep_Time
	JSR		L_Control_Beep_prog_Auto_Exit

	
L_Alarm_Prog_OUT:
	RTS
		












;============================================


L_Check_Alarm_Clock_MaxDay_Prog:;检查闹铃月份的设定的最大天数
	LDA		R_Alarm_Clock_Month
	BEQ		L_Check_Alarm_Clock_MaxDay_Prog_RTS
	DEC
	TAX
	JMP		L_Check_MaxDay_Prog_Alarm_clock_Prog
L_Check_Alarm_Clock_MaxDay_Prog_RTS:
	LDA		#31
	RTS

L_Judge_Alarm_Clock_MaxDay_Prog:
	JSR		L_Check_Alarm_Clock_MaxDay_Prog
	STA		P_Temp+5
	CMP		R_Alarm_Clock_Day
	BCS		L_Alarm_Prog_OUT
	LDA		P_Temp+5
	STA		R_Alarm_Clock_Day
	RTS


	

L_Scankey_Plus_Alarm_Clock_Prog_1:
    LDA     R_Mode_Set
	BEQ		L_Update_Alarm_Clock_Hr_Prog
    CMP     #1
    BEQ     L_Update_Alarm_Clock_Min_Prog
    CMP     #2
    BEQ     L_Update_Alarm_Clock_Month_Prog
    BRA     L_Update_Alarm_Clock_Day_Prog
;=========================================================================================================
L_Update_Alarm_Clock_Min_Prog:;闹钟时间分钟更新加
	LDX		#(R_Alarm_Clock_Min-Time_Str_Addr)
	JMP		L_Inc_To_60_Prog
;---------------------------
L_Update_Alarm_Clock_Hr_Prog:;闹钟时间小时更新加
	LDX		#(R_Alarm_Clock_Hr-Time_Str_Addr)
	LDA		#23
	JMP		L_Inc_To_Any_Count_Prog
;----------------------------------
L_Update_Alarm_Clock_Day_Prog:;闹钟时间天数更新加
	JSR		L_Check_Alarm_Clock_MaxDay_Prog
	LDX		#(R_Alarm_Clock_Day-Time_Str_Addr)
	JMP		L_Inc_To_Any_Count_Prog
;-------------------------------------
L_Update_Alarm_Clock_Month_Prog:;闹钟时间月更新加
	LDX		#(R_Alarm_Clock_Month-Time_Str_Addr)
	LDA		#12
	JMP		L_Inc_To_Any_Count_Prog    