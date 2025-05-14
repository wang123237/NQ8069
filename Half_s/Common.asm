; L_Set_Mode_Auto_Exit:
; 	BBR3	Sys_Flag_A,L_Set_Mode_Auto_Exit_OUT
; 	LDA		Sys_Flag_A
; 	AND		#14H
; 	BNE		L_Set_Mode_Auto_Exit_OUT;长按和快加时不进行设置
; 	CLC
; 	LDA		R_Set_Mode_Exit_Time
; 	ADC		#1
; 	STA		R_Set_Mode_Exit_Time
; 	CMP		#D_Set_Mode_Exit_Time
; 	BCS		L_Set_Mode_Auto_Exit_1
; 	BEQ		L_Set_Mode_Auto_Exit_1
; 	RTS
; L_Set_Mode_Auto_Exit_1:
; 	RMB3	Sys_Flag_A
; 	LDA		#0
; 	STA		R_Set_Mode_Exit_Time
; 	STA		R_Mode_Set
; 	JSR		L_Display_Prog
L_Set_Mode_Auto_Exit_OUT:
	RTS
;===========================================
L_Auto_To_Clock_Mode_Prog:
	LDA		R_Mode
	BEQ		L_Auto_To_Clock_Mode_Prog_Time
	CMP		#3
	BNE		L_Auto_To_Clock_Mode_Prog_1
	RTS
L_Auto_To_Clock_Mode_Prog_1:
	LDA		Time_To_Clock_Mode
	ADC		#1
	STA		Time_To_Clock_Mode
	CMP		#D_Time_To_Clock_Mode
	BCC		L_Set_Mode_Auto_Exit_OUT
	LDA		#0
	STA		Time_To_Clock_Mode
	STA		R_Mode
	RMB3	Sys_Flag_A
	JSR		L_Clr_All_DisRam_Prog
	JSR		L_Display_Prog
	RTS
L_Auto_To_Clock_Mode_Prog_Time:
	BBR3	Sys_Flag_A,L_Set_Mode_Auto_Exit_OUT
	LDA		R_Set_Mode_Exit_Time
	CMP		#6
	BCC		L_Auto_To_Clock_Mode_Prog_Time_RTS
	RMB3	Sys_Flag_A
	JSR		L_Clr_All_DisRam_Prog
	JSR		L_Display_Prog
	RTS
L_Auto_To_Clock_Mode_Prog_Time_RTS:
	CLC
	ADC		#1
	STA		R_Set_Mode_Exit_Time
	RTS