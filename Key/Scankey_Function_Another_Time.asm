;======================================================================
;非设置模式下吗,第二时间模式，长按RESET，进入设置模式
;======================================================================
L_Clock_Twice_First_Press_Prog:
	RTS





;======================================================================
;======================================================================
;======================================================================
;======================================================================
;======================================================================
L_Scankey_Set_Mode_Prog_Another_Time:
   LDA      P_Scankey_value
   CMP      #D_NUM_Point_Press
   BEQ      L_Change_12_24_Prog_PM_AM_Another_Time
   LDA      R_Mode_Set
   CLC
   CLD
   ROL
   TAX      
   LDA      Table_Another_Time_Plus+1,X
   PHA
   LDA      Table_Another_Time_Plus,X
   PHA
   RTS 
Table_Another_Time_Plus:
    DW      L_Control_Set_Mode_Another_Clock_Prog_Hr-1
    DW      L_Control_Set_Mode_Another_Clock_Prog_Hr-1
    DW      L_Control_Set_Mode_Another_Clock_Prog_Min-1
    DW      L_Control_Set_Mode_Another_Clock_Prog_Min-1

;======================================================================

L_Change_12_24_Prog_PM_AM_Another_Time:
    LDX     #(R_Time_Hr_Another-Time_Str_Addr)
    JSR     L_Change_12_14_Prog_AM_PM_ususally_Prog
    JSR     L_Display_Another_Time_Hr_Prog
    RTS
;======================================================================


L_Control_Set_Mode_Another_Clock_Prog_Min:
    LDX     #(R_Time_Min_Another-Time_Str_Addr)
    LDA     #59H
    JMP     L_Scankey_Input_Set_Mode_Usally
;======================================================================


L_Control_Set_Mode_Another_Clock_Prog_Hr:
    LDX     #(R_Time_Hr_Another-Time_Str_Addr)
    BBR2    Sys_Flag_B,L_Control_Set_Mode_Another_Clock_Prog_Hr-1
    LDA     #23H
    JMP     L_Scankey_Input_Set_Mode_Usally
L_Control_Set_Mode_Another_Clock_Prog_Hr_1:
    LDA     #12H
    JMP     L_Input_Prog_usually_Mode
