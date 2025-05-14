;=======================================
;改变12小时制的AM和PM
;=======================================
L_Change_12_14_Prog_AM_PM_ususally_Prog:
    BBS2    Sys_Flag_B,L_Change_12_24_Prog_PM_AM_RTS;非12小时制退出
    LDA     Time_Addr,X
    CMP     #12
    BCC     L_Change_12_24_Prog_PM_AM_1;比12小跳转，此时有上午变为下午
    SEC
    LDA     Time_Addr,X;自减12
    SBC     #12
    STA     Time_Addr,X
L_Change_12_24_Prog_PM_AM_RTS:
    RTS
L_Change_12_24_Prog_PM_AM_1:
    CLC
    LDA     #12
    ADC     Time_Addr,X;自加12
    STA     Time_Addr,X
    RTS
;============================================
;12小时到24小时
;============================================
L_24_Hour_12_Hour_Prog:
    LDA     Time_Addr,X
    BEQ     L_12_Hour_24_Hour_Prog_0_Hour
    CMP     #12
    BEQ     L_12_Hour_24_Hour_Prog_RTS
    BCC     L_12_Hour_24_Hour_Prog_RTS
    SBC     #12
    RTS
L_12_Hour_24_Hour_Prog_0_Hour:
    LDA     #12
L_12_Hour_24_Hour_Prog_RTS:
    RTS
;==============================================
;12小时到24小时
;==============================================
L_12_Hour_24_Hour_Prog:
    STA     P_Temp+1
    LDX     P_Temp+7
    LDA     Time_Addr,X
    CMP     #12
    BCS     L_24_Hour_12_Hour_Prog_PM
    LDA     P_Temp+1
    CMP     #12
    BNE     L_24_Hour_12_Hour_Prog_AM_RTS
    LDA     #0
L_24_Hour_12_Hour_Prog_AM_RTS:
    RTS
L_24_Hour_12_Hour_Prog_PM:
    LDA     P_Temp+1
    CMP     #12
    BNE     L_24_Hour_12_Hour_Prog_AM_RTS
    CLC
    ADC     #12
    RTS