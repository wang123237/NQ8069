L_Scankey_Plus_Time_Prog:
    JSR     L_Scankey_Plus_Time_Prog_1
    JSR		L_Auto_Counter_Week
    JMP     L_Display_Set_Mode_Prog
L_Scankey_Plus_Time_Prog_1:
    CLD
    LDA     R_Mode_Time_Set
    CLC
    ROL
    TAX
    LDA     Table_Plus_1+1,X
    PHA
    LDA     Table_Plus_1,X
    PHA
    RTS

Table_Plus_1:
    DW      L_Scankey_Plus_Time_Sec_Prog-1
    DW      L_Update_Time_Hr_Prog-1
    DW      L_Update_Time_Min_Prog-1
    DW      L_Update_Time_Year_Prog-1
    DW      L_Update_Time_Month_Prog-1
    DW      L_Update_Time_Day_Prog-1
L_Scankey_Plus_Time_Sec_Prog:
    LDA     R_Time_Sec
    STA     P_Temp
    LDA     #0
    STA     R_Time_Sec
    LDA     P_Temp
    CMP     #30
    BCS     L_Scankey_Plus_Time_Sec_Prog_1
    RTS
L_Scankey_Plus_Time_Sec_Prog_1:
    JMP     L_Update_Time_Min_Prog
;==============================================
;第二时间的加法
;============================================
L_Scankey_Plus_Another_Time_Prog:
    LDA     R_Mode_Time_Set
    BNE     L_Scankey_Plus_Another_Time_Prog_Min
    JSR     L_Update_Another_Time_Hr_Prog
    JMP     L_Display_Set_Mode_Prog
L_Scankey_Plus_Another_Time_Prog_Min:
    JSR     L_Update_Another_Time_Min_Prog
    JMP     L_Display_Set_Mode_Prog
;=====================================
L_Scankey_Plus_Positive_Prog:
    RTS
;=====================================
L_Scankey_Plus_Desitive_Prog:
    LDA     #0
    STA     R_Timer_Sec_Countdown
    STA     R_Timer_Sec_Backup
    LDA     R_Mode_Time_Set
    BNE     L_Scankey_Plus_Desitive_Prog_Min
    JSR     L_Update_Timer_Hr_Prog_Desitive_INC
    JMP     L_Display_Set_Mode_Prog

L_Scankey_Plus_Desitive_Prog_Min:
    JSR     L_Update_Timer_Min_Prog_Desitive_INC
    JMP     L_Display_Set_Mode_Prog
;========================================
L_Scankey_Plus_Alarm_Clock_Prog:
    JSR     L_Scankey_Plus_Alarm_Clock_Prog_1
    JSR     L_Judge_Alarm_Clock_MaxDay_Prog
    JMP     L_Display_Set_Mode_Prog

