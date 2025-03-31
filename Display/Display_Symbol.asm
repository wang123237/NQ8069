;显示闹钟标志，贪睡标志的清除
L_Clr_Alm_Snz_Symbol_Prog:
    JSR     L_Clr_lcd_Alm_Prog
L_Clr_Alm_Snz_Symbol_Prog_1:
    JMP     L_Clr_lcd_Snz_Prog
RTS_1:
    RTS
L_Dis_Alm_Snz_Symbol_Noraml_Prog:
    BBR4    Sys_Flag_A,RTS_1;闹铃没有响是，不做显示
L_Dis_Alm_Snz_Symbol_Prog:
    LDA     R_Alarm_Mode
    BEQ     L_Clr_Alm_Snz_Symbol_Prog
    JSR     L_Dis_lcd_Alm_Prog
    LDA     R_Alarm_Mode
    CMP     #2   
    BNE     L_Clr_Alm_Snz_Symbol_Prog_1
    JMP     L_Dis_lcd_Snz_Prog
    JSR     F_DispSymbol
;========================================
L_Dis_sig_Prog:
    BBS1    Sys_Flag_C,L_Dis_lcd_Sig_Prog
    JMP     L_Clr_lcd_Sig_Prog

L_Dis_col_Prog:
    LDX     #lcd_col
    JSR     F_DispSymbol
    LDX     #lcd_col2
L_Dis_Symbol_Prog:
    JSR     F_DispSymbol
    RTS
L_Dis_lcd_9H_Prog:	
	LDX     #lcd_9H	
    BRA		L_Dis_Symbol_Prog
L_Dis_lcd_10I_Prog:	
    LDX     #lcd_10I	
    BRA		L_Dis_Symbol_Prog
L_Dis_lcd_10H_Prog:	
	LDX     #lcd_10H		
    BRA		L_Dis_Symbol_Prog
L_Dis_lcd_10J_Prog:		
    LDX     #lcd_10J	
    BRA		L_Dis_Symbol_Prog
L_Dis_lcd_Alm_Prog:	
    LDX     #lcd_ALM	
    BRA		L_Dis_Symbol_Prog
L_Dis_lcd_Snz_Prog:	
    LDX     #lcd_SNZ
    BRA		L_Dis_Symbol_Prog
L_Dis_lcd_Sig_Prog:		
    LDX     #lcd_SIG 
    BRA		L_Dis_Symbol_Prog
L_Dis_lcd_AM_Prog:	
    LDX     #lcd_AM 
    BRA		L_Dis_Symbol_Prog
L_Dis_lcd_PM_Prog:
    LDX     #lcd_PM
    BRA		L_Dis_Symbol_Prog

L_Dis_lcd_T1_Prog:
    LDX     #lcd_T1
    BRA		L_Dis_Symbol_Prog
L_Dis_lcd_T2_Prog:
    LDX     #lcd_T2
    BRA		L_Dis_Symbol_Prog
L_Dis_lcd_T3_Prog:
    LDX     #lcd_T3
    BRA		L_Dis_Symbol_Prog

L_Dis_lcd_T4_Prog:
    LDX     #lcd_T4
    BRA		L_Dis_Symbol_Prog

L_Dis_lcd_T5_Prog:
    LDX     #lcd_T5
    BRA		L_Dis_Symbol_Prog

L_Dis_lcd_T6_Prog:
    LDX     #lcd_T6
    BRA		L_Dis_Symbol_Prog

L_Dis_lcd_T7_Prog:
    LDX     #lcd_T7
    BRA		L_Dis_Symbol_Prog

L_Dis_lcd_T8_Prog:
    LDX     #lcd_T8
    BRA		L_Dis_Symbol_Prog



;================================


    			
L_Clr_col_Prog:
    LDX     #lcd_col
    JSR     F_ClrpSymbol
    LDX     #lcd_col2
L_Clr_Symbol_Prog:
    JSR     F_ClrpSymbol
    RTS

L_Clr_lcd_Alm_Prog:	
    LDX     #lcd_ALM	
    BRA		L_Clr_Symbol_Prog
L_Clr_lcd_Snz_Prog:	
    LDX     #lcd_SNZ
    BRA		L_Clr_Symbol_Prog
L_Clr_lcd_Sig_Prog:		
    LDX     #lcd_SIG 
    BRA		L_Clr_Symbol_Prog
L_Clr_lcd_AM_Prog:	
    LDX     #lcd_AM 
    BRA		L_Clr_Symbol_Prog
L_Clr_lcd_PM_Prog:
    LDX     #lcd_PM
    BRA		L_Clr_Symbol_Prog

L_Clr_lcd_T1_Prog:
    LDX     #lcd_T1
    BRA		L_Clr_Symbol_Prog
L_Clr_lcd_T2_Prog:
    LDX     #lcd_T2
    BRA		L_Clr_Symbol_Prog
L_Clr_lcd_T3_Prog:
    LDX     #lcd_T3
    BRA		L_Clr_Symbol_Prog

L_Clr_lcd_T4_Prog:
    LDX     #lcd_T4
    BRA		L_Clr_Symbol_Prog

L_Clr_lcd_T5_Prog:
    LDX     #lcd_T5
    BRA		L_Clr_Symbol_Prog

L_Clr_lcd_T6_Prog:
    LDX     #lcd_T6
    BRA		L_Clr_Symbol_Prog

L_Clr_lcd_T7_Prog:
    LDX     #lcd_T7
    BRA		L_Clr_Symbol_Prog

L_Clr_lcd_T8_Prog:
    LDX     #lcd_T8
    BRA		L_Clr_Symbol_Prog


;==================================
		
    		
    		
    			
    			
    			
    			
    	
    	