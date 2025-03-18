L_Half_Second_Prog:
	BBR0 	Sys_Flag_B,L_END_Half_Second_Prog	;判断半秒标志
	RMB0 	Sys_Flag_B							;清楚半秒标志
	LDA		R_Reset_Time
	BNE		L_Reset_2s_Prog
	BBS1	Sys_Flag_B,L_1Second_Prog			;判断一秒标志
	SMB1	Sys_Flag_B							;设置1秒标志
	JSR		L_SysFlash_Prog						;闪烁程序	
L_END_Half_Second_Prog:
    RTS
;=================================================================
L_1Second_Prog:
    RMB1    Sys_Flag_B;清除1秒标志  
	JSR		L_Set_Mode_Auto_Exit
	JSR		L_Control_Light_Auto_Exit_Prog
	JSR		L_Control_Beep_prog_Auto_Exit
	JSR		L_Control_All_Dis_Auto_Exit_Prog
	
	JSR     L_Update_Time_Prog
	JSR		L_Update_Another_Time_Prog
	JSR		L_Alarm_Prog
    JSR		L_Positive_Timer
	JSR		L_Desitive_Timer
	JSR		L_Display_Normal_Prog
	RTS
;==============================================================
L_Reset_2s_Prog:;全显
	DEC		R_Reset_Time
	LDA		R_Reset_Time
	BNE		L_End_Reset_2s_Prog
	JSR		L_Clr_All_DisRam_Prog
	JSR		L_Display_Prog
	JSR		L_Beep_1s
	RTS
L_End_Reset_2s_Prog:
	JSR		L_Dis_All_DisRam_Prog
L_End_Reset_2s_Prog_OUT:
	RTS
