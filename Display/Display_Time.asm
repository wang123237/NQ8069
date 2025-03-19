L_Display_Another_Time_Min_Prog:
	LDA		R_Time_Min_Another
	JMP		L_Display_lcd_Prog_Normal_Min
L_Display_Another_Time_Hr_Prog:
	LDA		R_Time_Hr_Another
	JMP		L_Display_lcd_Prog_Normal_Hr	
L_Display_Another_Time_DT_Symbol_Prog:
	LDA		#0
	JSR		L_Display_lcd_d10_Prog_Normal
	LDA		#15
	JSR		L_Display_lcd_d9_Prog_Normal
	JSR		L_Dis_lcd_10H_Prog
	JSR		L_Dis_lcd_9H_Prog
	RTS
;===============================================

L_Display_Time_Sec_Prog:
	LDA		R_Time_Sec
	JMP		L_Display_lcd_Prog_Normal_Sec
;======================================
L_Display_Time_Min_Prog:
	LDA		R_Time_Min
	JMP		L_Display_lcd_Prog_Normal_Min
;=====================================
L_Display_Time_Hr_Prog:
	LDA		R_Time_Hr
	JMP		L_Display_lcd_Prog_Normal_Hr
;=====================================
L_Display_Time_Day_Prog:
	LDA		R_Time_Day
	JMP		L_Display_lcd_Prog_Normal_Day
;=====================================
L_Display_Time_Month_Prog:
	LDA		R_Time_Month
	JMP		L_Display_lcd_Prog_Normal_Month
;========================================
L_Display_Time_Year_Prog:
	LDA		#20
	JSR		L_Display_lcd_Prog_Normal_Timer
	LDA		R_Time_Year
	JMP		L_Display_lcd_Prog_Normal_Min

;============================================
L_Display_Time_Week_Prog:;两位显示数字的
	JSR		L_Dis_week_Usually
	CLD
    LDA     R_Time_Week
    CLC
    ROL
    TAX
    LDA     Table_Dis_Week+1,X
    PHA
    LDA     Table_Dis_Week,X
    PHA
    RTS
Table_Dis_Week:
	DW		L_Display_Time_Sunday_Prog-1
	DW		L_Display_Time_Monday_Prog-1
	DW		L_Display_Time_Tuesday_Prog-1
	DW		L_Display_Time_WednesDay_Prog-1
	DW		L_Display_Time_Thursday_Prog-1
	DW		L_Display_Time_Friday_Prog-1
	DW		L_Display_Time_Saturday_Prog-1



L_Display_Time_Monday_Prog:
	JSR		L_Dis_lcd_10J_Prog
	JSR		L_Dis_lcd_10H_Prog
    RTS
	
L_Display_Time_Tuesday_Prog:
	JSR		L_Dis_lcd_10H_Prog
	RTS
L_Display_Time_WednesDay_Prog:
	JSR		L_Dis_lcd_10I_Prog
	JSR		L_Dis_lcd_10J_Prog
	RTS
L_Display_Time_Thursday_Prog:
	JSR		L_Dis_lcd_10H_Prog
	RTS
L_Display_Time_Friday_Prog:
	JSR		L_Dis_lcd_9H_Prog
	
L_Display_Time_Saturday_Prog:
L_Display_Time_Sunday_Prog:
	RTS

L_Dis_week_Usually:
	LDA		R_Time_Week
	CLC		
	ROL
	STA		P_Temp+4
	TAX
	LDA		Table_week,X
	JSR		L_Display_lcd_d9_Prog_Normal
	LDA		P_Temp+4
	INC
	TAX
	LDA		Table_week,X
	JSR		L_Display_lcd_d10_Prog_Normal
	RTS

Table_week:
	
	.byte	16
	.byte	5		

	
	.byte	0
	.byte	14

	
	.byte	16
	.byte	15

	
	.byte	17
	.byte	16

	
	.byte	12
	.byte	15

	
	.byte	18
	.byte	19

	
	.byte	18
	.byte	5

	

; L_Display_Time_Week_Prog:;三位显示数字的
; 	CLD
;     LDA     R_Time_Week
;     CLC
;     ROL
;     TAX
;     LDA     Table_Dis_Week+1,X
;     PHA
;     LDA     Table_Dis_Week,X
;     PHA
;     RTS
; Table_Dis_Week:
; 	DW		L_Display_Time_Sunday_Prog-1
; 	DW		L_Display_Time_Monday_Prog-1
; 	DW		L_Display_Time_Tuesday_Prog-1
; 	DW		L_Display_Time_WednesDay_Prog-1
; 	DW		L_Display_Time_Thursday_Prog-1
; 	DW		L_Display_Time_Friday_Prog-1
; 	DW		L_Display_Time_Saturday_Prog-1



; L_Display_Time_Monday_Prog:
; 	JSR		L_Dis_lcd_13J_Prog
; 	JSR		L_Dis_lcd_13H_Prog
; 	JSR		L_Dis_lcd_11H_Prog
; 	BRA		L_Dis_week_Usually
; L_Display_Time_Tuesday_Prog:
; 	JSR		L_Dis_lcd_13H_Prog
; 	BRA		L_Dis_week_Usually
; L_Display_Time_WednesDay_Prog:
; 	JSR		L_Dis_lcd_13I_Prog
; 	JSR		L_Dis_lcd_13J_Prog
; 	JSR		L_Dis_lcd_11H_Prog
; 	JSR		L_Dis_lcd_11I_Prog
; 	BRA		L_Dis_week_Usually
; L_Display_Time_Thursday_Prog:
; 	JSR		L_Dis_lcd_13H_Prog
; 	BRA		L_Dis_week_Usually
; L_Display_Time_Friday_Prog:
; 	JSR		L_Dis_lcd_12H_Prog
; 	BRA		L_Dis_week_Usually
; L_Display_Time_Saturday_Prog:
; 	JSR		L_Dis_lcd_11H_Prog
; 	BRA		L_Dis_week_Usually
; L_Display_Time_Sunday_Prog:
; 	JSR		L_Dis_lcd_11H_Prog
; L_Dis_week_Usually:
; 	LDA		R_Time_Week
; 	CLC		
; 	ROL
; 	ADC		R_Time_Week
; 	STA		P_Temp+4
; 	TAX
; 	LDA		Table_week,X
; 	JSR		L_Display_lcd_d11_Prog_Normal
; 	LDA		P_Temp+4
; 	INC		
; 	TAX
; 	LDA		Table_week,X
; 	JSR		L_Display_lcd_d12_Prog_Normal
; 	LDA		P_Temp+4
; 	INC
; 	INC
; 	TAX
; 	LDA		Table_week,X
; 	JSR		L_Display_lcd_d13_Prog_Normal
; 	RTS

; Table_week:
; 	.byte	14
; 	.byte	16
; 	.byte	5		

; 	.byte	14
; 	.byte	0
; 	.byte	14

; 	.byte	17
; 	.byte	16
; 	.byte	15

; 	.byte	0
; 	.byte	17
; 	.byte	16

; 	.byte	16
; 	.byte	12
; 	.byte	15

; 	.byte	1
; 	.byte	18
; 	.byte	19

; 	.byte	15
; 	.byte	18
; 	.byte	5
