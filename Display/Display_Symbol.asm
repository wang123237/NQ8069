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


;========================================
L_Dis_sig_Prog:
    BBS1    Sys_Flag_C,L_Dis_lcd_Sig_Prog
    JMP     L_Clr_lcd_Sig_Prog

L_Dis_col_Prog:
    LDX     #lcd_col
L_Dis_Symbol_Prog:
    JMP     F_DispSymbol
L_Dis_lcd_11I_Prog:			
    LDX     #lcd_11I
    BRA		L_Dis_Symbol_Prog
L_Dis_lcd_11H_Prog:	
    LDX     #lcd_11H	
    BRA		L_Dis_Symbol_Prog
L_Dis_lcd_12H_Prog:	
	LDX     #lcd_12H	
    BRA		L_Dis_Symbol_Prog
L_Dis_lcd_13I_Prog:	
    LDX     #lcd_13I	
    BRA		L_Dis_Symbol_Prog
L_Dis_lcd_13H_Prog:	
	LDX     #lcd_13H		
    BRA		L_Dis_Symbol_Prog
L_Dis_lcd_13J_Prog:		
    LDX     #lcd_13J	
    BRA		L_Dis_Symbol_Prog
L_Dis_lcd_Alm_Prog:	
    LDX     #lcd_Alm	
    BRA		L_Dis_Symbol_Prog
L_Dis_lcd_Snz_Prog:	
    LDX     #lcd_Snz
    BRA		L_Dis_Symbol_Prog
L_Dis_lcd_Sig_Prog:		
    LDX     #lcd_Sig 
    BRA		L_Dis_Symbol_Prog
L_Dis_lcd_24_Prog:	
    LDX     #lcd_24 
    BRA		L_Dis_Symbol_Prog
L_Dis_lcd_PM_Prog:
    LDX     #lcd_PM
    BRA		L_Dis_Symbol_Prog
L_Dis_lcd_Timer_Zheng_Prog:
    LDX     #lcd_Timer_Zheng
    BRA		L_Dis_Symbol_Prog
L_Dis_lcd_D4_Prog:
    LDX     #lcd_D4
    BRA		L_Dis_Symbol_Prog
    
;================================
L_Clr_col_Prog:
    LDX     #lcd_col
L_Clr_Symbol_Prog:
    JMP     F_ClrpSymbol
L_Clr_lcd_D2_Prog:	
    LDX     #lcd_D2	
    BRA		L_Clr_Symbol_Prog
L_Clr_lcd_d11_Prog:
    LDA     #10
    JSR		L_Display_lcd_d11_Prog_Normal
    LDX     #lcd_11H
    JSR     F_ClrpSymbol
    LDX     #lcd_11I
    BRA     L_Clr_Symbol_Prog
L_Clr_lcd_d12_Prog:
    LDA     #10
    JSR		L_Display_lcd_d12_Prog_Normal
    LDX     #lcd_12H
    BRA     L_Clr_Symbol_Prog
L_Clr_lcd_d13_Prog:
    LDA     #10
    JSR		L_Display_lcd_d13_Prog_Normal
    LDX     #lcd_13H
    JSR     F_ClrpSymbol
    LDX     #lcd_13J
    JSR     F_ClrpSymbol
    LDX     #lcd_13I
    BRA     L_Clr_Symbol_Prog


L_Clr_lcd_Alm_Prog:	
    LDX     #lcd_Alm	
    BRA		L_Clr_Symbol_Prog
L_Clr_lcd_Snz_Prog:	
    LDX     #lcd_Snz
    BRA		L_Clr_Symbol_Prog
L_Clr_lcd_Sig_Prog:		
    LDX     #lcd_Sig 
    BRA		L_Clr_Symbol_Prog
L_Clr_lcd_24_Prog:	
    LDX     #lcd_24 
    BRA		L_Clr_Symbol_Prog
L_Clr_lcd_PM_Prog:
    LDX     #lcd_PM
    BRA		L_Clr_Symbol_Prog
L_Clr_lcd_Timer_Zheng_Prog:
    LDX     #lcd_Timer_Zheng
    BRA		L_Clr_Symbol_Prog
L_Clr_lcd_D4_Prog:
    LDX     #lcd_D4
    BRA		L_Clr_Symbol_Prog
    			

    		
    		
    		
    			
    			
    			
    			
    	
    	