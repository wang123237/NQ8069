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
    DW      L_Output_Prog_First_Output_IN-1
    DW      L_Output_Prog_Involution_-1
    DW      L_Output_Prog_Involution_IN-1
L_OutPut_Prog_Init:
    RTS
;===============================================================
L_Output_Prog_First_Output:;按键第一次按下加减乘除符号键所造成的影响
    JSR     L_COPY_IBUF_TO_BUF1_FD_Prog
    JSR     L_COPY_BUF1_TO_BUF2_FD 
    LDA     #Calc_Init
    STA     Calculator_State_Mechine
    RTS
;===============================================================
L_Output_Prog_First_Output_:;没有数字按下时按下等号键
    JSR     L_COPY_IBUF_TO_BUF1_FD_Prog
    LDA     OP
    CMP     #State_SUB
    BEQ     L_Output_Prog_First_Output_1
    CMP     #State_Add
    BEQ     L_Output_Prog_First_Output_1
    JSR     L_Calculator_Calc_Prog
L_Output_Prog_First_Output_1:
    JMP     L_Display_Calculator_Output
;===============================================================
L_Output_Prog_First_Output_IN:;有数字按下时的输出
    JSR     L_COPY_BUF1_TO_BUF2_FD
    JSR     L_COPY_IBUF_TO_BUF1_FD_Prog
    
    JSR     L_Calculator_Calc_Prog
    JMP     L_Display_Calculator_Output
;===============================================================
L_Output_Prog_Involution_:;当没有数字输入时，将BUF1送到BUF2，读取存储的BBUF,相乘
    JSR     L_COPY_BUF1_TO_BUF2_FD
    JSR     L_COPY_BBUF_TO_BUF1_Prog
    JSR     L_Calculator_Calc_Prog
    JMP     L_Display_Calculator_Output
;===============================================================
L_Output_Prog_Involution_IN:
    JSR     L_COPY_IBUF_TO_BUF1_FD_Prog
    JSR     L_COPY_BUF1_TO_BUF2_FD
    JSR     L_COPY_BBUF_TO_BUF1_Prog
    JSR     L_Calculator_Calc_Prog
    JMP     L_Display_Calculator_Output
;===============================================================
;===============================================================
;===============================================================
;===============================================================
;===============================================================
;===============================================================
;===============================================================
;===============================================================
;===============================================================
;===============================================================

L_Display_Calculator_Output:
    LDA     #Calc_Init
    STA     Calculator_State_Mechine
    JSR     L_COPY_BUF2_TO_BUF1_FD
    JSR     L_Display_Number_BUF1_Prog
    LDA     R_Involution
    BNE     L_Display_Calculator_Involution_State
    



    LDA     Calculator_Symbol_State
    CMP     #State_Equal
    BNE     L_Display_Calculator_Output_1
    JSR     L_Clr_Calculator_Symbol_Prog
    LDA     #0
    STA     OP
    STA     Calculator_Symbol_State
L_Display_Calculator_Output_RTS:
    RTS
L_Display_Calculator_Output_1:
    JSR		L_Dis_Calculator_Symbol_Prog
    LDA     Calculator_Symbol_State
    STA     OP
    RTS



L_Display_Calculator_Involution_State:
    LDA     State_Equal
    BEQ     L_Display_Calculator_Output_RTS
    RTS