
;===========================================
L_Calculator_Frist_Press_Prog:
    JSR     L_Calculator_Scankey_Prog
    JSR     L_Calculator_Calc_Prog_State_Mechine
    RTS





















L_Calculator_Scankey_Prog:
    LDA     Calculator_State
    CLC
    CLD
    ROL
    TAX
    LDA     Table_Calculator_State+1,X
    PHA
    LDA     Table_Calculator_State,X
    PHA
    RTS
Table_Calculator_State:
    DW      L_Calculator_Init_Prog-1
    DW      L_Calculator_State_Symbol_First_Press_Prog-1
    DW      L_Calculator_State_Input_Prog-1
;======================================================================
L_Calculator_Init_Prog:
    JSR     Calculator_Input
    LDA     P_Scankey_value
    CMP     #16
    
    BCC     L_Calculator_Init_Prog_RTS
    CMP     #20
    BEQ     L_Calculator_Init_Prog_RTS

    LDA     #Calculator_State_Symbol_First_Press;一旦符号键按下，将IBUF的内容传送到，BUF1中
    STA     Calculator_State                    ;并改变计算器当前状态
    LDA     #Calc_First_Output
    STA     Calculator_State_Mechine  
L_Calculator_Init_Prog_RTS:
    RTS  




;============================================================================
L_Calculator_State_Symbol_First_Press_Prog:
;在计算器按下符号键后，判断再次按下的是什么键，;如果是数字键改变状态，如果是符号键，改变符号状态，
;并判断是否是乘方模式;当小于16时判断数字键按下跳转，改变扫键状态;当大于16时判断是符号键按下，当按下等于号是进行运算
    LDA     P_Scankey_value         
    CMP     #16                     
    BCC     Calculator_State_Number_Input  ;小于16说明按下的是数字键 

    LDA     P_Scankey_value
    CMP     #D_NUM_Equal_Press
    BEQ     L_Calculator_State_Symbol_No_Number
    LDA     Calculator_Symbol_State
    CMP     #State_Mul
    BEQ     Calculator_State_Involution_Judgement
    JSR     Calculator_Input_Symbol_Prog
    RTS

Calculator_State_Involution_Judgement:
    JSR     Calculator_Input_Symbol_Prog
    LDA     Calculator_Symbol_State
    CMP     #State_Mul
    BNE     Calculator_State_Involution_Judgement_RTS
    LDA     #State_Involution
    STA     Calculator_Symbol_State
    JSR     L_Display_lcd_Involution_Prog
    JSR     L_Copy_BUF1_TO_BBUF_Prog
Calculator_State_Involution_Judgement_RTS:
    RTS

Calculator_State_Number_Input:;存在按键输入数字跳转计算器输入状态
    LDX     #(IBUF-RAM)
    JSR     L_Clear_BUF_Prog
    JSR     Calculator_Input
    LDA     #Calculator_State_Input
    STA     Calculator_State
    RTS

L_Calculator_State_Symbol_No_Number:;当没有数字键按下并按下等号时，进行自加
    LDA     #Calc_First_Output_
    STA     Calculator_State_Mechine
    LDA     #Calculator_State_Equal_Press
    STA     Calculator_State
    
    RTS

L_Calculator_State_Input_Prog:









