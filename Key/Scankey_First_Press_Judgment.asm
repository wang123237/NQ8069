L_Scankey_Prog_First:
	LDA		#10001000B
	AND		Sys_Flag_A
	STA		Sys_Flag_A;清空无效标志位
	LDA		P_Scankey_value_T_1;清空无效标志位
	CMP		#2
	BCS		L_Scankey_Prog_First_1
	JSR		L_Scankey_usually_Prog
	BBS5	Sys_Flag_A,L_Scankey_Prog_First_RTS
	LDA		P_Scankey_value_Temporary
	BEQ		L_ScanKey_Null_Prog_To
	STA		P_Scankey_value
	SMB1	Sys_Flag_A
	INC		P_Scankey_value_T_1
L_Scankey_Prog_First_RTS:
	RTS
L_ScanKey_Null_Prog_To:
	JMP		L_ScanKey_Null_Prog






L_Scankey_Prog_First_1:
	LDA		#0
	STA		P_Scankey_value_T_1
	JSR		L_Scankey_usually_Prog
	LDA		P_Scankey_value_Temporary
	CMP		P_Scankey_value
	BNE		L_Scankey_Prog_First_OUT
	LDA		#0
	STA		R_Close_Beep_Time
	STA		R_Voice_Unit
	STA		R_Set_Mode_Exit_Time
	STA		R_Alarm_Clock_Open_Beep_Time
	STA		R_Scankey_Time

	SMB5	Sys_Flag_A
	BBS4	Sys_Flag_D,L_Scankey_Short_ST_SP_Press_Prog_Alarm_TO
	BBS4	Sys_Flag_C,L_Scankey_Short_ST_SP_Press_Prog_Alarm_TO;闹铃判断
	SMB2	Sys_Flag_A
;=======================
;-----按键无效键和按下触发的事件判定
	; BBS3	Sys_Flag_A,L_Scankey_Set_Mode_First_Press_Prog_TO
	LDA		P_Scankey_value
	CMP		#D_Mode_Press
	BEQ		L_Scankey_Mode_Press_Prog_TO
	SMB7	Sys_Flag_A
	CMP		#5
	BCS		L_Scankey_Prog_First_OUT;手表模式下，数字键无效
	LDA		R_Mode
	CMP		#5
	BCS		L_Scankey_Prog_First_1_OUT
	CLD
	CLC
	ROL
	TAX
	LDA		Table_Mode+1,X
	PHA
	LDA		Table_Mode,X
	PHA	
	RTS








L_Scankey_Prog_First_1_OUT:
	LDA		#0
	STA		R_Mode
	JSR		L_Clr_All_DisRam_Prog
	JSR		L_Display_Prog
	
L_Scankey_Prog_First_OUT:
	SMB5	Sys_Flag_A
	RTS


Table_Mode:
	DW		L_Clock_First_Press_Prog-1
	DW		L_Calculator_Frist_Press_Prog-1
	DW		L_Alarm_First_Press_Prog-1
	DW		L_Positive_Timer_First_Press_Prog-1
	DW		L_Clock_Twice_First_Press_Prog-1