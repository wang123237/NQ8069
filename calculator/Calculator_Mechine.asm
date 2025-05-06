L_Calculator_Calc_Prog_State_Mechine:
    LDA     Calculator_State_Mechine
    CLC
    CLD
    ROL
    TAX
    LDA     Table_Calc_OutPut+1,X
    PHA
    LDA     Table_Calc_OutPut,X
    PHA
    RTS

Table_Calc_OutPut:
    DW      L_OutPut_Prog_Init-1
    DW      L_Output_Prog_First_Output-1
    DW      L_Output_Prog_First_Output_-1

L_OutPut_Prog_Init:
    RTS
;===============================================================
L_Output_Prog_First_Output:;按键第一次按下加减乘除符号键所造成的影响
    JSR     L_COPY_IBUF_TO_BUF1_FD
    JSR     L_Control_BUF1_Adjust_Result
    JSR     L_COPY_BUF1_TO_BUF2_FD 
    LDA     #Calc_Init
    STA     Calculator_State_Mechine
    RTS
;================================================================
L_Output_Prog_First_Output_:;没有数字按下时按下等号键
    JSR     L_COPY_IBUF_TO_BUF1_FD
    JSR     L_Control_BUF1_Adjust_Result
    JSR     L_Calculator_Calc_Prog
    LDA     #Calc_Init
    STA     Calculator_State_Mechine
    JMP     L_Display_Calculator_Output




L_Display_Calculator_Output:
    JSR     L_COPY_BUF2_TO_BUF1_FD
    JSR     L_Display_Number_BUF1_Prog
    RTS
