L_Judge_IBUF_Prog:
	LDA		IBUF
	ORA		IBUF+1
	ORA		IBUF+2
	ORA		IBUF+3
	RTS
;---------------------------------
L_Move_Left_One_Bit_Prog_IBUF:
	CLC
	ROL		IBUF
	ROL		IBUF+1
	ROL		IBUF+2
	ROL		IBUF+3
	RTS
;---------------------------------
L_Move_Right_One_Bit_Prog_IBUF:
	CLC
	ROR		IBUF+3
	ROR		IBUF+2
	ROR		IBUF+1
	ROR		IBUF
	RTS
;--------------------------------
L_COPY_IBUF_TO_BUF1_FD_Prog:
	LDX		#(BUF1-RAM)
	LDA		IBUF
	STA		RAM, X
	LDA		IBUF+1
	STA		RAM+1, X
	LDA		IBUF+2
	STA		RAM+2, X
	LDA		IBUF+3
	STA		RAM+3, X
	LDA		IBUF+IFD
	STA		RAM+FD, X
	RTS
;----------------------------------
L_COPY_BUF1_TO_BUF2_FD:
	LDX		#(BUF1-RAM)
	JSR		L_Copy_To_BUF2
	LDA		BUF1+FD
	STA		BUF2+FD
	RTS
L_Copy_BUF1_TO_BBUF_Prog:
	LDA		BUF1
	STA		BBUF
	LDA		BUF1+1
	STA		BBUF+1
	LDA		BUF1+2
	STA		BBUF+2
	LDA		BUF1+3
	STA		BBUF+3
	LDA		BUF1+FD
	STA		BBUF+BFD
	RTS
	
L_COPY_BBUF_TO_BUF1_Prog:
	LDA		BBUF
	STA		BUF1
	LDA		BBUF+1
	STA		BUF1+1
	LDA		BBUF+2
	STA		BUF1+2
	LDA		BBUF+3
	STA		BUF1+3
	LDA		BBUF+BFD
	STA		BUF1+FD
	RTS
L_COPY_BUF1_TO_IBUF_FD_Prog:
	LDA		BUF1
	STA		IBUF
	LDA		BUF1+1
	STA		IBUF+1
	LDA		BUF1+2
	STA		IBUF+2
	LDA		BUF1+3
	STA		IBUF+3
	LDA		BUF1+IFD
	STA		IBUF+BFD
	RTS
;===========================================
L_COPY_BUF2_TO_BUF1_FD:
	LDX		#(BUF2-RAM)
	JSR		L_Copy_To_BUF1
	LDA		BUF2+FD
	STA		BUF1+FD
	RTS
L_Clear_IBUF_FD_Prog:
	LDX		#(IBUF-RAM)
	JSR		L_Clear_BUF_Prog
	LDA		#0
	STA		RAM+IFD,X
	RTS
L_Clear_BUF1_FD_Prog:
	LDX		#(BUF1-RAM)
	JSR		L_Clear_BUF_Prog
	LDA		#0
	STA		RAM+FD,X
	RTS
L_Clear_BUF2_FD_Prog
	LDX		#(BUF2-RAM)
	JSR		L_Clear_BUF_Prog
	LDA		#0
	STA		RAM+FD,X
	RTS
;=====================================
Calculator_Input:
    LDA     P_Scankey_value
    CMP     #MAX_Number_Input
    BCC     Calculator_Input_Number_Prog_TO
    CMP     #D_NUM_Equal_Press
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
	; LDA		IBUF+IFD;读取输入的小数位
	; LJNZ	RET1
	; LDA     #ERR_IN
    ; STA     ERR
	JMP		RET1	
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
    LDA     P_Scankey_value
    CMP     #D_NUM_Equal_Press
    BEQ		Input_Equal
    CMP     #D_NUM_Add_Press
	BEQ		Input_Add		
    CMP     #D_NUM_Minus_Press	
	BEQ		Input_Sub_Prog
    CMP     #D_NUM_Multiply_Press
	BEQ		Input_Mul_Prog
    CMP     #D_NUM_Divid_Press	
	BEQ		Input_DIV
	RTS
Input_Equal:
	; LDA		#State_Equal
	; STA		Calculator_Symbol_State_Equal
	; BRA		Input_Symbol_Equal
	JSR		L_Dis_Calculator_Symbol_Prog_Equal
	RTS
Input_Add:
	LDA		#State_Add
	STA		Calculator_Symbol_State
	BRA		Input_Symbol
Input_Sub_Prog:
	LDA		#State_SUB
	STA		Calculator_Symbol_State
	BRA		Input_Symbol
Input_Mul_Prog:
	LDA		#State_Mul
	STA		Calculator_Symbol_State
	BRA		Input_Symbol
Input_DIV:
	LDA		#State_DIV
	STA		Calculator_Symbol_State
	BRA		Input_Symbol
Input_Symbol:
	JSR		L_Dis_Calculator_Symbol_Prog
	RTS
; Input_Symbol_Equal:
; 	JSR		L_Dis_Calculator_Symbol_Prog_Equal
; 	RTS
;===================================
RET1:
    LDA     #1
    RTS
RET0:
    LDA     #0
    RTS
RET:
    RTS

;=====================================
L_Calculator_Calc_Prog:
	CLC
	CLD
	LDA		Calculator_Symbol_State
	ROL
	TAX
	LDA		Table_Calc+1,X
	PHA
	LDA		Table_Calc,X
	PHA
	RTS
Table_Calc:
	DW		RET-1
	DW		L_Control_Add_Prog-1
	DW		L_Control_SUB_Prog-1
	DW		L_Control_Mul_Prog-1
	DW		L_Control_DIV_Prog-1	
	DW		L_Control_Mul_Prog-1	



;==========================================
L_OutPut_Result_IN_:;存在按键输入数字的函数

	RTS
L_OutPut_Result_:;不存在按键输入数字的函数

	RTS



L_Clear_Calculator_Prog:
	JSR		L_Clear_BUF1_FD_Prog
L_Clear_Calculator_Prog_ERR:
	JSR		L_Clr_All_8Bit_Prog
	JSR		L_Clr_Calculator_Symbol_Prog
	LDA		#0
	STA		Calculator_State		
	STA		Calculator_Symbol_State	
	STA		Calculator_State_Mechine
	
	JSR		L_Clear_BUF2_FD_Prog
	JSR		L_Clear_IBUF_FD_Prog
	RTS