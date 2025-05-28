;按键状态机，存在计算器流程图中
;===========================================
L_Calculator_Frist_Press_Prog:
    JSR     L_Beep_1s
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
    DW      L_Calculator_State_Equal_Press_Prog-1
    DW      L_Calculator_State_Involution-1
    DW      L_Calculator_State_Involution_Number_Input_Prog-1
    DW      L_Calculator_State_Involution_Symbol-1;在乘方模式下输入符号键
;======================================================================
L_Calculator_Init_Prog:
    JSR     Calculator_Input
    LDA     P_Scankey_value
    CMP     #MAX_Number_Input 
    BCC     L_Calculator_Init_Prog_RTS
    CMP     #D_NUM_Equal_Press
    BEQ     L_Calculator_Init_Prog_RTS          ;数字输入和等号输入退出
    LDA     #Calculator_State_Symbol_First_Press;一旦符号键按下，将IBUF的内容传送到，BUF1中
    STA     Calculator_State                    ;并改变计算器当前状态
    LDA     #Calc_First_Output
    STA     Calculator_State_Mechine            ;输出状态机
    LDA     Calculator_Symbol_State
    STA     OP           
L_Calculator_Init_Prog_RTS:
    RTS  
;====================================================================
L_Calculator_State_Symbol_First_Press_Prog:
    LDA     ERR
    BNE     Calculator_State_Involution_Judgement_RTS;存在错误退出
    LDA     P_Scankey_value         
    CMP     #MAX_Number_Input                     
    BCC     Calculator_State_Number_Input  ;小于16说明按下的是数字键 

    LDA     P_Scankey_value
    CMP     #D_NUM_Equal_Press
    BEQ     L_Calculator_State_Symbol_No_Number;按下等于号自己与自己乘法或除法
    LDA     Calculator_Symbol_State
    STA     P_Temp+6
    JSR     Calculator_Input
   ;判断是不是再次按下了乘法键如果是则判断为乘方模式
    LDA     Calculator_Symbol_State
    STA     OP                      
    CMP     P_Temp+6
    BNE     Calculator_State_Involution_Judgement_RTS;判断是否再次按下乘号
    
    JSR     L_Display_lcd_Involution_Prog
    JSR     L_Copy_BUF1_TO_BBUF_Prog
    LDA     #Calculator_State_Involution
    STA     R_Involution
    STA     Calculator_State
Calculator_State_Involution_Judgement_RTS:
    RTS
;----------------------------------------------------------------------
Calculator_State_Number_Input:;存在按键输入数字跳转计算器输入状态
    JSR     L_Clear_IBUF_FD_Prog;清除IBUF的值
    JSR     Calculator_Input
    LDA     #Calculator_State_Input;设置
    STA     Calculator_State
    RTS
;----------------------------------------------------------------------
L_Calculator_State_Symbol_No_Number:;当没有数字键按下并按下等号时，进行自加，
    LDA     #Calc_First_Output_
    STA     Calculator_State_Mechine
    LDA     #Calculator_State_Equal_Press;没有
    STA     Calculator_State
    LDA     Calculator_Symbol_State
    STA     OP
    JSR     Calculator_Input
    RTS
;=====================================================================
L_Calculator_State_Input_Prog:
    JSR     Calculator_Input
    LDA     P_Scankey_value
    CMP     #MAX_Number_Input
    BCC     L_Calculator_State_Input_Prog_RTS;判断当前输入的是否为数字键，如果是退出，不是继续判断
    LDA     #Calc_First_Output_In
    STA     Calculator_State_Mechine;给输出状态机值
    LDA     #Calculator_State_Equal_Press
    STA     Calculator_State
    LDA     P_Scankey_value
    CMP     #D_NUM_Equal_Press
    BEQ     L_Calculator_State_Input_Prog_RTS;判断是否按下等于号键，如果是退出不是则
    LDA     #Calculator_State_Symbol_First_Press
    STA     Calculator_State
L_Calculator_State_Input_Prog_RTS:
    RTS     
;==================================================
L_Calculator_State_Equal_Press_Prog:
    LDA     ERR
    BNE     L_Calculator_State_Equal_Press_Prog_RTS;判断是否存在错误，如果不存在错误的话继续
    LDA     P_Scankey_value
    CMP     #MAX_Number_Input
    BCC     L_Calculator_State_Equal_Press_Prog_Number_Press
    CMP     #D_NUM_Equal_Press
    BEQ     L_Calculator_State_Equal_Press_Prog_RTS;按下等号无意义
    LDA     #0
    STA     Calculator_Symbol_State
    STA     OP

    LDA     #Calculator_State_Symbol_First_Press
    STA     Calculator_State
    JSR     L_COPY_BUF1_TO_IBUF_FD_Prog
    JSR     Calculator_Input
    LDA     Calculator_Symbol_State
    STA     OP
L_Calculator_State_Equal_Press_Prog_RTS:
    RTS

L_Calculator_State_Equal_Press_Prog_Number_Press:;当按下等号在按下数字键时相当于一切清零
    JSR     L_Clear_Calculator_Prog
    JMP     L_Calculator_Init_Prog
;=======================================================
L_Calculator_State_Involution:
    LDA     ERR
    BNE     L_Calculator_State_Involution_RTS;当出现错误时

    LDA     P_Scankey_value
    CMP     #D_NUM_Equal_Press
    BEQ     L_Calculator_State_Involution_Equal_Press;当按下等号后
    CMP     #MAX_Number_Input
    BCC     L_Calculator_State_Involution_Input_Number
    LDA     #Calculator_State_Involution_Input_Symbol;此时按下加减乘除键
    STA     Calculator_State;此时BUF1,BUF2已将运算值存储
    ; JSR     L_COPY_BUF1_TO_IBUF_FD_Prog
    JSR     L_Clear_BBUF_Prog
    ; JSR     L_Clear_BUF1_FD_Prog
    JSR     L_Clear_IBUF_FD_Prog
    LDA     #0
    STA     R_Involution
    JSR     Calculator_Input
L_Calculator_State_Involution_RTS:
    RTS
L_Calculator_State_Involution_Equal_Press:;无数字自乘
    LDA     #Calc_First_Output_Involution
    STA     Calculator_State_Mechine
    JSR     Calculator_Input
    RTS

L_Calculator_State_Involution_Input_Number:
    JSR     L_Clear_IBUF_FD_Prog
L_Calculator_State_Involution_Number_Input_Prog_Input_Number:
    JSR     Calculator_Input
    LDA     #Calculator_State_Involution_Input
    STA     Calculator_State
    RTS

;===============================================
L_Calculator_State_Involution_Number_Input_Prog:
    LDA     ERR
    BNE     L_Calculator_State_Involution_Number_Input_Prog_RTS
    LDA     P_Scankey_value
    CMP     #MAX_Number_Input
    BCC     L_Calculator_State_Involution_Number_Input_Prog_Input_Number
    CMP     #D_NUM_Equal_Press
    BEQ     L_Calculator_State_Involution_Number_Input_Prog_Equal_Press

    JSR     Calculator_Input
    ; JSR     L_Output_Prog_Involution_IN
    JSR     L_Output_Prog_Involution_IN_Symbol
    LDA     #Calculator_State_Symbol_First_Press;此时按下加减乘除键
    STA     Calculator_State;此时BUF1,BUF2已将运算值存储
    
    LDA     Calculator_Symbol_State
    STA     OP
    LDA     #0
    STA     R_Involution
    JSR     Calculator_Input
    JSR     L_Clear_BBUF_Prog
    JSR     L_Clear_BUF2_FD_Prog
    JSR     L_Clear_IBUF_FD_Prog
L_Calculator_State_Involution_Number_Input_Prog_RTS:
    RTS
L_Calculator_State_Involution_Number_Input_Prog_Equal_Press:
    LDA     #Calculator_State_Involution
    STA     Calculator_State
    LDA     #Calc_First_Output_Involution_IN
    STA     Calculator_State_Mechine
    LDA     #State_Equal
    STA     Calculator_Symbol_State
    RTS    
;========================================
L_Calculator_State_Involution_Symbol:
    LDA     Calculator_Symbol_State
    STA     P_Temp+6
    JSR     Calculator_Input
    LDA     P_Scankey_value
    CMP     #D_NUM_Equal_Press
    BEQ     L_Calculator_State_Involution_Symbol_Equal
    CMP     #MAX_Number_Input
    BCC     L_Calculator_State_Involution_Symbol_Number
    LDA     #Calculator_State_Symbol_First_Press;一旦符号键按下，将IBUF的内容传送到，BUF1中
    STA     Calculator_State
    
    LDA     Calculator_Symbol_State
    STA     OP
    CMP     P_Temp+6
    BNE     L_Calculator_State_Involution_Symbol_RTS
    JSR     L_Display_lcd_Involution_Prog
    JSR     L_Copy_BUF1_TO_BBUF_Prog
    LDA     #Calculator_State_Involution
    STA     R_Involution
    STA     Calculator_State
L_Calculator_State_Involution_Symbol_RTS:
    RTS
L_Calculator_State_Involution_Symbol_Equal:
    LDA     #0
    STA     OP
    LDA     #Calculator_State_Equal_Press
    STA     Calculator_State
    JSR     L_Clr_Calculator_Symbol_Prog
    RTS
L_Calculator_State_Involution_Symbol_Number:
    LDA     #Calculator_State_Input;设置
    STA     Calculator_State
    LDA     Calculator_Symbol_State
    STA     OP
    RTS