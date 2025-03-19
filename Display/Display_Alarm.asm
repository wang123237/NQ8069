
;======================================
L_Display_Alarm_Clock_Min_Prog:
	LDA		R_Alarm_Clock_Min
	JMP		L_Display_lcd_Prog_Normal_Min
;=====================================
L_Display_Alarm_Clock_Hr_Prog:
	LDA		R_Alarm_Clock_Hr
	JMP		L_Display_lcd_Prog_Normal_Hr
;=====================================
; L_Display_Alarm_Clock_Day_Prog:
; 	LDA		R_Alarm_Clock_Day
;     BEQ     L_Dis_Minus_Prog_Day
; 	JMP		L_Display_lcd_Prog_Normal_Day
; ;=====================================
; L_Display_Alarm_Clock_Month_Prog:
; 	LDA		R_Alarm_Clock_Month
;     BEQ     L_Dis_Minus_Prog_Month
; 	JMP		L_Display_lcd_Prog_Normal_Month
;===================================
L_Display_Alarm_Hourly_Prog:
    LDA     #0
    JSR     L_Display_lcd_Prog_Normal_Min
    JSR     L_Clr_Hr_Prog 
    RTS
;====================================
L_Display_Alarm_Clock_AL_Symbol_Prog:
    LDA     #18
    LDX     #lcd_d10
    JSR     L_Dis_8Bit_DigitDot_Prog
    LDA     #20
    LDX     #lcd_d9
    RTS     L_Dis_8Bit_DigitDot_Prog


; L_Dis_Minus_Prog_Day:
;     LDA     #11
;     LDX     #lcd_d7
;     JSR     L_Dis_8Bit_DigitDot_Prog
;     LDA     #11
;     LDX     #lcd_d8
;     JMP     L_Dis_8Bit_DigitDot_Prog

; L_Dis_Minus_Prog_Month:
;     LDA     #11
;     LDX     #lcd_d9
;     JSR     L_Dis_8Bit_DigitDot_Prog
;     LDA     #10
;     LDX     #lcd_d10
;     JMP     L_Dis_8Bit_DigitDot_Prog