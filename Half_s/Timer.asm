	L_Positive_Timer:
    BBR0    Sys_Flag_D,L_Timer_Prog_OUT
    JSR     L_Update_Timer_Sec_Prog
    BCC     L_Timer_Prog_OUT
    JSR     L_Update_Timer_Min_Prog
    BCC     L_Timer_Prog_OUT
    JSR     L_Update_Timer_Hr_Prog
    BCC     L_Timer_Prog_OUT
    LDA     #0
    STA     R_Timer_Hr
    STA     R_Timer_Min
    STA     R_Timer_Sec;记满重启计时
L_Timer_Prog_OUT:
    RTS    
L_Update_Timer_Sec_Prog:
    LDX     #(R_Timer_Sec-Time_Str_Addr)
    JMP     L_Inc_To_60_Prog
;----------------------------------------------------
L_Update_Timer_Min_Prog:
    LDX     #(R_Timer_Min-Time_Str_Addr)
    JMP     L_Inc_To_60_Prog
; ;----------------------------------------------------
L_Update_Timer_Hr_Prog:
    LDX     #(R_Timer_Hr-Time_Str_Addr)
    LDA     #23
    JMP     L_Inc_To_Any_Count_Prog
;----------------------------------------------------
;============================================================
L_Desitive_Timer:;倒计时
    BBS4    Sys_Flag_D,L_Timer_Prog_OUT
    BBR1    Sys_Flag_D,L_Timer_Prog_OUT
    JSR     L_Update_Timer_Sec_Prog_Desitive
    BCS     L_Timer_Prog_OUT
    JSR     L_Update_Timer_Min_Prog_Desitive
    BCS     L_Timer_Prog_OUT
    JSR     L_Update_Timer_Hr_Prog_Desitive
    BCS     L_Timer_Prog_OUT
    BBR4    Sys_Flag_C,L_Desitive_Timer_1
    JSR     L_Scankey_Close_Alarm_Beep;如果此时存在闹铃闹钟，则执行关闭闹铃程序
L_Desitive_Timer_1:
    LDA     #0
    LDX     #(R_Timer_Sec_Countdown-Time_Str_Addr)
    STA     Time_Addr,X
    INX
    STA     Time_Addr,X
    INX
    STA     Time_Addr,X
    SMB4    Sys_Flag_D
    LDA     #D_Beep_Open_Last_Time_Timer
    STA     R_Close_Beep_Time
    JSR     L_Control_Beep_prog_Auto_Exit
    RTS
;=======================================
L_Update_Timer_Hr_Prog_Desitive:
	LDX		#(R_Timer_Hr_Countdown-Time_Str_Addr)
	LDA		#24
	JMP		L_Dec_To_0_Prog
;----------------------------------------------------
L_Update_Timer_Min_Prog_Desitive:
	LDX		#(R_Timer_Min_Countdown-Time_Str_Addr)
	JMP		L_Dec_To_60_Prog
;----------------------------------------------------
L_Update_Timer_Sec_Prog_Desitive:
	LDX		#(R_Timer_Sec_Countdown-Time_Str_Addr)
    LDA     R_Timer_Hr_Countdown
    ORA     R_Timer_Min_Countdown
    BEQ     L_Update_Timer_Sec_Prog_Desitive_1   
	JMP     L_Dec_To_60_Prog
;----------------------------------------------------
L_Update_Timer_Sec_Prog_Desitive_1:
    LDA     #59
    JMP     L_Dec_To_1_Prog
;----------------------------------------------------
L_Update_Timer_Hr_Prog_Desitive_INC:
	LDX		#(R_Timer_Hr_Countdown-Time_Str_Addr)
	LDA		#23
	JMP		L_Inc_To_Any_Count_Prog
;----------------------------------------------------
L_Update_Timer_Min_Prog_Desitive_INC:
	LDX		#(R_Timer_Min_Countdown-Time_Str_Addr)
	JMP		L_Inc_To_60_Prog
