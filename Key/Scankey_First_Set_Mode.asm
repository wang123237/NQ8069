L_Scankey_Set_Mode_First_Press_Prog:
    SMB5    Sys_Flag_A
    LDA     P_Scankey_value
    CMP     #D_Mode_Press
    BEQ     L_Scankey_Set_Mode_Mode_First_Press_Prog
    CMP     #D_Set_Press
    BEQ     L_Scankey_Set_Mode_Set_Press_First_Press_Prog
    JSR     L_Scankey_Set_Mode_First_Press_Prog_1
    JSR     L_Display_Set_Mode_Prog
    RTS

L_Scankey_Set_Mode_First_Press_Prog_1:
    CLD
    CLC
    LDA     R_Mode
    ROL
    TAX
    LDA     Table_Set_Mode_1+1,X
    PHA
    LDA     Table_Set_Mode_1,X
    PHA
L_Scankey_Set_Mode_First_Press_Prog_RTS:
    RTS
Table_Set_Mode_1:
    DW      L_Scankey_Set_Mode_Prog_Clock-1
    DW      L_Scankey_Set_Mode_First_Press_Prog_RTS-1
    DW      L_Scankey_Set_Mode_Prog_Alarm_Clock-1
    DW      L_Scankey_Set_Mode_Prog_Another_Time-1
    DW      L_Scankey_Set_Mode_First_Press_Prog_RTS-1
;==========================================
;设置模式下，按下mode键更换设置的情况
L_Scankey_Set_Mode_Mode_First_Press_Prog:
    SMB5    Sys_Flag_A
    LDA     R_Mode
    CMP     #1
    BEQ     L_Control_Key_Voice_Prog
    CMP     #4
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
    JSR     L_Clr_All_DisRam_Prog
    JMP     L_Display_Prog

L_Control_Key_Voice_Prog:
    BBS5    Sys_Flag_C,L_Control_Key_Voice_Prog_Close
    SMB5    Sys_Flag_C
    RTS
L_Control_Key_Voice_Prog_Close:
    RMB5    Sys_Flag_C
    RTS

Table_Set_Mode:
    DB      10
    DB      0
    DB      3
    DB      3
    DB      0

;============================================
;设置模式下按下Set键，退出设置
;=============================================
L_Scankey_Set_Mode_Set_Press_First_Press_Prog:
    RMB3    Sys_Flag_A
    LDA     #0
    STA     R_Mode_Set
    JSR     L_Clr_All_DisRam_Prog
    JSR     L_Display_Prog
    RTS





;设置模式下的通用函数;(闹钟和第二时间可以使用)
;======================================
;入口A寄存器存储最大值（16进制），X寄存器存储偏移值
;适用于时间的分钟，24小时制是的小时，分钟
;P_Temp+4存储最大值,P_Temp+5存储读到的值，P_Temp+3存储改变的函数值
;=======================================
L_Scankey_Input_Set_Mode_Usally:
    STA     P_Temp+4
    LDA     Time_Addr,X
    JSR     L_A_HexToHexD
    STA     P_Temp+3
    JSR     L_Scankey_Input_Press
    BBS2    Sys_Flag_C,L_Scankey_Input_Set_Mode_Usally_Low_Bit_RTS
    STA     P_Temp+5
    BBR0    R_Mode_Set,L_Scankey_Input_Set_Mode_Usally_High_Bit;根据R_Mode_Set判断是否为高位
L_Scankey_Input_Set_Mode_Usally_Low_Bit:
    LDA     P_Temp+3
    AND     #F0H
    STA     P_Temp+6
    LDA     P_Temp+4
    AND     #F0H
    CMP     P_Temp+6;判断当前内存的高四位和最大值的高四位，当小于时，直接将输入的值给到低四位
    BCC     L_Scankey_Input_Set_Mode_Usally_Low_Bit_Conutine
    LDA     P_Temp+4
    AND     #0FH
    CMP     P_Temp+5;判断当前内存的低四位和最大值的低四位，当小于时，直接将输入的值给到低四位
    BCC     L_Scankey_Input_Set_Mode_Usally_Low_Bit_RTS
    LDA     P_Temp+6
    ORA     P_Temp+5
    JSR     L_A_HexDToHex
    STA		Time_Addr,X
    JSR     L_Scankey_Set_Mode_Mode_First_Press_Prog
L_Scankey_Input_Set_Mode_Usally_Low_Bit_RTS:
    RTS
L_Scankey_Input_Set_Mode_Usally_Low_Bit_Conutine:
    LDA     P_Temp+6
    ORA     P_Temp+5
    JSR     L_A_HexDToHex
    STA		Time_Addr,X
    JSR     L_Scankey_Set_Mode_Mode_First_Press_Prog
    RTS
;======================================================

L_Scankey_Input_Set_Mode_Usally_High_Bit:
    JSR     L_ROL_4Bit_Prog;高4bit将读取到的按键值向左平移4个Bit
    STA     P_Temp+5
    LDA     P_Temp+4
    AND     #F0H
    CMP     P_Temp+5;将最大值和读取到的数比较，当大于时退出
    BEQ     L_Scankey_Input_Set_Mode_Usally_High_Bit_Countine_Special
    BCS     L_Scankey_Input_Set_Mode_Usally_High_Bit_Countine;当按键输入值的前四位大于最大值时推出
    
L_Scankey_Input_Set_Mode_Usally_High_Bit_RTS:
    RTS
L_Scankey_Input_Set_Mode_Usally_High_Bit_Countine_Special:
    LDA     P_Temp+3
    AND     #0FH
    STA     P_Temp+6
    LDA     P_Temp+4
    AND     #0FH
    CMP     P_Temp+6;将最大值的低四位和对应内存的低四位相比较，小于或等于跳转，否则清零低四位
    BCS     L_Scankey_Input_Set_Mode_Usally_High_Bit_Countine
    ; BEQ     L_Scankey_Input_Set_Mode_Usally_High_Bit_Countine
    LDA     P_Temp+5
    JSR     L_A_HexDToHex
    STA		Time_Addr,X
    JSR     L_Scankey_Set_Mode_Mode_First_Press_Prog
    RTS
L_Scankey_Input_Set_Mode_Usally_High_Bit_Countine:
    LDA     P_Temp+3;当小于时，直接将按键读取的值给到对应的内存
    AND     #0FH
    ORA     P_Temp+5
    JSR     L_A_HexDToHex
    STA		Time_Addr,X
    JSR     L_Scankey_Set_Mode_Mode_First_Press_Prog
    RTS

L_Scankey_Input_Set_Mode_Hr_usually:
    STX     P_Temp+7
    JSR     L_Scankey_Input_Press
    STA     P_Temp+4
    BBS2    Sys_Flag_C,L_Scankey_Input_Set_Mode_Usally_High_Bit_RTS
    LDA     Time_Addr,X
    STA     P_Temp+3
    BBR0    R_Mode_Set,L_Scankey_Input_Set_Mode_High_Bit_To
    JMP     L_Scankey_Input_Set_Mode_Low_Bit

L_Scankey_Input_Set_Mode_High_Bit_To:
    JMP     L_Scankey_Input_Set_Mode_High_Bit



L_Scankey_Input_Press:
    RMB2    Sys_Flag_C
    LDA     P_Scankey_value
    CMP     #D_NUM0_Press
    BEQ     L_Input_Prog_Time_Mode_NUM0_Press
    CMP     #D_NUM1_Press
    BEQ     L_Input_Prog_Time_Mode_NUM1_Press
    CMP     #D_NUM2_Press
    BEQ     L_Input_Prog_Time_Mode_NUM2_Press
    CMP     #D_NUM3_Press
    BEQ     L_Input_Prog_Time_Mode_NUM3_Press
    CMP     #D_NUM4_Press
    BEQ     L_Input_Prog_Time_Mode_NUM4_Press
    CMP     #D_NUM5_Press
    BEQ     L_Input_Prog_Time_Mode_NUM5_Press
    CMP     #D_NUM6_Press
    BEQ     L_Input_Prog_Time_Mode_NUM6_Press
    CMP     #D_NUM7_Press
    BEQ     L_Input_Prog_Time_Mode_NUM7_Press
    CMP     #D_NUM8_Press
    BEQ     L_Input_Prog_Time_Mode_NUM8_Press
    CMP     #D_NUM9_Press
    BEQ     L_Input_Prog_Time_Mode_NUM9_Press
    SMB2    Sys_Flag_C
    RTS
L_Input_Prog_Time_Mode_NUM0_Press:
    LDA     #0
    RTS
L_Input_Prog_Time_Mode_NUM1_Press:
    LDA     #1
    RTS
L_Input_Prog_Time_Mode_NUM2_Press:
    LDA     #2
    RTS
L_Input_Prog_Time_Mode_NUM3_Press:
    LDA     #3
    RTS
L_Input_Prog_Time_Mode_NUM4_Press:
    LDA     #4
    RTS
L_Input_Prog_Time_Mode_NUM5_Press:
    LDA     #5
    RTS
L_Input_Prog_Time_Mode_NUM6_Press:
    LDA     #6
    RTS
L_Input_Prog_Time_Mode_NUM7_Press:
    LDA     #7
    RTS
L_Input_Prog_Time_Mode_NUM8_Press:
    LDA     #8
    RTS
L_Input_Prog_Time_Mode_NUM9_Press:
    LDA     #9
    RTS

