L_Display_Set_Mode_Prog_TO:
	JMP		L_Display_Set_Mode_Prog
L_Display_Normal_Prog:
	BBS6	Sys_Flag_A,L_Display_Alarm_Normal_Prog
	LDA		R_Close_All_Dis
	BNE		L_Display_Alarm_Normal_Prog;当全显时不做要求
	JSR		L_Dis_Alm_Snz_Symbol_Prog
	BBS3	Sys_Flag_A,L_Display_Set_Mode_Prog_TO
	CLD
	LDA		R_Mode_Time
	CLC
	ROL
	TAX
	LDA		Table_Dis_2+1,X
	PHA
	LDA		Table_Dis_2,X
	PHA
	RTS
Table_Dis_2:
	DW		L_Display_Time_Normal_Prog-1
	DW		L_Display_Alarm_Normal_Prog-1
	DW		L_Display_Postive_Timer_Set_Mode_Prog-1;正计时的正常计时自动退出
	DW		L_Display_Another_Time_Normal_Prog-1
	DW		L_Display_Destive_Timer_Normal_Prog-1


L_Display_Time_Normal_Prog:
	JSR		L_Display_Time_Sec_Prog
	LDA		R_Time_Sec
	BNE		L_Display_Alarm_Normal_Prog_OUT
	JSR		L_Display_Time_Min_Prog
	LDA		R_Time_Min
	BNE		L_Display_Alarm_Normal_Prog_OUT
	JSR		L_Display_Time_Hr_Prog
	LDA		R_Time_Hr
	BNE		L_Display_Alarm_Normal_Prog_OUT
	JSR		L_Display_Time_Day_Prog	
	JSR		L_Display_Time_Month_Prog
	JSR		L_Clr_Time_Week_Prog
	JMP		L_Display_Time_Week_Prog

	
		
L_Display_Postive_Timer_Set_Mode_Prog:
L_Display_Alarm_Normal_Prog:
L_Display_Alarm_Normal_Prog_OUT:
	RTS	

L_Display_Destive_Timer_Normal_Prog:
	JSR		L_Display_Destive_Timer_Sec_Prog
	LDA		R_Timer_Sec_Countdown
	CMP		#59
	BNE		L_Display_Alarm_Normal_Prog_OUT
	JSR		L_Display_Destive_Timer_Min_Prog
	LDA		R_Timer_Min_Countdown
	CMP		#59
	BNE		L_Display_Alarm_Normal_Prog_OUT	
	JMP		L_Display_Destive_Timer_Hr_Prog

L_Display_Another_Time_Normal_Prog:
	JSR		L_Display_Time_Sec_Prog
	LDA		R_Time_Sec
	BNE		L_Display_Alarm_Normal_Prog_OUT
	JSR		L_Display_Another_Time_Min_Prog
	LDA		R_Time_Min_Another
	BNE		L_Display_Alarm_Normal_Prog_OUT
	JMP		L_Display_Another_Time_Hr_Prog
	




L_Display_Postive_Timer_Normal_Prog:
	BBR0	Sys_Flag_D,L_Display_Alarm_Normal_Prog;没有开始正计时是不显示
	BBS5	Sys_Flag_D,L_Display_Alarm_Normal_Prog;若有中途测量，不显示
	JSR		L_Display_Positive_Timer_Sec_Prog
	LDA		R_Timer_Sec
	BNE		L_Display_Alarm_Normal_Prog_OUT
	JSR		L_Display_Positive_Timer_Min_Prog
	LDA		R_Timer_Hr
	BNE		L_Display_Alarm_Normal_Prog_OUT
	JMP		L_Display_Positive_Timer_Hr_Prog

L_Display_Set_Mode_Prog:
	CLD
	LDA		R_Mode_Time
	CLC
	ROL
	TAX
	LDA		Table_Dis_3+1,X
	PHA
	LDA		Table_Dis_3,X
	PHA
	RTS

Table_Dis_3:
	DW		L_Display_Time_Set_Mode_Prog-1
	DW		L_Display_Alarm_Set_Mode_Prog-1
	DW		L_Display_Postive_Timer_Set_Mode_Prog-1
	DW		L_Display_Another_Time_Set_Mode_Prog-1
	DW		L_Display_Destive_Timer_Set_Mode_Prog-1

	
	
	
	
L_Display_Time_Year_Prog_TO:
	JSR		L_Clr_col_Prog
	JSR		L_Clr_lcd_24_Prog
	JSR		L_Clr_lcd_PM_Prog
	JSR		L_Clr_Sec_Prog
	JSR		L_Clr_col_Prog
	JMP		L_Display_Time_Year_Prog
L_Display_Time_Set_Mode_Prog:
	JSR		L_Display_Time_Month_Prog
	JSR		L_Display_Time_Day_Prog
	LDA		R_Mode_Time_Set
	CMP		#3
	BEQ		L_Display_Time_Year_Prog_TO
	JSR		L_Dis_col_Prog
	JMP		L_Display_Time_Prog_Normal_Prog




L_Display_Prog:
	JSR		L_Dis_Alm_Snz_Symbol_Prog
	JSR		L_Dis_sig_Prog
	JSR		L_Dis_col_Prog
	CLD
	LDA		R_Mode_Time
	CLC
	ROL
	TAX
	LDA		Table_Dis_1+1,X
	PHA
	LDA		Table_Dis_1,X
	PHA
L_Display_Prog_1:
	RTS
Table_Dis_1:
	DW		L_Display_Time_Prog-1
	DW		L_Display_Alarm_Prog-1
	DW		L_Display_Postive_Timer_Prog-1
	DW		L_Display_Another_Time_Prog-1
	DW		L_Display_Destive_Timer_Prog-1
L_Display_Time_Prog:
	JSR		L_Display_Time_Week_Prog
L_Display_Time_Prog_Normal_Prog:	
	JSR		L_Display_Time_Sec_Prog
	JSR		L_Display_Time_Min_Prog
	JSR		L_Display_Time_Hr_Prog
	RTS

L_Display_Alarm_Prog:
	JSR		L_Display_Alarm_Clock_AL_Symbol_Prog
L_Display_Alarm_Set_Mode_Prog:
	JSR		L_Display_Alarm_Clock_Hr_Prog
	JSR		L_Display_Alarm_Clock_Min_Prog
	RTS




L_Display_Postive_Timer_Prog:
	JSR		L_Display_Positive_Timer_Sec_Prog
	JSR		L_Display_Positive_Timer_Min_Prog
	JSR		L_Display_Positive_Timer_Hr_Prog
	JMP		L_Display_Positive_Timer_ST_Prog




L_Display_Destive_Timer_Prog:
	JSR		L_Display_Destive_Timer_TR_Symbol_Prog
L_Display_Destive_Timer_Set_Mode_Prog:
	JSR		L_Display_Destive_Timer_Sec_Prog
	JSR		L_Display_Destive_Timer_Min_Prog
	JSR		L_Display_Destive_Timer_Hr_Prog
	
	RTS
L_Display_Another_Time_Prog:
	JSR		L_Display_Another_Time_DT_Symbol_Prog
L_Display_Another_Time_Set_Mode_Prog:	
	JSR		L_Display_Time_Sec_Prog
	JSR		L_Display_Another_Time_Min_Prog
	JSR		L_Display_Another_Time_Hr_Prog
	
	RTS






