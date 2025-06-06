;=====================================
;计算器基础库2025/3/25（易码）
;=====================================
;8位计算器只用+3，具体加几根据MAX_DIG决定，可用去判断除数是否为0
;，平方根运算中被开方数是否为0,以及加减法中需不需要操作数
L_Judge_BUF1_Prog:
    ; LDA     #MAX_BYTE
    ; STA     P_Temp
    LDA		BUF1
	ORA		BUF1+1
	ORA		BUF1+2
	ORA		BUF1+3
	; ORA		BUF1+4
	; ORA		BUF1+5
	RTS
;=====================================    
L_Judge_BUF2_Prog:
	LDA		BUF2
	ORA		BUF2+1
	ORA		BUF2+2
	ORA		BUF2+3
	; ORA		BUF2+4
	; ORA		BUF2+5
	RTS
L_Judge_BUF1_BUF2_IBUF_Prog
	LDA		BUF1
	ORA		BUF1+1
	ORA		BUF1+2
	ORA		BUF1+3
	ORA		BUF2
	ORA		BUF2+1
	ORA		BUF2+2
	ORA		BUF2+3
	ORA		IBUF
	ORA		IBUF+1
	ORA		IBUF+2
	ORA		IBUF+3
	RTS
;=====================================
L_Adjust_FD_DEC_Prog:;小数点右移FD减少
	LDA		RAM,X
	AND		#07FH
	BEQ		L_Adjust_FD_DEC_Prog_RTS
	CLD
	SEC
	LDA		RAM,X
	SBC		#1
	STA		RAM,X
L_Adjust_FD_DEC_Prog_RTS:
	RTS
;=====================================
L_Adjust_FD_INC_Prog:;小数点左移FD增加
	LDA		RAM,X
	AND		#07FH
	BNE		L_Adjust_FD_INC_Prog_RTS
	CLD
	CLC
	LDA		#1
	ADC		RAM,X
	STA		RAM,X
L_Adjust_FD_INC_Prog_RTS:
	RTS
;=====================================
;=====================================
;具体加几根据MAX_DIG决定,
;
L_Move_Left_One_Bit_Prog:
    CLC
L_Move_Left_One_Bit_Prog_C:
	ROL		RAM, X
	ROL		RAM+1, X
	ROL		RAM+2, X
	ROL		RAM+3, X
	ROL		RAM+4, X
	ROL		RAM+5, X
	ROL		RAM+6, X
	ROL		RAM+7, X
    RTS
;=====================================
L_Move_Left_One_DIG_Prog:;；向左平移了1个DIG位数
    JSR     L_Move_Left_One_Bit_Prog
    JSR     L_Move_Left_One_Bit_Prog
    JSR     L_Move_Left_One_Bit_Prog
    JSR     L_Move_Left_One_Bit_Prog
    RTS

;=====================================
L_Move_Left_One_Bit_Prog_BUF1:
    CLC
	ROL		BUF1
	ROL		BUF1+1
	ROL		BUF1+2
	ROL		BUF1+3
	ROL		BUF1+4
	ROL		BUF1+5
	ROL		BUF1+6
	ROL		BUF1+7
    RTS
;====================================
L_Move_Left_One_Bit_Prog_BUF2:
    CLC
	ROL		BUF2
	ROL		BUF2+1
	ROL		BUF2+2
	ROL		BUF2+3
	ROL		BUF2+4
	ROL		BUF2+5
	ROL		BUF2+6
	ROL		BUF2+7
    RTS
;=====================================
L_Move_Left_One_Bit_Prog_BUF5:
    CLC
	ROL		BUF5
	ROL		BUF5+1
	ROL		BUF5+2
	ROL		BUF5+3
	ROL		BUF5+4
	ROL		BUF5+5
	ROL		BUF5+6
	ROL		BUF5+7
    RTS
;=====================================
L_Move_Left_Two_DIG_Prog:;向左平移了2个DIG位数
	LDA		RAM+6,X
	STA		RAM+7,X
	LDA		RAM+5,X
	STA		RAM+6,X
	LDA		RAM+4,X
	STA		RAM+5,X
	LDA		RAM+3,X
	STA		RAM+4,X
	LDA		RAM+2,X
	STA		RAM+3,X
	LDA		RAM+1,X
	STA		RAM+2,X
	LDA		RAM,X
	STA		RAM+1,X
	LDA		#0
	STA		RAM,X
	RTS

;=====================================
L_Move_Max_DIG_Prog:;可能用于数值转换
    JSR     L_Move_Left_Two_DIG_Prog
    JSR     L_Move_Left_Two_DIG_Prog
    JSR     L_Move_Left_Two_DIG_Prog
    JSR     L_Move_Left_Two_DIG_Prog
    RTS
;=====================================
;具体加几根据MAX_DIG决定,
;
L_Move_Right_One_Bit_Prog:
    CLC
L_Move_Right_One_Bit_Prog_C:
    ROR		RAM+7,X
	ROR		RAM+6,X
	ROR		RAM+5,X
	ROR		RAM+4,X
	ROR		RAM+3,X
	ROR		RAM+2,X
	ROR		RAM+1,X
	ROR		RAM,X
    RTS
;=====================================
L_Move_Right_One_DIG_Prog:;；向右平移了1个DIG位数
    JSR     L_Move_Right_One_Bit_Prog
    JSR     L_Move_Right_One_Bit_Prog
    JSR     L_Move_Right_One_Bit_Prog
    JSR     L_Move_Right_One_Bit_Prog
    RTS
;=====================================
L_Move_Right_One_Bit_Prog_BUF1:
	CLC
	ROR		BUF1+7
	ROR		BUF1+6
	ROR		BUF1+5
	ROR		BUF1+4
	ROR		BUF1+3
	ROR		BUF1+2
	ROR		BUF1+1
	ROR		BUF1
    RTS
;=====================================
L_Clear_BUF_Prog:
    LDA		#0
	STA		RAM, X
	STA		RAM+1, X
	STA		RAM+2, X
	STA		RAM+3, X
	STA		RAM+4, X
	STA		RAM+5, X
	STA		RAM+6, X
	STA		RAM+7, X
    RTS
;=====================================
;buf2 = bufx + buf2
;具体加几根据MAX_DIG决定,
L_BUFX_Add_BUF2_TO_BUF2_Prog:
	CLC
	LDA		RAM,X
	ADC		BUF2
	STA		BUF2
	LDA		RAM+1, X
	ADC		BUF2+1
	STA		BUF2+1
	LDA		RAM+2, X
	ADC		BUF2+2
	STA		BUF2+2
	LDA		RAM+3, X
	ADC		BUF2+3
	STA		BUF2+3
	LDA		RAM+4, X
	ADC		BUF2+4
	STA		BUF2+4
	LDA		RAM+5, X
	ADC		BUF2+5
	STA		BUF2+5
	LDA		RAM+6, X
	ADC		BUF2+6
	STA		BUF2+6
	LDA		RAM+7, X
	ADC		BUF2+7
	STA		BUF2+7
	RTS
;=====================================
;---------------------------------------
;buf3 = bufx + buf3
;具体加几根据MAX_DIG决定,
L_BUFX_Add_BUF3_TO_BUF3_Prog:
	CLC
	LDA		RAM, X
	ADC		BUF3
	STA		BUF3
	LDA		RAM+1, X
	ADC		BUF3+1
	STA		BUF3+1
	LDA		RAM+2, X
	ADC		BUF3+2
	STA		BUF3+2
	LDA		RAM+3, X
	ADC		BUF3+3
	STA		BUF3+3
	LDA		RAM+4, X
	ADC		BUF3+4
	STA		BUF3+4
	LDA		RAM+5, X
	ADC		BUF3+5
	STA		BUF3+5
	LDA		RAM+6, X
	ADC		BUF3+6
	STA		BUF3+6
	LDA		RAM+7, X
	ADC		BUF3+7
	STA		BUF3+7
	RTS
;=====================================
L_BUFX_SUB_BUF5_Prog:;比较BUFX和BUF5
	SEC
	LDA		RAM, X
	SBC		BUF5
	LDA		RAM+1, X
	SBC		BUF5+1
	LDA		RAM+2, X
	SBC		BUF5+2
	LDA		RAM+3, X
	SBC		BUF5+3
	LDA		RAM+4, X
	SBC		BUF5+4
	LDA		RAM+5, X
	SBC		BUF5+5
	LDA		RAM+6, X
	SBC		BUF5+6
	LDA		RAM+7, X
	SBC		BUF5+7
	RTS
L_BUFX_SUB_BUF2_Prog:
	SEC
	LDA		RAM, X
	SBC		BUF2
	LDA		RAM+1, X
	SBC		BUF2+1
	LDA		RAM+2, X
	SBC		BUF2+2
	LDA		RAM+3, X
	SBC		BUF2+3
	LDA		RAM+4, X
	SBC		BUF2+4
	LDA		RAM+5, X
	SBC		BUF2+5
	LDA		RAM+6, X
	SBC		BUF2+6
	LDA		RAM+7, X
	SBC		BUF2+7
	RTS
;=====================================
;bufx = bufx - buf5
L_BUFX_SUB_BUF5_TO_BUFX_Prog:
	SEC
	LDA		RAM, X
	SBC		BUF5
	STA		RAM, X

	LDA		RAM+1, X
	SBC		BUF5+1
	STA		RAM+1, X

	LDA		RAM+2, X
	SBC		BUF5+2
	STA		RAM+2, X

	LDA		RAM+3, X
	SBC		BUF5+3
	STA		RAM+3, X

	LDA		RAM+4, X
	SBC		BUF5+4
	STA		RAM+4, X

	LDA		RAM+5, X
	SBC		BUF5+5
	STA		RAM+5, X

	LDA		RAM+6, X
	SBC		BUF5+6
	STA		RAM+6, X

	LDA		RAM+7, X
	SBC		BUF5+7
	STA		RAM+7, X
	RTS
L_BUFX_SUB_BUF2_TO_BUFX_Prog:
	SEC
	LDA		RAM, X
	SBC		BUF2
	STA		RAM, X
	LDA		RAM+1, X
	SBC		BUF2+1
	STA		RAM+1, X
	LDA		RAM+2, X
	SBC		BUF2+2
	STA		RAM+2, X
	LDA		RAM+3, X
	SBC		BUF2+3
	STA		RAM+3, X
	LDA		RAM+4, X
	SBC		BUF2+4
	STA		RAM+4, X
	LDA		RAM+5, X
	SBC		BUF2+5
	STA		RAM+5, X
	LDA		RAM+6, X
	SBC		BUF2+6
	STA		RAM+6, X
	LDA		RAM+7, X
	SBC		BUF2+7
	STA		RAM+7, X
	RTS
;=====================================
;将内存存储到对应BUF1上
L_Copy_To_BUF1:
	LDA		RAM, X
	STA		BUF1
	LDA		RAM+1, X
	STA		BUF1+1
	LDA		RAM+2, X
	STA		BUF1+2
	LDA		RAM+3, X
	STA		BUF1+3
	LDA		RAM+4, X
	STA		BUF1+4
	LDA		RAM+5, X
	STA		BUF1+5
	LDA		RAM+6, X
	STA		BUF1+6
	LDA		RAM+7, X
	STA		BUF1+7
	RTS
;=====================================
;将内存存储到对应BUF2上
L_Copy_To_BUF2:
	LDA		RAM, X
	STA		BUF2
	LDA		RAM+1, X
	STA		BUF2+1
	LDA		RAM+2, X
	STA		BUF2+2
	LDA		RAM+3, X
	STA		BUF2+3
	LDA		RAM+4, X
	STA		BUF2+4
	LDA		RAM+5, X
	STA		BUF2+5
	LDA		RAM+6, X
	STA		BUF2+6
	LDA		RAM+7, X
	STA		BUF2+7
	RTS
;=====================================
;将内存存储到对应BUF3上
L_Copy_To_BUF3:
	LDA		RAM, X
	STA		BUF3
	LDA		RAM+1, X
	STA		BUF3+1
	LDA		RAM+2, X
	STA		BUF3+2
	LDA		RAM+3, X
	STA		BUF3+3
	LDA		RAM+4, X
	STA		BUF3+4
	LDA		RAM+5, X
	STA		BUF3+5
	LDA		RAM+6, X
	STA		BUF3+6
	LDA		RAM+7, X
	STA		BUF3+7
	RTS
;=====================================
;将内存存储到对应BUF4上
L_Copy_To_BUF4:
	LDA		RAM, X
	STA		BUF4
	LDA		RAM+1, X
	STA		BUF4+1
	LDA		RAM+2, X
	STA		BUF4+2
	LDA		RAM+3, X
	STA		BUF4+3
	LDA		RAM+4, X
	STA		BUF4+4
	LDA		RAM+5, X
	STA		BUF4+5
	LDA		RAM+6, X
	STA		BUF4+6
	LDA		RAM+7, X
	STA		BUF4+7
	RTS
;=====================================
;将内存存储到对应BUF1上
L_Copy_To_BUF5:
	LDA		RAM, X
	STA		BUF5
	LDA		RAM+1, X
	STA		BUF5+1
	LDA		RAM+2, X
	STA		BUF5+2
	LDA		RAM+3, X
	STA		BUF5+3
	LDA		RAM+4, X
	STA		BUF5+4
	LDA		RAM+5, X
	STA		BUF5+5
	LDA		RAM+6, X
	STA		BUF5+6
	LDA		RAM+7, X
	STA		BUF5+7
	RTS
L_Judge_BUF1_Prog_Hex_Dex_Prog:
	LDA		BUF1
	BNE		L_Judge_BUF1_Prog_Hex_Dex_Prog_RTS
	ORA		BUF1+1
	ORA		BUF1+2
	ORA		BUF1+3
	ORA		BUF1+4
	ORA		BUF1+5
	ORA		BUF1+6
	ORA		BUF1+7
L_Judge_BUF1_Prog_Hex_Dex_Prog_RTS
	RTS
;=====================================
;	最大十进制999999999999999999999999
;	最大十六进制d3c21bcecceda0ffffff
;	buf1.16 -> buf2.10 buf3,buf6
;将BUF1的16进制数，转换为10进制数存储到BUF2中，BUF3存储每个1对应的权重
L_Hex_To_Dec_Prog:
	LDX		#(BUF2-RAM)
	JSR		L_Clear_BUF_Prog
	LDX		#(BUF3-RAM)
	JSR		L_Clear_BUF_Prog
	LDA		#1
	STA		BUF3;给权重计数器初始值
	SED		
	LDA		#(MAX_DIG*8+1)
	STA		BUF6;计算循环次数

L_Hex_To_Dec_Prog_Loop:
	DEC		BUF6
	BEQ		L_Hex_To_Dec_Prog_RTS
	JSR		L_Move_Right_One_Bit_Prog_BUF1
	; LDX		#(BUF1-RAM)
	; JSR		L_Move_Right_One_Bit_Prog
	BCC		L_Hex_To_Dec_Prog_Loop_1;右移出C标志位，如果为1则说明此时需要在BUF2中加上权重，
;否则跳转改变权重
	LDX		#(BUF3-RAM)
	JSR		L_BUFX_Add_BUF2_TO_BUF2_Prog
L_Hex_To_Dec_Prog_Loop_1:
	LDX		#(BUF3-RAM)
	JSR		L_BUFX_Add_BUF3_TO_BUF3_Prog
	; JSR		L_Judge_BUF1_Prog_Hex_Dex_Prog
	; BEQ		L_Hex_To_Dec_Prog_RTS
	BRA		L_Hex_To_Dec_Prog_Loop
L_Hex_To_Dec_Prog_RTS:
	RTS


;=====================================
;10进制转16进制，将BUF1的10进制数转换为16进制并存储到
L_Dec_To_Hex_Prog:
	LDX		#(BUF2-RAM)
	JSR		L_Clear_BUF_Prog	
	LDX		#(BUF3-RAM)
	JSR		L_Clear_BUF_Prog	
	LDX		#(BUF4-RAM)
	JSR		L_Clear_BUF_Prog	
	LDA		#1
	STA		BUF3;给权重初始值
	CLD
	LDA		#0
	STA		BUF6+1
	LDA		#(MAX_DIG*8+1);循环次数
	STA		BUF6
L_Dec_To_Hex_Prog_Loop:
	DEC		BUF6
	BEQ		L_Dec_To_Hex_Prog_RTS
	JSR		L_Move_Right_One_Bit_Prog_BUF1
	; LDX		#(BUF1-RAM)
	; JSR		L_Move_Right_One_Bit_Prog
	BCC		L_Dec_To_Hex_Prog_Loop_Add;右移BUF1，1个BIT判断
	LDX		#(BUF3-RAM);当C标志位为1时，将当前权重加到BUF2上
	JSR		L_BUFX_Add_BUF2_TO_BUF2_Prog
;-----------------------------------------------------------
;BUF6+1是指是制移位4次，每移位4次权重就要乘以10
;第一次进入权重自身乘以2，第二次进入相将此时的权重存到BUF4后，在乘以二
;第三次权重自身乘以二，第四次此时BUF4的数加到BUF3中
;
L_Dec_To_Hex_Prog_Loop_Add:;
	INC		BUF6+1
	LDA		BUF6+1
	CMP		#4
	BNE		L_Dec_To_Hex_Prog_Loop_1
	LDA		#0
	STA		BUF6+1
L_Dec_To_Hex_Prog_Loop_1:
	LDA		BUF6+1
	BEQ		L_Dec_To_Hex_Prog_BUFX_Add_BUF4_To_BUF3
	CMP		#2
	BEQ		L_Dec_To_Hex_Prog_SAVE
	BRA		L_Dec_To_HEX_Prog_BUF3_To_BUF3_Prog
L_Dec_To_Hex_Prog_BUFX_Add_BUF4_To_BUF3:
	LDX		#(BUF4-RAM)
	JSR		L_BUFX_Add_BUF3_TO_BUF3_Prog
	; JSR		L_Judge_BUF1_Prog_Hex_Dex_Prog
	; BEQ		L_Dec_To_Hex_Prog_RTS
	BRA		L_Dec_To_Hex_Prog_Loop
L_Dec_To_Hex_Prog_SAVE:
	LDX		#(BUF3-RAM)
	JSR		L_Copy_To_BUF4
L_Dec_To_HEX_Prog_BUF3_To_BUF3_Prog:
	LDX		#(BUF3-RAM)
	JSR		L_BUFX_Add_BUF3_TO_BUF3_Prog
	; JSR		L_Judge_BUF1_Prog_Hex_Dex_Prog
	; BEQ		L_Dec_To_Hex_Prog_RTS
	BRA		L_Dec_To_Hex_Prog_Loop
L_Dec_To_Hex_Prog_RTS:
	RTS


;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================

