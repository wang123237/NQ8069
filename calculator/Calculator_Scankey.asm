RET1:
    LDA     #1
    RTS
RET0:
    LDA     #0
    RTS
RET:
    RTS
;===========================================
L_Calculator_Frist_Press_Prog
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

L_Calculator_Init_Prog:
    JSR     Calculator_Input
    LDA     P_Scankey_value
    CMP     #20
    BCC     L_Calculator_Init_Prog_RTS
    LDA     #Calculator_State_Symbol_Press
    STA     Calculator_State
















Calculator_Input:
    LDA     P_Scankey_value
    CMP     #16
    BCC     Calculator_Input_Number_Prog_TO
    CMP     #20
    BCC     Calculator_Input_Symbol_Prog_TO
    RTS

Calculator_Input_Number_Prog_TO:
    JMP     Calculator_Input_Number_Prog

Calculator_Input_Symbol_Prog_TO:
    JMP     Calculator_Input_Symbol_Prog








; ;============================================
L_Input_Full_Prog:
    LDA     IBUF+MAX_BYTE-1
    AND     #0F0H
    LJNZ    L_Input_Full_Error
    LDA     IBUF+IFD
    AND     #07FH
    CMP     #MAX_DIG
    LJZ     RET1
    JMP     RET0

; ;=========================================

L_Input_Full_Error:
	LDA		IBUF+IFD;读取输入的小数位
	LJNZ	RET1
	LDA     #ERR_IN
    STA     ERR
    RTS

Input_FD_Inc:						
	LDA		IBUF+IFD
	AND		#07FH
	LJZ		RET
    CLC
	LDA     IBUF+IFD
    ADC     #1
    STA     IBUF+IFD
	RTS

Input_FD:
	LDA		IBUF+IFD
	AND		#07FH
	LJNZ	RET
    CLC
    LDA     IBUF+IFD
    ADC     #1
    STA     IBUF+IFD
	RTS




; ;============================================

Calculator_Input_Number:
    STA     ACC
    JSR     L_Input_Full_Prog
    LJNZ    RET
    JSR     Input_FD_Inc
    
    JSR     L_Move_Left_One_Bit_Prog_IBUF
    JSR     L_Move_Left_One_Bit_Prog_IBUF
    JSR     L_Move_Left_One_Bit_Prog_IBUF
    JSR     L_Move_Left_One_Bit_Prog_IBUF
    LDA     IBUF
    ORA     ACC
    STA     IBUF
    RTS
;============================================


Calculator_Input_Number_Prog:
    LDA     P_Scankey_value
    CMP     #D_NUM0_Press
    BEQ     Calculator_Input_Number0
    CMP     #D_NUM1_Press
    BEQ     Calculator_Input_Number1
    CMP     #D_NUM2_Press
    BEQ     Calculator_Input_Number2
    CMP     #D_NUM3_Press
    BEQ     Calculator_Input_Number3
    CMP     #D_NUM4_Press
    BEQ     Calculator_Input_Number4
    CMP     #D_NUM5_Press
    BEQ     Calculator_Input_Number5
    CMP     #D_NUM6_Press
    BEQ     Calculator_Input_Number6
    CMP     #D_NUM7_Press
    BEQ     Calculator_Input_Number7
    CMP     #D_NUM8_Press
    BEQ     Calculator_Input_Number8
    CMP     #D_NUM9_Press
    BEQ     Calculator_Input_Number9
    CMP     #D_NUM_Point_Press
    BEQ     Input_Dot
    RTS
Calculator_Input_Number0:
    LDA     #0
    BRA     Calculator_Input_NumberX
Calculator_Input_Number1:
    LDA     #1
    BRA     Calculator_Input_NumberX
Calculator_Input_Number2:
    LDA     #2
    BRA     Calculator_Input_NumberX
Calculator_Input_Number3:
    LDA     #3
    BRA     Calculator_Input_NumberX
Calculator_Input_Number4:
    LDA     #4
    BRA     Calculator_Input_NumberX
Calculator_Input_Number5:
    LDA     #5
    BRA     Calculator_Input_NumberX
Calculator_Input_Number6:
    LDA     #6
    BRA     Calculator_Input_NumberX
Calculator_Input_Number7:
    LDA     #7
    BRA     Calculator_Input_NumberX
Calculator_Input_Number8:
    LDA     #8
    BRA     Calculator_Input_NumberX
Calculator_Input_Number9:
    LDA     #9
Calculator_Input_NumberX
    JSR		Calculator_Input_Number
    JSR     L_Display_Number_IBUF_Prog
    RTS

Input_Dot:
	JSR		Input_FD
	JSR     L_Display_Number_IBUF_Prog
    RTS


Calculator_Input_Symbol_Prog:
    LDA      P_Scankey_value
    CMP      #D_NUM_Equal_Press
    BEQ     
    CMP      #D_NUM_Add_Press		
    CMP      #D_NUM_Minus_Press	
    CMP      #D_NUM_Multiply_Press
    CMP      #D_NUM_Divid_Press	