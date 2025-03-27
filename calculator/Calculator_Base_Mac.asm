Move_Right_One_Number   .MACRO    ;数据向右移一位
    LDA     #4
    STA     P_Temp+10
Move_Right_One_Number_Loop:
    CLC
    .IF Dig=8
    ROR     P_Temp+3
    ROR     P_Temp+2
    ROR     P_Temp+1
    ROR     P_Temp
    .ENDIF
    .IF      Dig=10
    ROR     P_Temp+4
    ROR     P_Temp+3
    ROR     P_Temp+2
    ROR     P_Temp+1
    ROR     P_Temp
    .ENDIF
    .IF      Dig=12
    ROR     P_Temp+5
    ROR     P_Temp+4
    ROR     P_Temp+3
    ROR     P_Temp+2
    ROR     P_Temp+1
    ROR     P_Temp
    .ENDIF
    .IF      Dig=14
    ROR     P_Temp+6
    ROR     P_Temp+5
    ROR     P_Temp+4
    ROR     P_Temp+3
    ROR     P_Temp+2
    ROR     P_Temp+1
    ROR     P_Temp
    .ENDIF
    .IF      Dig=16
    ROR     P_Temp+7
    ROR     P_Temp+6
    ROR     P_Temp+5
    ROR     P_Temp+4
    ROR     P_Temp+3
    ROR     P_Temp+2
    ROR     P_Temp+1
    ROR     P_Temp
    .ENDIF
    DEC     P_Temp+10
    LDA     P_Temp+10
    BNE     Move_Right_One_Number_Loop
    .ENDM
;==========================================
Move_Left_One_Number   .MACRO    ;;数据向右移一位
    LDA     #4
    STA     P_Temp+10
Move_Left_One_Number_Loop:
    CLC
    IF      Dig=8
    ROL     P_Temp
    ROL     P_Temp+1
    ROL     P_Temp+2
    ROL     P_Temp+3
    .ENDIF
    IF      Dig=10
    ROL     P_Temp
    ROL     P_Temp+1
    ROL     P_Temp+2
    ROL     P_Temp+3
    ROL     P_Temp+4
    .ENDIF
    IF      Dig=12
    ROL     P_Temp
    ROL     P_Temp+1
    ROL     P_Temp+2
    ROL     P_Temp+3
    ROL     P_Temp+4
    ROL     P_Temp+5
    .ENDIF
    IF      Dig=14
    ROL     P_Temp
    ROL     P_Temp+1
    ROL     P_Temp+2
    ROL     P_Temp+3
    ROL     P_Temp+4
    ROL     P_Temp+5
    ROL     P_Temp+6
    .ENDIF
    IF      Dig=16
    ROL     P_Temp
    ROL     P_Temp+1
    ROL     P_Temp+2
    ROL     P_Temp+3
    ROL     P_Temp+4
    ROL     P_Temp+5
    ROL     P_Temp+6
    ROL     P_Temp+7
    .ENDIF
    DEC     P_Temp+10
    LDA     P_Temp+10
    BNE     Move_Left_One_Number_Loop
    .ENDM

Move_CalcTemp1_To_P_Temp     .MACRO 
    IF      Dig=16
    LDA     Calc_Temp1
    STA     P_Temp
    LDA     Calc_Temp1+1
    STA     P_Temp+1
    LDA     Calc_Temp1+2
    STA     P_Temp+2
    LDA     Calc_Temp1+3
    STA     P_Temp+3
    LDA     Calc_Temp1+4
    STA     P_Temp+4
    LDA     Calc_Temp1+5
    STA     P_Temp+5
    LDA     Calc_Temp1+6
    STA     P_Temp+6
    LDA     Calc_Temp1+7
    STA     P_Temp+7
    .ENDIF
    IF      Dig=14
    LDA     Calc_Temp1
    STA     P_Temp
    LDA     Calc_Temp1+1
    STA     P_Temp+1
    LDA     Calc_Temp1+2
    STA     P_Temp+2
    LDA     Calc_Temp1+3
    STA     P_Temp+3
    LDA     Calc_Temp1+4
    STA     P_Temp+4
    LDA     Calc_Temp1+5
    STA     P_Temp+5
    LDA     Calc_Temp1+6
    STA     P_Temp+6
    .ENDIF
    IF      Dig=12
    LDA     Calc_Temp1
    STA     P_Temp
    LDA     Calc_Temp1+1
    STA     P_Temp+1
    LDA     Calc_Temp1+2
    STA     P_Temp+2
    LDA     Calc_Temp1+3
    STA     P_Temp+3
    LDA     Calc_Temp1+4
    STA     P_Temp+4
    LDA     Calc_Temp1+5
    STA     P_Temp+5
    .ENDIF
    IF      Dig=10
    LDA     Calc_Temp1
    STA     P_Temp
    LDA     Calc_Temp1+1
    STA     P_Temp+1
    LDA     Calc_Temp1+2
    STA     P_Temp+2
    LDA     Calc_Temp1+3
    STA     P_Temp+3
    LDA     Calc_Temp1+4
    STA     P_Temp+4
    .ENDIF
    IF      Dig=8
    LDA     Calc_Temp1
    STA     P_Temp
    LDA     Calc_Temp1+1
    STA     P_Temp+1
    LDA     Calc_Temp1+2
    STA     P_Temp+2
    LDA     Calc_Temp1+3
    STA     P_Temp+3
    .ENDIF
    .ENDM

Move_CalcTemp2_To_P_Temp     .MACRO 
    IF      Dig=16
    LDA     Calc_Temp2
    STA     P_Temp
    LDA     Calc_Temp2+1
    STA     P_Temp+1
    LDA     Calc_Temp2+2
    STA     P_Temp+2
    LDA     Calc_Temp2+3
    STA     P_Temp+3
    LDA     Calc_Temp2+4
    STA     P_Temp+4
    LDA     Calc_Temp2+5
    STA     P_Temp+5
    LDA     Calc_Temp2+6
    STA     P_Temp+6
    LDA     Calc_Temp2+7
    STA     P_Temp+7
    .ENDIF
    IF      Dig=14
    LDA     Calc_Temp2
    STA     P_Temp
    LDA     Calc_Temp2+1
    STA     P_Temp+1
    LDA     Calc_Temp2+2
    STA     P_Temp+2
    LDA     Calc_Temp2+3
    STA     P_Temp+3
    LDA     Calc_Temp2+4
    STA     P_Temp+4
    LDA     Calc_Temp2+5
    STA     P_Temp+5
    LDA     Calc_Temp2+6
    STA     P_Temp+6
    .ENDIF
    IF      Dig=12
    LDA     Calc_Temp2
    STA     P_Temp
    LDA     Calc_Temp2+1
    STA     P_Temp+1
    LDA     Calc_Temp2+2
    STA     P_Temp+2
    LDA     Calc_Temp2+3
    STA     P_Temp+3
    LDA     Calc_Temp2+4
    STA     P_Temp+4
    LDA     Calc_Temp2+5
    STA     P_Temp+5
    .ENDIF
    IF      Dig=10
    LDA     Calc_Temp2
    STA     P_Temp
    LDA     Calc_Temp2+1
    STA     P_Temp+1
    LDA     Calc_Temp2+2
    STA     P_Temp+2
    LDA     Calc_Temp2+3
    STA     P_Temp+3
    LDA     Calc_Temp2+4
    STA     P_Temp+4
    .ENDIF
    IF      Dig=8
    LDA     Calc_Temp2
    STA     P_Temp
    LDA     Calc_Temp2+1
    STA     P_Temp+1
    LDA     Calc_Temp2+2
    STA     P_Temp+2
    LDA     Calc_Temp2+3
    STA     P_Temp+3
    .ENDIF
    .ENDM

Move_P_Temp_To_CalcTemp2    .MACRO 
    IF      Dig=16
    LDA     P_Temp
    STA     Calc_Temp2
    LDA     P_Temp+1
    STA     Calc_Temp2+1
    LDA     P_Temp+2
    STA     Calc_Temp2+2
    LDA     P_Temp+3
    STA     Calc_Temp2+3
    LDA     P_Temp+4
    STA     Calc_Temp2+4
    LDA     P_Temp+5
    STA     Calc_Temp2+5
    LDA     P_Temp+6
    STA     Calc_Temp2+6
    LDA     P_Temp+7
    STA     Calc_Temp2+7
    .ENDIF
    IF      Dig=14
    LDA     P_Temp
    STA     Calc_Temp2
    LDA     P_Temp+1
    STA     Calc_Temp2+1
    LDA     P_Temp+2
    STA     Calc_Temp2+2
    LDA     P_Temp+3
    STA     Calc_Temp2+3
    LDA     P_Temp+4
    STA     Calc_Temp2+4
    LDA     P_Temp+5
    STA     Calc_Temp2+5
    LDA     P_Temp+6
    STA     Calc_Temp2+6
    .ENDIF
    IF      Dig=12
    LDA     P_Temp
    STA     Calc_Temp2
    LDA     P_Temp+1
    STA     Calc_Temp2+1
    LDA     P_Temp+2
    STA     Calc_Temp2+2
    LDA     P_Temp+3
    STA     Calc_Temp2+3
    LDA     P_Temp+4
    STA     Calc_Temp2+4
    LDA     P_Temp+5
    STA     Calc_Temp2+5
    .ENDIF
    IF      Dig=10
    LDA     P_Temp
    STA     Calc_Temp2
    LDA     P_Temp+1
    STA     Calc_Temp2+1
    LDA     P_Temp+2
    STA     Calc_Temp2+2
    LDA     P_Temp+3
    STA     Calc_Temp2+3
    LDA     P_Temp+4
    STA     Calc_Temp2+4
    .ENDIF
    IF      Dig=8
    LDA     P_Temp
    STA     Calc_Temp2
    LDA     P_Temp+1
    STA     Calc_Temp2+1
    LDA     P_Temp+2
    STA     Calc_Temp2+2
    LDA     P_Temp+3
    STA     Calc_Temp2+3
    .ENDIF
    .ENDM

Move_P_Temp_To_CalcTemp1    .MACRO 
    IF      Dig=16
    LDA     P_Temp
    STA     Calc_Temp1
    LDA     P_Temp+1
    STA     Calc_Temp1+1
    LDA     P_Temp+2
    STA     Calc_Temp1+2
    LDA     P_Temp+3
    STA     Calc_Temp1+3
    LDA     P_Temp+4
    STA     Calc_Temp1+4
    LDA     P_Temp+5
    STA     Calc_Temp1+5
    LDA     P_Temp+6
    STA     Calc_Temp1+6
    LDA     P_Temp+7
    STA     Calc_Temp1+7
    .ENDIF
    IF      Dig=14
    LDA     P_Temp
    STA     Calc_Temp1
    LDA     P_Temp+1
    STA     Calc_Temp1+1
    LDA     P_Temp+2
    STA     Calc_Temp1+2
    LDA     P_Temp+3
    STA     Calc_Temp1+3
    LDA     P_Temp+4
    STA     Calc_Temp1+4
    LDA     P_Temp+5
    STA     Calc_Temp1+5
    LDA     P_Temp+6
    STA     Calc_Temp1+6
    .ENDIF
    IF      Dig=12
    LDA     P_Temp
    STA     Calc_Temp1
    LDA     P_Temp+1
    STA     Calc_Temp1+1
    LDA     P_Temp+2
    STA     Calc_Temp1+2
    LDA     P_Temp+3
    STA     Calc_Temp1+3
    LDA     P_Temp+4
    STA     Calc_Temp1+4
    LDA     P_Temp+5
    STA     Calc_Temp1+5
    .ENDIF
    IF      Dig=10
    LDA     P_Temp
    STA     Calc_Temp1
    LDA     P_Temp+1
    STA     Calc_Temp1+1
    LDA     P_Temp+2
    STA     Calc_Temp1+2
    LDA     P_Temp+3
    STA     Calc_Temp1+3
    LDA     P_Temp+4
    STA     Calc_Temp1+4
    .ENDIF
    IF      Dig=8
    LDA     P_Temp
    STA     Calc_Temp1
    LDA     P_Temp+1
    STA     Calc_Temp1+1
    LDA     P_Temp+2
    STA     Calc_Temp1+2
    LDA     P_Temp+3
    STA     Calc_Temp1+3
    .ENDIF
    .ENDM