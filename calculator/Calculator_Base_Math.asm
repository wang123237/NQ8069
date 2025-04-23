
;========================================================
;加法
;========================================================
L_Control_Add_Prog:
    LDX     #(BUF1+FD-RAM)
    JSR     L_Adjust_FD_INC_Prog
    LDX     #(BUF2+FD-RAM)
    JSR     L_Adjust_FD_INC_Prog
L_Control_Add_Prog_Loop:    
    LDA		BUF1+FD
	AND		#07FH
	STA		BUF6
	LDA		BUF2+FD
	AND		#07FH
	CMP		BUF6
    BEQ     L_Control_Add_Prog_CALC
    BCS     L_Control_Add_Prog_BUF1_LEFT
L_Control_Add_Prog_BUF2_LEFT:	
	LDX		#(BUF2-RAM)
	JSR		L_Move_Left_One_DIG_Prog
	INC		BUF2+FD
	BRA		L_Control_Add_Prog_Loop
L_Control_Add_Prog_BUF1_LEFT:
	LDX		#(BUF1-RAM)
	JSR		L_Move_Left_One_DIG_Prog
	INC		BUF1+FD
	BRA		L_Control_Add_Prog_Loop
L_Control_Add_Prog_CALC:
	LDA		BUF1+FD
	EOR		BUF2+FD
	AND		#080H
	BEQ		L_Control_Add_Prog_CALC_Add
L_Control_Add_Prog_CALC_SUB:
	SED
	LDX		#(BUF2-RAM)			;2->5
	JSR		L_Copy_To_BUF5
	LDX		#(BUF1-RAM)			;1-5?
	JSR		L_BUFX_SUB_BUF5_Prog
	BCS		L_Control_Add_Prog_CALC_SUB_1
	SED
	LDX		#(BUF1-RAM)			;1->5
	JSR		L_Copy_To_BUF5
	LDX		#(BUF2-RAM)			;2=2-5		
	JSR		L_BUFX_SUB_BUF5_TO_BUFX_Prog
	BRA		L_Control_Add_Prog_CALC_END	
L_Control_Add_Prog_CALC_SUB_1:
	SED
	LDX		#(BUF1-RAM)			;1->2
	JSR		L_Copy_To_BUF2
	LDX		#(BUF2-RAM)			;2=2-5		
	JSR		L_BUFX_SUB_BUF5_TO_BUFX_Prog
	LDA		BUF1+FD
	STA		BUF2+FD
	BRA		L_Control_Add_Prog_CALC_END
L_Control_Add_Prog_CALC_Add:
	SED
	LDX		#(BUF1-RAM)
	JSR		L_BUFX_Add_BUF2_TO_BUF2_Prog
L_Control_Add_Prog_CALC_END:
	JMP		L_Control_BUF2_Adjust_Result

;========================================================
L_Control_SUB_Prog:
	LDA		BUF1+FD
	EOR		#080H
	STA		BUF1+FD
	JMP		L_Control_Add_Prog




;========================================================
;乘法
;========================================================
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

L_Control_Mul_Prog:;
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
    
;========================================================
;除法
;========================================================
L_DIV_Prog:
    CLD
    LDX     #(BUF1-RAM)
    LDA     #0
    STA     BUF6+4
    LDA     #2
    STA     BUF6
L_DIV_Prog_Loop:
    LDA     BUF5+MAX_DIG-1
    AND     #080H
    BNE     L_DIV_Prog_LOOP_1    
    INC     BUF6
    LDX     #(BUF5-RAM)
    JSR     L_Move_Left_One_Bit_Prog
    BRA     L_DIV_Prog_Loop
L_DIV_Prog_LOOP_1:
    DEC     BUF6
    BEQ     L_DIV_Prog_RTS
    LDX     #(BUF1-RAM)
    JSR     L_Move_Left_One_Bit_Prog
    LDX     #(BUF2-RAM)
    JSR     L_BUFX_SUB_BUF5_Prog
    LDA     BUF6+1
    SBC     #0
    BCC     L_DIV_Prog_LOOP_2
    LDX     #(BUF2-RAM)
    JSR     L_BUFX_SUB_BUF5_TO_BUFX_Prog
    LDA     BUF6+1
    SBC     #0
    STA     BUF6+1
    INC     BUF1
L_DIV_Prog_LOOP_2:
    LDX     #(BUF2-RAM)
    JSR     L_Move_Left_One_Bit_Prog
    ROL     BUF6+1
    BRA     L_DIV_Prog_LOOP_1
L_DIV_Prog_RTS:
    RTS



;=========================================================
L_Control_DIV_Prog:
    JSR     L_Judge_Buf1_Prog
    BEQ     L_Control_DIV_Prog_ERR
    JSR     L_Judge_Buf2_Prog
    BEQ     L_Control_DIV_Prog_0
    BRA		L_Control_DIV_Prog_DIV_INIT
L_Control_DIV_Prog_ERR:
    LDA     #ERR_DIV0
    STA     ERR
L_Control_DIV_Prog_0:
    LDX     #(BUF2-RAM)
    JSR     L_Clear_BUF_Prog
    LDA     #0
    STA     BUF2+FD
    RTS
;---------------------------------------------------------
L_Control_DIV_Prog_DIV_INIT:
    LDX     #(BUF1+FD-RAM)
    JSR     L_Adjust_FD_INC_Prog
    LDX     #(BUF2+FD-RAM)
    JSR     L_Adjust_FD_INC_Prog

L_Control_DIV_Prog_DIV_Loop:
    LDA     BUF2+MAX_BYTE-1;(原先是BUF2+5)
    AND     #0F0H
    BNE     L_Control_DIV_Prog_DIV
    LDX     #(BUF2-RAM)
    JSR     L_Move_Left_One_DIG_Prog
    INC     BUF2+FD
    BRA     L_Control_DIV_Prog_DIV_Loop

L_Control_DIV_Prog_DIV:
    LDX     #(BUF2-RAM)
    JSR     L_Move_Max_DIG_Prog
    LDX     #(BUF2-RAM)
    JSR     L_Copy_To_BUF5
    JSR     L_Dec_To_Hex_Prog
    LDX     #(BUF5-RAM)
    JSR     L_Copy_To_BUF1
    LDX     #(BUF2-RAM)
    JSR     L_Copy_To_BUF5
    JSR     L_Dec_To_Hex_Prog
    JSR     L_DIV_Prog
    JSR     L_Hex_To_Dec_Prog
;-------------------------------------------
    LDA     BUF2+FD
    AND     #07FH
    STA     BUF6
    LDA     BUF2+FD
    AND     #080H
    STA     BUF6+1
    LDA     BUF1+FD
    AND     #07FH
    STA     BUF6+2
    LDA     BUF1+FD
    AND     #080H
    STA     BUF6+3
;------------------------------------------
    CLD
    CLC
    LDA     #MAX_DIG
    ADC     BUF6
    SEC
    SBC     BUF6+2
    STA     BUF2+FD
    LDA		BUF6+1
	EOR		BUF6+3
	ORA		BUF2+FD
	STA		BUF2+FD
	JMP		L_Control_BUF2_Adjust_Result


;=========================================================
L_Control_BUF1_Adjust_Result:
	LDA		#(BUF1+FD-RAM)
	STA		BUF6
	LDA		#(BUF6-RAM)
	STA		BUF6+1
	BRA		L_Adjust_Result_Prog
L_Control_BUF2_Adjust_Result:
	LDA		#(BUF2+FD-RAM)
	STA		BUF6
	LDA		#(BUF6-RAM)
	STA		BUF6+1
L_Adjust_Result_Prog:
	LDX		BUF6
	JSR		L_Adjust_FD_INC_Prog
L_Adjust_Result_Prog_Loop:
	LDX		BUF6
	LDA		RAM,X
	AND		#07FH
	CLD
	SEC
	SBC		#MAX_DIG+1
	BCS		L_Adjust_Result_Move_Right_Prog
	LDA		ERR
	BNE		L_Adjust_Result_Prog_Loop
	LDX		BUF6
	LDA		RAM,X
	AND		#07FH
	CMP		#1
	BNE		L_Adjust_Result_Move_Right_Prog
L_Adjust_Result_Prog_Loop1:
	LDX		BUF6+1
	LDA		RAM+4,X
	ORA		RAM+5,X
	ORA		RAM+6,X
	ORA		RAM+7,X
	BNE		L_Adjust_Result_Move_Right_Prog
	BRA		L_Adjust_Result_Prog_Zero
L_Adjust_Result_Move_Right_Prog:
	LDX		BUF6+1
	JSR		L_Move_Right_One_DIG_Prog
	LDX		BUF6
	LDA		RAM,X
	AND		#07FH
	CMP		#1
	BEQ		L_Adjust_Result_Prog_Error
	LDX		#BUF6
	LDA		RAM,X
	STA		BUF6+2
	DEC		BUF6+2
	LDA		BUF6+2
	STA		RAM,X
	BRA		L_Adjust_Result_Prog_Loop
L_Adjust_Result_Prog_Error:
	LDX		BUF6
	LDA		RAM,X
	AND		#080H
	ORA		#MAX_DIG
	STA		RAM,X
	LDA		#Err_FUll
	STA		ERR
	BRA		L_Adjust_Result_Prog
L_Adjust_Result_Prog_Zero:
	LDX		BUF6+1
	LDA		RAM,X
	ORA		RAM+1,X
	ORA		RAM+2,X
	ORA		RAM+3,X
	BNE		L_Adjust_Result_Prog_Zero_RTS
	LDA		#0
	LDX		BUF6
	STA		RAM,X
L_Adjust_Result_Prog_Zero_RTS
	RTS	
