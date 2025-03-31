;==========================================
;设置模式下，按下mode键更换设置的情况
L_Scankey_Set_Mode_Mode_First_Press_Prog:
    SMB5    Sys_Flag_A
    LDA     R_Mode
    CMP     #2
    BEQ     L_Scankey_Set_Mode_Mode_First_Press_Prog_OUT
    TAX
    LDA     Table_Set_Mode,X
    STA     P_Temp
    LDA     R_Mode_Set
    CMP     P_Temp
    BCS     L_Scankey_Set_Mode_Mode_First_Press_Prog_1
    INC     R_Mode_Set
    JSR     L_Display_Set_Mode_Prog
L_Scankey_Set_Mode_Mode_First_Press_Prog_OUT:
    RTS

L_Scankey_Set_Mode_Mode_First_Press_Prog_1:
    LDA     #0
    STA     R_Mode_Set
    JMP     L_Display_Set_Mode_Prog
Table_Set_Mode:
    DB      5
    DB      3
    DB      0
    DB      1
    DB      1

;============================================
;设置模式下按下Reset键
;=============================================
L_Scankey_Set_Mode_Reset_First_Press_Prog:
    SMB5    Sys_Flag_A
    LDA     #0
    STA     R_Mode_Set
    RMB3    Sys_Flag_A
    JSR     L_Display_Prog
    LDA     R_Mode
    CMP     #1
    BNE     L_Scankey_Set_Mode_Mode_First_Press_Prog_Timer
    RTS
L_Scankey_Set_Mode_Mode_First_Press_Prog_Timer:
    CMP     #4
    BNE     L_Scankey_Set_Mode_Mode_First_Press_Prog_OUT
    LDA     R_Timer_Hr_Countdown
    ORA     R_Timer_Min_Countdown
    BEQ     L_Scankey_Set_Mode_Mode_First_Press_Prog_OUT
    LDA     R_Timer_Hr_Countdown
    STA     R_Timer_Hr_Backup
    LDA     R_Timer_Min_Countdown
    STA     R_Timer_Min_Backup
    RTS

;============================================
;设置模式下按下ST/SP键
;=============================================
L_Scankey_Plus_Prog:
    CLD
    LDA     R_Mode
    CLC
    ROL
    TAX
    LDA     Table_Plus+1,X
    PHA
    LDA     Table_Plus,X
    PHA
    RTS
Table_Plus:
    DW      L_Scankey_Plus_Time_Prog-1
    DW      L_Scankey_Plus_Alarm_Clock_Prog-1
    DW      L_Scankey_Plus_Positive_Prog-1
    DW      L_Scankey_Plus_Another_Time_Prog-1
    DW      L_Scankey_Plus_Desitive_Prog-1
;===========================================

L_Scankey_Prog_Long_Press:
    BBS3    Sys_Flag_A,L_Scankey_Prog_Fast_Set
    JSR     L_Beep_1s
    SMB3    Sys_Flag_A
    SMB5    Sys_Flag_A
    LDA     #0
    STA     R_Mode_Set
    LDA     R_Mode
    BNE     L_Scankey_Prog_Long_Alarm_Clock_Press
    RMB7	Sys_Flag_C
	LDA		#0
	STA		R_Snz_Time
	STA		R_Snz_Frequency
    JMP     L_Clr_Time_Week_Prog

L_Scankey_Prog_Long_Alarm_Clock_Press:
    CMP     #1
    BNE     L_Scankey_Prog_Short_Press_1
    RMB7	Sys_Flag_C
	LDA		#0
	STA		R_Snz_Time
	STA		R_Snz_Frequency
    LDA     #1
    STA     R_Alarm_Mode
    JSR     L_Dis_Alm_Snz_Symbol_Prog



L_Scankey_Prog_Fast_Set:
    SMB4    Sys_Flag_A;快加
    RTS
L_Scankey_Prog_Short_Press_1:
    SMB5    Sys_Flag_A
    RTS
L_Scankey_Prog_Fast_Plus:
    JSR     L_Scankey_usually_Prog
    LDA     P_Scankey_value_Temporary
    CMP     P_Scankey_value
    BNE     L_Scankey_Prog_Short_Press_1
    LDA     R_Fast_Plus_Time
    CMP     #4
    BCS     L_Scankey_Prog_Fast_Plus_1
    INC     R_Fast_Plus_Time
    RTS
L_Scankey_Prog_Fast_Plus_1:
    LDA     #0
    STA     R_Fast_Plus_Time
    JMP     L_Scankey_Plus_Prog
