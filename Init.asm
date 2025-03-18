;------------------------------------------------------
L_Init_SystemRam_Prog:     ;初始化系统RAM的程序数据
	LDA		#4
	STA		R_Reset_Time
	LDA		#25
	STA		R_Time_Year
	LDA		#1
	STA		R_Time_Day
	STA		R_Time_Month
	JSR		L_Auto_Counter_Week
	RTS
;======================================================
L_Dis_All_DisRam_Prog:
	LDA		#$FF
	STA		P_Temp
L_All_DisRam:	
	LDX		#0	
L_Loop_DisplayRam:
	LDA		P_Temp
	STA		LCD_RamAddr,X
	INX	
	TXA
	CMP		#$23
	BCC		L_Loop_DisplayRam    ;C=0是跳转
	RTS
;----------------------------------------------------
L_Clr_All_DisRam_Prog:
	LDA		#0
	STA		P_Temp
	BRA		L_All_DisRam	

L_Scankey_INIT:
	LDA	#10101101B;
	; LDA		#11110101B
	STA		P_PA_IO;PA0输出,其余输入   
	LDA		#10101101B	
	STA		P_PA	;其他全部下拉
	LDA		#10101100B
	STA		P_PA_WAKE;	将PA做唤醒	
	SMB0	P_SYSCLK
	RTS



L_PA257_Input_Low:
	LDA		#10101101B	
	STA		P_PA	;其他全部下拉
	RTS
L_PA257_Input_High:
	LDA		#00000001B	
	STA		P_PA
	RTS