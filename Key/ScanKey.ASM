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
	JSR		L_Scankey_INIT
	RTS
L_Scankey_Prog_Ineffective:
	LDA		#10101001B
	AND		Sys_Flag_A
	STA		Sys_Flag_A
	JSR		L_Scankey_usually_Prog
	LDA		P_Scankey_value_Temporary
	BNE		L_END_LCD_IRQ_WorkProg;如果为0则执行空键程序
	JSR		L_Scankey_INIT
	RMB5	Sys_Flag_A;清空无效标志位
	RTS

;====================================================
L_Scankey_Prog:
	BBS1	Sys_Flag_A,L_Scankey_Prog_First_TO;首次扫描判断
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


L_Scankey_Prog_First_TO:
	JMP		L_Scankey_Prog_First