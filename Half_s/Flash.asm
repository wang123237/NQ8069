L_SysFlash_Prog:
	JSR		L_SysFlash_Set_Mode_Prog
	JSR		L_SysFlash_Alm_Symbol_Prog
	JSR		L_SysFlash_Snz_Symbol_Prog
	RTS



L_SysFlash_Alm_Symbol_Prog:
	BBR4	Sys_Flag_C,L_SysFlash_Prog_OUT
	JMP		L_Dis_lcd_Alm_Prog
L_SysFlash_Snz_Symbol_Prog:	
	BBR7	Sys_Flag_C,L_SysFlash_Prog_OUT
	BBR4	Sys_Flag_C,L_SysFlash_Prog_4
	LDA		R_Snz_Frequency
	BEQ		L_SysFlash_Prog_4
	JMP		L_Dis_lcd_Snz_Prog
L_SysFlash_Prog_4:
	JMP		L_Clr_lcd_Snz_Prog
;=======================================


L_Clr_Alarm_Prog_set:;alm和snz的闪烁速度
	BBR4	Sys_Flag_C,L_SysFlash_Prog_OUT
	LDA		R_Alarm_Ms
	CMP		#25
	BNE		L_Clr_Alarm_Prog_set_2
L_Clr_Alarm_Prog_set_1:
	JSR		L_Clr_lcd_Alm_Prog
	LDA		R_Snz_Frequency
	BEQ		L_SysFlash_Prog_OUT	;当最后一次贪睡时，Snz标志与秒的闪烁时间一致
	JSR		L_Clr_lcd_Snz_Prog
	
L_SysFlash_Prog_OUT:
	RTS
L_Clr_Alarm_Prog_set_2:
	CMP		#75
	BNE		L_SysFlash_Prog_OUT
	LDA		#0
	STA		R_Alarm_Ms
	BRA		L_Clr_Alarm_Prog_set_1
;===============================================
L_SysFlash_Set_Mode_Prog:;设置模式时闪烁，快加不闪烁
	BBR3	Sys_Flag_A,L_SysFlash_Prog_OUT
	BBS4	Sys_Flag_A,L_SysFlash_Prog_OUT
	LDA		R_Mode_Time_Set
	CLD
	CLC
	ROL
	TAX
	LDA		R_Mode_Time
	BEQ		L_Clr_Time_Normal_Prog
	CMP		#1
	BEQ		L_Clr_Alarm_Normal_Prog
	CMP		#2
	BEQ		L_Clr_Positive_Timer_Normal_Prog
	CMP		#3
	BEQ		L_Clr_Another_Time_Normal_Prog
	CMP		#4
	BCS		L_Clr_Destive_Timer_Normal_Prog
	RTS

L_Clr_Time_Normal_Prog:
	LDA		Table_Clr_2+1,X
	PHA
	LDA		Table_Clr_2,X
	PHA
	RTS

L_Clr_Alarm_Normal_Prog:
	LDA		Table_Clr_3+1,X
	PHA
	LDA		Table_Clr_3,X
	PHA
L_Clr_Positive_Timer_Normal_Prog:
	RTS

L_Clr_Another_Time_Normal_Prog:
	LDA		Table_Clr_4+1,X
	PHA
	LDA		Table_Clr_4,X
	PHA
	RTS

L_Clr_Destive_Timer_Normal_Prog:
	LDA		Table_Clr_5+1,X
	PHA
	LDA		Table_Clr_5,X
	PHA
	RTS


Table_Clr_2:
	DW		L_Clr_Sec_Prog-1

Table_Clr_4:
Table_Clr_5:	
	DW		L_Clr_Hr_Prog-1
	DW		L_Clr_Min_Prog-1
	DW		L_Clr_Month_Prog-1
	DW		L_Clr_Day_Prog-1
	

Table_Clr_3:
	DW		L_Clr_Hr_Prog-1
	DW		L_Clr_Min_Prog-1
	DW		L_Clr_Month_Prog-1
	DW		L_Clr_Day_Prog-1


	