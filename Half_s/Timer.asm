; L_Timer_Prog:
    ; BBS4    Sys_Flag_D,L_Timer_Prog_OUT
    ; BBR2    Sys_Flag_D,L_Timer_Prog_OUT;是否开始计时,根据标志位判断定时器是否开启
    ; BBR0	Sys_Flag_D,L_Positive_Timer		;判断正计时,根据标志位判断正计时还是倒计时
	; BRA     L_Desitive_Timer		;判断倒计时	
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

L_Positive_Timer:
    JSR     L_Update_Timer_Sec_Prog
    BCC     L_Timer_Prog_OUT
    
    JSR     L_Control_Timer_Beep_Prog
    JSR     L_Update_Timer_Min_Prog
    BCC     L_Timer_Prog_OUT
    JSR     L_Update_Timer_Hr_Prog
    BCC     L_Timer_Prog_OUT
    LDA     #0
    STA     R_Timer_Hr
    STA     R_Timer_Min
    STA     R_Timer_Sec;记满重启计时
    STA     R_Timer_Ms
    STA     R_Timer_X
L_Timer_Prog_OUT:
    RTS    



L_Update_Timer_Ms_Prog_Countine_Prog:
    TAX
    LDA     Table_Timer_Ms,X
    STA     R_Timer_Ms
    LDA     R_Mode
    CMP     #4
    BNE     L_Timer_Prog_OUT
    JSR     L_Display_Postive_Timer_Normal_Prog
    RTS
    
L_Update_Timer_Ms_Prog:
    BBR0    Sys_Flag_D,L_Timer_Prog_OUT
    INC     R_Timer_X
    LDA     R_Timer_X
    CMP     #34
    BCC     L_Update_Timer_Ms_Prog_Countine_Prog
    LDA     R_Mode  
    CMP     #4
    BNE     L_Timer_Prog_OUT
    LDA     #0
    STA     R_Timer_X
    STA     R_Timer_Ms
    JSR     L_Display_Postive_Timer_Normal_Prog
    JSR     L_Positive_Timer
   
    JSR     L_Display_Postive_Timer_Normal_Prog
    RTS
L_Control_Positive_Timer_Prog:
	BBR0	Sys_Flag_D,L_Timer_Prog_OUT;正计时未开始
	BBS6	Sys_Flag_D,L_Control_Positive_Timer_Prog_RTS
	SMB6	Sys_Flag_D
	LDA		R_Timer_X
	STA		R_Timer_X_1
	JSR		L_Display_Postive_Timer_Normal_Prog
	RTS
L_Control_Positive_Timer_Prog_RTS:
	LDA		R_Timer_X_1
    CMP     R_Timer_X
    BCS     L_Control_Positive_Timer_Prog_RTS_1
	STA		R_Timer_X
    TAX     
    LDA     Table_Timer_Ms,X
    STA     R_Timer_Ms
	JSR		L_Display_Postive_Timer_Normal_Prog
	RTS
L_Control_Positive_Timer_Prog_RTS_1:
    STA     R_Timer_X
    TAX     
    LDA     Table_Timer_Ms,X
    STA     R_Timer_Ms
    JSR     L_Positive_Timer
    JSR     L_Display_Postive_Timer_Prog
    RTS




L_Control_Timer_Beep_Prog:
    LDA     R_Timer_Min
    JSR     L_A_HexDToHex
    AND     #0FH
    CMP     #9
    BNE     L_Control_Timer_Beep_Prog_RTS
    JSR     L_Beep_1s_Usually
L_Control_Timer_Beep_Prog_RTS:
    RTS

Table_Timer_Ms:
    .DB     0
    .DB     3
    .DB     6
    .DB     9
    .DB     12
    .DB     15
    .DB     18
    .DB     21
    .DB     24
    .DB     27
    .DB     30
    .DB     33
    .DB     36
    .DB     39
    .DB     42
    .DB     45
    .DB     48
    .DB     51
    .DB     54
    .DB     57
    .DB     60
    .DB     63
    .DB     66
    .DB     69
    .DB     72
    .DB     75
    .DB     78
    .DB     81
    .DB     84
    .DB     87
    .DB     90
    .DB     93
    .DB     96
    .DB     99








