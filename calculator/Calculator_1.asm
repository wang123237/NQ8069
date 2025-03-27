L_Control_Calculator_Prog:
    JSR     L_Scankey_usually_Prog
    BBS5    Sys_Flag_A,L_Control_Calculator_Prog_RTS
    SMB5    Sys_Flag_A
    CLD
    LDA     P_Scankey_value_Temporary
    CLC
    ROL
    TAX 
    LDA     Table_Calcultor+1,X
    PHA
    LDA     Table_Calcultor,X
    PHA
L_Control_Calculator_Prog_RTS:
    RTS

Table_Calcultor:
    DW      L_Calculator_Mode_Press_Prog-1
    DW      L_Calculator_Reset_Press_Prog-1
    DW      L_Calculator_Reset_Press_Prog-1
    DW      L_Calculator_Light_Press_Prog-1
    DW      L_Calculator_NUM1_Press_Prog-1
    DW      L_Calculator_NUM2_Press_Prog-1
    DW      L_Calculator_NUM3_Press_Prog-1
    DW      L_Calculator_NUM4_Press_Prog-1
    DW      L_Calculator_NUM5_Press_Prog-1
    DW      L_Calculator_NUM6_Press_Prog-1
    DW      L_Calculator_NUM7_Press_Prog-1
    DW      L_Calculator_NUM8_Press_Prog-1
    DW      L_Calculator_NUM9_Press_Prog-1
    DW      L_Calculator_NUM0_Press_Prog-1
    DW      L_Calculator_NUM_Point_Press_Prog-1
    DW      L_Calculator_NUM_Equal_Press_Prog-1
    DW      L_Calculator_NUM_Add_Press_Prog-1
    DW      L_Calculator_NUM1_Minus_Press_Prog-1
    DW      L_Calculator_NUM1_Multiply_Press_Prog-1
    DW      L_Calculator_NUM1_Divid_Press_Prog-1 

L_Calculator_NUM1_Press_Prog:



L_Calculator_usually:
    CLC
    LDA     Calculator_Integer_1_Temp