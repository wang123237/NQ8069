L_Control_Add_Prog:









L_Mul_Prog:
    CLD
    LDX     #(BUF3-RAM)
    JSR     L_Clear_BUF_Prog
    LDA     #(MAX_DIG*4+1)
    STA     BUF6
L_Mul_Prog_Loop:
    DEC     BUF6
    BEQ     L_Mul_Prog_RTS
    LDX     #(BUF1-RAM)
    JSR     L_Move_Right_One_Bit_Prog
    BCC     L_Mul_Prog_Loop_1
    LDX     #(BUF2-RAM)
    JSR     L_BUFX_Add_BUF3_TO_BUF3_Prog
L_Mul_Prog_Loop_1:
    LDX     #(BUF2-RAM)
    JSR     L_Move_Left_One_Bit_Prog
    BRA     L_Mul_Prog_Loop

L_Mul_Prog_RTS:
    RTS

L_Control_Mul_Prog:；
    LDX     #(BUF2-RAM)
    JSR     L_Copy_To_BUF5
    JSR     L_Dec_To_Hex_Prog

    LDX     #(BUF5-RAM)
    JSR     L_Copy_To_BUF1
    
    LDX     #(BUF2-RAM)
    JSR     L_Copy_To_BUF5
    JSR     L_Dec_To_Hex_Prog

    LDX     #(BUF5-RAM)
    JSR     L_Copy_To_BUF1

    JSR     L_Mul_Prog

    LDX     #(BUF3-RAM)
    JSR     L_Copy_To_BUF1
    JSR     L_Hex_To_Dec_Prog

    LDX     #(BUF1+FD-RAM)
    JSR     L_Adjust_FD_DEC_Prog

    LDX     #(BUF2+FD-RAM)
    JSR     L_Adjust_FD_DEC_Prog

    CLD
    CLC
    LDA     BUF1+FD
    ADC     BUF2+FD
    STA     BUF2+FD
    INC     BUF2+FD
    JMP     L_Control_BUF2_Adjust_Result
    
