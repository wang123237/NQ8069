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
	STA		R_Mode_Time_Set
	JSR		L_Display_Prog
L_Set_Mode_Auto_Exit_OUT:
	RTS
;========================================
L_Control_Light_Prog:
	LDA		#D_Close_Light_Time
	STA		R_Close_Light_Time
	PB2_PB2_COMS
	LDA		#04H
	STA		P_PB
	SMB5	Sys_Flag_A
	RTS
L_Control_Light_Auto_Exit_Prog:
	
	LDA		R_Close_Light_Time
	BEQ		L_Set_Mode_Auto_Exit_OUT
	DEC		R_Close_Light_Time
	BNE		L_Set_Mode_Auto_Exit_OUT
	PB2_PB2_NOMS
	LDA		#0
	STA		P_PB
	RTS
; ;===============================================
; ;按键全显
; ;===============================================
; L_Control_All_Dis_Prog:
; 	JSR		L_Scankey_usually_Prog
; 	LDA		P_Scankey_value_Temporary
; 	BEQ		L_Control_All_Dis_Prog_OUT
; 	JSR		L_Dis_All_DisRam_Prog
; 	SMB6	Sys_Flag_A
; 	LDA		#0
; 	STA		R_Mode_Time
; 	RTS


; L_Control_All_Dis_Prog_OUT:	
; 	SMB5	Sys_Flag_A
; 	RMB6	Sys_Flag_A
; 	LDA		#D_Close_All_Dis
; 	STA		R_Close_All_Dis
; 	RTS
;================================================
;自动退出全显模式
;================================================
L_Control_All_Dis_Auto_Exit_Prog:
	BBS6	Sys_Flag_A,L_Set_Mode_Auto_Exit_OUT
	LDA		R_Close_All_Dis
	BEQ		L_Set_Mode_Auto_Exit_OUT
	DEC		R_Close_All_Dis
	LDA		R_Close_All_Dis
	BNE		L_Set_Mode_Auto_Exit_OUT
	JSR		L_Clr_All_DisRam_Prog
	JSR		L_Beep_1s
	JSR		L_Display_Prog
	RTS