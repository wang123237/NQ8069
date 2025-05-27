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
;============================================



L_Update_Timer_Ms_Prog_Countine_Prog:
    TAX
    LDA     Table_Timer_Ms,X
    STA     R_Timer_Ms
    LDA     R_Mode
    CMP     #4
    BNE     L_Timer_Prog_OUT
    JSR     L_Display_Positive_Timer_Ms_Prog
    RTS
    
L_Update_Timer_Ms_Prog:
    BBR0    Sys_Flag_D,L_Timer_Prog_OUT
    BBR1    Sys_Flag_D,L_Timer_Prog_OUT
    RMB1    Sys_Flag_D
    ; INC     R_Timer_X
    LDA     R_Timer_X
    CMP     #32
    BCC     L_Update_Timer_Ms_Prog_Countine_Prog
    SBC     #32
    STA     R_Timer_X
    SMB7    Sys_Flag_D
    JSR     L_Update_Timer_Ms_Prog_Countine_Prog
    JSR     L_Positive_Timer
    LDA     R_Mode
    CMP     #4
    BNE     L_Timer_Prog_OUT
    JSR     L_Display_Postive_Timer_Normal_Prog
    RTS




L_Control_Timer_Beep_Prog:
    LDA     R_Mode
    CMP     #4
    BNE     L_Control_Timer_Beep_Prog_RTS
    LDA     R_Timer_Min
    JSR     L_A_HexToHexD
    AND     #0FH
    CMP     #9
    BNE     L_Control_Timer_Beep_Prog_RTS
    JSR     L_Beep_1s_Usually
L_Control_Timer_Beep_Prog_RTS:
    RTS
;================================================
L_Control_Positive_Timer_Prog:
	BBR0	Sys_Flag_D,L_Timer_Prog_OUT;正计时未开始
	BBS6	Sys_Flag_D,L_Control_Positive_Timer_Prog_RTS
	SMB6	Sys_Flag_D
	LDA		R_Timer_X
	STA		R_Timer_X_1
    LDA     R_Mode
    CMP     #4
    BNE     L_Control_Timer_Beep_Prog_RTS
	JSR		L_Display_Timer_Ms_Prog
	RTS
L_Control_Positive_Timer_Prog_RTS:
	LDA		R_Timer_X_1
	STA		R_Timer_X
    TAX     
    LDA     Table_Timer_Ms,X
    STA     R_Timer_Ms
    BBR7    Sys_Flag_D,L_Control_Positive_Timer_Prog_RTS_1
    RMB7    Sys_Flag_D
    LDA     R_Mode
    CMP     #4
    BNE     L_Control_Timer_Beep_Prog_RTS
	JSR		L_Display_Timer_Ms_Prog
	RTS
L_Control_Positive_Timer_Prog_RTS_1:
    JSR     L_Positive_Timer
    RTS



Table_Timer_Ms:;(32Hz的表)
    .DB     0
    .DB     3
    .DB     6
    .DB     9
    .DB     12
    .DB     16
    .DB     19
    .DB     22
    .DB     25
    .DB     28
    .DB     33
    .DB     36
    .DB     39
    .DB     42
    .DB     45
    .DB     49
    .DB     52
    .DB     55
    .DB     58
    .DB     61 
    .DB     66
    .DB     69
    .DB     72
    .DB     75
    .DB     78
    .DB     82
    .DB     85
    .DB     88
    .DB     91
    .DB     93
    .DB     96
    .DB     99






