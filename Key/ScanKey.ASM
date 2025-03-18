;==================================================
L_LCD_IRQ_WorkProg:;
	BBR0	Sys_Flag_A,L_END_LCD_IRQ_WorkProg;32hz扫键
	RMB0	Sys_Flag_A
	JSR		L_control_Beep_prog
	LDA		R_Reset_Time
	BNE		L_END_LCD_IRQ_WorkProg
	JSR		L_Scankey_Prog
L_END_LCD_IRQ_WorkProg:
    RTS	
; ==============================================
L_ScanKey_Null_Prog:;如果编码器没有开启退出并且扫描到空键，停止按键扫描	
	LDA		R_Voice_Unit
	BNE		L_END_LCD_IRQ_WorkProg
	DIS_LCD_IRQ
	EN_PA_IRQ
	JSR		L_PA257_Input_Low
	RTS
L_Scankey_Prog_Ineffective:
	LDA		#10101001B
	AND		Sys_Flag_A
	STA		Sys_Flag_A
	JSR		L_Scankey_usually_Prog
	LDA		P_Scankey_value_Temporary
	BNE		L_END_LCD_IRQ_WorkProg;如果为0则执行空键程序
	JSR		L_PA257_Input_Low
	RMB5	Sys_Flag_A;清空无效标志位
	RTS
L_Control_All_Dis_Prog_JMP:
	JMP		L_Control_All_Dis_Prog
;====================================================
L_Scankey_Prog:
	BBS1	Sys_Flag_A,L_Scankey_Prog_First;首次扫描判断
	BBS6	Sys_Flag_A,L_Control_All_Dis_Prog_JMP
	BBS5	Sys_Flag_A,L_Scankey_Prog_Ineffective
	BBS4	Sys_Flag_A,L_Scankey_Prog_Fast_Plus_TO;快加情况
	
	BBR2	Sys_Flag_A,L_ScanKey_Null_Prog;没有按键扫描标志
	JSR		L_Scankey_usually_Prog
	LDA		P_Scankey_value_Temporary
	CMP		P_Scankey_value
	BNE		L_Scankey_Prog_Short_Press_TO
	
	LDA		R_Scankey_Time
	CMP		#D_Rscankey_TWO_Sec
	BCS		L_Scankey_Prog_Long_Press_TO
	INC		R_Scankey_Time
	RTS
L_Scankey_Prog_Long_Press_TO:
	JMP		L_Scankey_Prog_Long_Press
L_Scankey_Prog_Short_Press_TO:
	JMP		L_Scankey_Prog_Short_Press
L_Scankey_Prog_Fast_Plus_TO:
	JMP		L_Scankey_Prog_Fast_Plus
L_Scankey_Short_ST_SP_Press_Prog_Alarm_TO:
	JMP		L_Scankey_Short_ST_SP_Press_Prog_Alarm	
L_Scankey_Prog_First:
	LDA		#11001001B
	AND		Sys_Flag_A
	STA		Sys_Flag_A;清空无效标志位
	LDA		P_Scankey_value_T_1
	CMP		#4
	BCS		L_Scankey_Prog_First_1
	JSR		L_Scankey_usually_Prog
	LDA		P_Scankey_value_Temporary
	BEQ		L_ScanKey_Null_Prog
	STA		P_Scankey_value
	SMB1	Sys_Flag_A
	INC		P_Scankey_value_T_1
	RTS
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
	RMB5	Sys_Flag_A

	LDA		P_Scankey_value
	CMP		#D_Light_Press
	BEQ		L_Control_Light_Prog_TO
;=======================
;-----按键无效键和按下触发的事件判定
	BBS3	Sys_Flag_A,L_Scankey_Set_Mode_First_Press_Prog_TO
	LDA		P_Scankey_value
	CMP		#D_Mode_Press
	BEQ		L_Scankey_Mode_Press_Prog_TO
	CMP		#D_Dis_All_1
	BEQ		L_Control_All_Dis_Prog_TO
	CMP		#D_Dis_All
	BEQ		L_Control_All_Dis_Prog_TO
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
;==============================================
L_Scankey_Set_Mode_First_Press_Prog_TO:
	JMP		L_Scankey_Set_Mode_First_Press_Prog
L_Control_Light_Prog_TO:
	JMP		L_Control_Light_Prog
L_Control_All_Dis_Prog_TO:
	JSR		L_Beep_1s
	JMP		L_Control_All_Dis_Prog
L_Scankey_Mode_Press_Prog_TO:
	JMP		L_Scankey_Mode_Press_Prog






	
L_Scankey_Set_Mode_Mode_First_Press_Prog_TO
	JMP		L_Scankey_Set_Mode_Mode_First_Press_Prog
L_Scankey_Set_Mode_Reset_First_Press_Prog_TO:
	JMP		L_Scankey_Set_Mode_Reset_First_Press_Prog
L_Scankey_Set_Mode_ST_SP_First_Press_Prog_TO:
	JMP		L_Scankey_Plus_Prog
;============================================
L_Scankey_Set_Mode_First_Press_Prog:
	LDA		P_Scankey_value
	CMP		#D_Mode_Press
	BEQ		L_Scankey_Set_Mode_Mode_First_Press_Prog_TO
	CMP		#D_Reset_Press
	BEQ		L_Scankey_Set_Mode_Reset_First_Press_Prog_TO
	CMP		#D_ST_SP_Press
	BEQ		L_Scankey_Set_Mode_ST_SP_First_Press_Prog_TO
	SMB5	Sys_Flag_A
	RTS

Table_Mode:
	DW		L_Clock_First_Press_Prog-1
	DW		L_Alarm_First_Press_Prog-1
	DW		L_Positive_Timer_First_Press_Prog-1
	DW		L_Clock_Twice_First_Press_Prog-1
	DW		L_Desitive_Timer_First_Press_Prog-1