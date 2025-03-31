L_Scankey_usually_Prog:   
	JSR		L_Judgement_Scankey_Prog;调整按键输入输出模式
	JSR		L_ScanKey_Delay_Prog
	LDA		#0
	STA		P_Scankey_value_Temporary
	LDA		P_PA
	AND		#D_PA_Press
	CMP		#D_PA_Press
	BNE		L_Scankey_usually_Prog_Countine;不相等跳转
	RTS
	
L_Scankey_usually_Prog_Countine:
	STA		P_Temp
	CMP		#D_PA2_Press
	BEQ		L_Scankey_usually_Prog_Countine_PA2
	CMP		#D_PA3_Press
	BEQ		L_Scankey_usually_Prog_Countine_PA3
	CMP		#D_PA4_Press
	BEQ		L_Scankey_usually_Prog_Countine_PA4
	CMP		#D_PA5_Press
	BEQ		L_Scankey_usually_Prog_Countine_PA5
	CMP		#D_PA6_Press
	BEQ		L_Scankey_usually_Prog_Countine_PA6
L_Scankey_Effictive_Prog:	
	SMB5	Sys_Flag_A
	LDA		#0
	STA		P_Scankey_value_Temporary
	RTS

L_Scankey_usually_Prog_Countine_PA3:
	LDA		#20
	STA		P_Scankey_value_Temporary
	JSR		L_PA_Intput_Low_Prog

	JSR		L_PC0_Output_High_Prog
	JSR		L_ScanKey_Delay_Prog
	LDA		P_PA
	AND		#D_PA_Press
	STA		P_Temp+3

	JSR		L_PC1_Output_High_Prog
	JSR		L_ScanKey_Delay_Prog
	LDA		P_PA
	AND		#D_PA_Press
	STA		P_Temp+4

	JSR		L_Scankey_Effictive_Init;PA口输入下拉,PC口输出低

	LDA		P_Temp+3
	BNE		L_Scankey_usually_Prog_Countine_PA3_PC0
	LDA		P_Temp+4
	BEQ		L_Scankey_usually_Prog_Countine_PA3_RTS
	LDA		#22
	STA		P_Scankey_value_Temporary
	RTS
	

L_Scankey_usually_Prog_Countine_PA3_PC0:
	LDA		P_Temp+4
	BNE		L_Scankey_usually_Prog_Countine_PA3_RTS
	LDA		#21
	STA		P_Scankey_value_Temporary
	RTS

L_Scankey_usually_Prog_Countine_PA3_RTS:
	JMP		L_Scankey_Effictive_Prog

L_Scankey_usually_Prog_Countine_PA2:
	LDA		#0
	STA		P_Scankey_value_Temporary
	BRA		L_Scankey_usually_Prog_Countine_1

L_Scankey_usually_Prog_Countine_PA4:
	LDA		#5
	STA		P_Scankey_value_Temporary
	BRA		L_Scankey_usually_Prog_Countine_1
L_Scankey_usually_Prog_Countine_PA5:
	LDA		#10
	STA		P_Scankey_value_Temporary
	BRA		L_Scankey_usually_Prog_Countine_1
L_Scankey_usually_Prog_Countine_PA6:
	LDA		#15
	STA		P_Scankey_value_Temporary

L_Scankey_usually_Prog_Countine_1:

	JSR		L_PA_Intput_Low_Prog

	JSR		L_PC0_Output_High_Prog
	JSR		L_ScanKey_Delay_Prog
	LDA		P_PA
	AND		#D_PA_Press
	STA		P_Temp+3

	JSR		L_PC1_Output_High_Prog
	JSR		L_ScanKey_Delay_Prog
	LDA		P_PA
	AND		#D_PA_Press
	STA		P_Temp+4

	JSR		L_PC2_Output_High_Prog
	JSR		L_ScanKey_Delay_Prog
	LDA		P_PA
	AND		#D_PA_Press
	STA		P_Temp+5

	JSR		L_PC3_Output_High_Prog
	JSR		L_ScanKey_Delay_Prog
	LDA		P_PA
	AND		#D_PA_Press
	STA		P_Temp+6

	JSR		L_Scankey_Effictive_Init;PA口输入下拉,PC口输出低

	LDA		P_Temp+3
	BNE		L_Scankey_usually_Prog_Countine_PC0
	LDA		P_Temp+4
	BNE		L_Scankey_usually_Prog_Countine_PC1
	LDA		P_Temp+5
	BNE		L_Scankey_usually_Prog_Countine_PC2
	LDA		P_Temp+6
	BNE		L_Scankey_usually_Prog_Countine_PC3
	JMP		L_Scankey_Effictive_Prog





L_Scankey_usually_Prog_Countine_PC0:
	LDA		#1
	STA		P_Temp
	LDA		P_Temp+4
	ORA		P_Temp+5
	ORA		P_Temp+6
	BEQ		L_Scankey_usually_Prog_Countine_RTS
	JMP		L_Scankey_Effictive_Prog
	
L_Scankey_usually_Prog_Countine_PC1:
	LDA		#2
	STA		P_Temp
	LDA		P_Temp+5
	ORA		P_Temp+6
	BEQ		L_Scankey_usually_Prog_Countine_RTS
	JMP		L_Scankey_Effictive_Prog


L_Scankey_usually_Prog_Countine_PC2:
	LDA		#3
	STA		P_Temp
	LDA		P_Temp+6
	BEQ		L_Scankey_usually_Prog_Countine_RTS
	JMP		L_Scankey_Effictive_Prog

L_Scankey_usually_Prog_Countine_PC3:
	LDA		#4
	STA		P_Temp

L_Scankey_usually_Prog_Countine_RTS:
	CLC
	LDA		P_Temp
	ADC		P_Scankey_value_Temporary
	STA		P_Scankey_value_Temporary
	RTS

