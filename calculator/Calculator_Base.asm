;=====================================
;计算器基础库2025/3/25（易码）
;=====================================
;8位计算器只用+3，具体加几根据MAX_DIG决定，可用去判断除数是否为0
;，平方根运算中被开方数是否为0,以及加减法中需不需要操作数
L_Judge_Buf1_Prog:
    LDA     #MAX_BYTE
    STA     P_Temp
    LDA		BUF1
	ORA		BUF1+1
	ORA		BUF1+2
	ORA		BUF1+3
	; ORA		BUF1+4
	; ORA		BUF1+5
	RTS
;=====================================    
L_Judge_Buf2_Prog:
	LDA		BUF2
	ORA		BUF2+1
	ORA		BUF2+2
	ORA		BUF2+3
	; ORA		BUF2+4
	; ORA		BUF2+5
	RTS
;=====================================
;具体加几根据MAX_DIG决定,
;
L_Move_Left_One_Bit_Prog:
    CLC
L_Move_Left_One_Bit_Prog_C:
    ROL		Calculator_Str_Addr,X
	ROL		Calculator_Str_Addr+1,X
	ROL		Calculator_Str_Addr+2,X
	ROL		Calculator_Str_Addr+3,X
	ROL		Calculator_Str_Addr+4,X
	ROL		Calculator_Str_Addr+5,X
	ROL		Calculator_Str_Addr+6,X
	ROL		Calculator_Str_Addr+7,X
    RTS
;=====================================
L_Move_Left_One_DIG_Prog:;；向左平移了1个DIG位数
    JSR     L_Move_Left_One_Bit_Prog
    JSR     L_Move_Left_One_Bit_Prog
    JSR     L_Move_Left_One_Bit_Prog
    JSR     L_Move_Left_One_Bit_Prog
    RTS
;=====================================
L_Move_Left_Two_DIG_Prog:;向左平移了2个DIG位数
	LDA		Calculator_Str_Addr+6,X
	STA		Calculator_Str_Addr+7,X
	LDA		Calculator_Str_Addr+5,X
	STA		Calculator_Str_Addr+6,X
	LDA		Calculator_Str_Addr+4,X
	STA		Calculator_Str_Addr+5,X
	LDA		Calculator_Str_Addr+3,X
	STA		Calculator_Str_Addr+4,X
	LDA		Calculator_Str_Addr+2,X
	STA		Calculator_Str_Addr+3,X
	LDA		Calculator_Str_Addr+1,X
	STA		Calculator_Str_Addr+2,X
	LDA		Calculator_Str_Addr,X
	STA		Calculator_Str_Addr+1,X
	LDA		#0
	STA		Calculator_Str_Addr,X
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
    ROR		Calculator_Str_Addr+7,X
	ROR		Calculator_Str_Addr+6,X
	ROR		Calculator_Str_Addr+5,X
	ROR		Calculator_Str_Addr+4,X
	ROR		Calculator_Str_Addr+3,X
	ROR		Calculator_Str_Addr+2,X
	ROR		Calculator_Str_Addr+1,X
	ROR		Calculator_Str_Addr,X
    RTS
;=====================================
L_Move_Right_One_DIG_Prog:;；向右平移了1个DIG位数
    JSR     L_Move_Right_One_Bit_Prog
    JSR     L_Move_Right_One_Bit_Prog
    JSR     L_Move_Right_One_Bit_Prog
    JSR     L_Move_Right_One_Bit_Prog
    RTS
;=====================================
L_Clear_BUF_Prog:
    LDA		#0
	STA		Calculator_Str_Addr, X
	STA		Calculator_Str_Addr+1, X
	STA		Calculator_Str_Addr+2, X
	STA		Calculator_Str_Addr+3, X
	STA		Calculator_Str_Addr+4, X
	STA		Calculator_Str_Addr+5, X
	STA		Calculator_Str_Addr+6, X
	STA		Calculator_Str_Addr+7, X
    RTS
;=====================================
;buf2 = bufx + buf2
;具体加几根据MAX_DIG决定,
L_BUFX_Add_BUF2_TO_BUF2_Prog:
	CLC
	LDA		Calculator_Str_Addr,X
	ADC		BUF2
	STA		BUF2
	LDA		Calculator_Str_Addr+1, X
	ADC		BUF2+1
	STA		BUF2+1
	LDA		Calculator_Str_Addr+2, X
	ADC		BUF2+2
	STA		BUF2+2
	LDA		Calculator_Str_Addr+3, X
	ADC		BUF2+3
	STA		BUF2+3
	LDA		Calculator_Str_Addr+4, X
	ADC		BUF2+4
	STA		BUF2+4
	LDA		Calculator_Str_Addr+5, X
	ADC		BUF2+5
	STA		BUF2+5
	LDA		Calculator_Str_Addr+6, X
	ADC		BUF2+6
	STA		BUF2+6
	LDA		Calculator_Str_Addr+7, X
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
;	最大十进制999999999999999999999999
;	最大十六进制d3c21bcecceda0ffffff
;	buf1.16 -> buf2.10 buf3,buf6
;将BUF1的16进制数，转换为10进制数存储到BUF2中，BUF3存储每个1对应的权重
L_Hex_To_Dec_Prog:
	LDX		#(BUF2-Calculator_Str_Addr)
	JSR		L_Clear_BUF_Prog
	LDX		#(BUF1-Calculator_Str_Addr)
	JSR		L_Clear_BUF_Prog
	LDA		#1
	STA		BUF3;给权重计数器初始值
	SED		
	LDA		#(MAX_BYTE*8+1)
	STA		BUF6;计算循环次数

L_Hex_To_Dec_Prog_Loop:
	DEC		BUF6
	BEQ		L_Hex_To_Dec_Prog_RTS
	LDX		#(BUF1-Calculator_Str_Addr)
	JSR		L_Move_Right_One_Bit_Prog
	BCC		L_Hex_To_Dec_Prog_Loop_1;右移出C标志位，如果为1则说明此时需要在BUF2中加上权重，
;否则跳转改变权重
	LDX		#(BUF3-Calculator_Str_Addr)
	JSR		L_BUFX_Add_BUF2_TO_BUF2_Prog
L_Hex_To_Dec_Prog_Loop_1:
	LDX		#(BUF3-Calculator_Str_Addr)
	JSR		L_BUFX_Add_BUF3_TO_BUF3_Prog
	BRA		L_Hex_To_Dec_Prog_Loop
L_Hex_To_Dec_Prog_RTS:
	RTS


;=====================================
L_Dec_To_Hex_Prog:
	LDX		#(BUF2-RAM)
	JSR		L_Clear_BUF_Prog	
	LDX		#(BUF3-RAM)
	JSR		L_Clear_BUF_Prog	
	LDX		#(BUF4-RAM)
	JSR		L_Clear_BUF_Prog	
	LDA		#1
	STA		BUF3
	CLD
	LDA		#0
	STA		BUF6+1
	LDA		#(MAX_DIG*8+1)
	STA		BUF6
L_Dec_To_Hex_Prog_Loop:
	


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


