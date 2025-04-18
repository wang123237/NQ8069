;======================================================================
;非设置模式下吗,任何模式Mode键按下触发，更改显示模式,计算器模式下，非0情况下清零
;如果按键则跳转回时间模式
;======================================================================
L_Scankey_Mode_Press_Prog:
	JSR		L_Beep_1s
	BBS7	Sys_Flag_A,L_Scankey_Mode_Press_Prog_TO_Clock_Mode
	JSR		L_Clr_All_DisRam_Prog
	LDA		R_Mode
	CMP		#4
	BCS		L_Scankey_Mode_Press_Prog_Clr
	INC		R_Mode
L_Scankey_Mode_Press_Prog_1:	
	JMP		L_Display_Prog
L_Scankey_Mode_Press_Prog_Clr:
	LDA		#0
	STA		R_Mode
	BRA		L_Scankey_Mode_Press_Prog_1

L_Scankey_Mode_Press_Prog_TO_Clock_Mode:
	RMB7	Sys_Flag_A
	LDA		R_Mode
	BEQ		L_Scankey_Mode_Press_Prog
	CMP		#1
	BEQ		L_Scankey_Mode_Press_Prog_Calculator
	LDA		#0
	STA		R_Mode
	JSR		L_Clr_All_DisRam_Prog
	JSR		L_Display_Prog
	RTS
L_Scankey_Mode_Press_Prog_Calculator:
	LDA		BUF1
	ORA		BUF1+1
	ORA		BUF1+2
	ORA		BUF1+3
	ORA		BUF1+4
	ORA		BUF1+5
	BNE		L_Scankey_Mode_Press_Prog_Calculator_RTS
	BRA		L_Scankey_Mode_Press_Prog_Clr

L_Scankey_Mode_Press_Prog_Calculator_RTS:
	LDX		#(BUF1+1-RAM)
	JSR		L_Clear_BUF_Prog
	JSR		L_Display_Calculator_Prog
	RTS

;======================================================================
;非设置模式下吗,闹钟模式，
;短按RESET，在整点报时界面，开启或关闭整点报时，按下触发
;在闹钟界面,按下触发闹铃模式的切换，关闭，普通和贪睡
;======================================================================


