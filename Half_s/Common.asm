L_Set_Mode_Auto_Exit:
	BBR3	Sys_Flag_A,L_Set_Mode_Auto_Exit_OUT
	LDA		Sys_Flag_A
	AND		#14H
	BNE		L_Set_Mode_Auto_Exit_OUT;长按和快加时不进行设置
	INC		R_Set_Mode_Exit_Time
	LDA		R_Set_Mode_Exit_Time
	CMP		#D_Set_Mode_Exit_Time
	BCS		L_Set_Mode_Auto_Exit_1
	BEQ		L_Set_Mode_Auto_Exit_1
	RTS
L_Set_Mode_Auto_Exit_1:
	RMB3	Sys_Flag_A
	LDA		#0
	STA		R_Set_Mode_Exit_Time
	STA		R_Mode_Set
	JSR		L_Display_Prog
L_Set_Mode_Auto_Exit_OUT:
	RTS
