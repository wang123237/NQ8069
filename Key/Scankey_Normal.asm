L_Scankey_usually_Prog:   
    JSR		L_PA257_Input_Low;对按键进行初始化
	JSR		L_ScanKey_Delay_Prog
	LDA		P_PA
	AND		#D_Key_value;将所需要的值相与
	STA		P_Scankey_value_Temporary
	JSR		L_PA257_Input_High
	RTS