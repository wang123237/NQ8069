L_Sec_adress:
    LDA     #lcd_d1
    STA     P_Temp+5
    LDA     #1cd_d2
    STA     P_Temp+6
    RTS
L_Min_adress:
    LDA     #lcd_d3
    STA     P_Temp+5
    LDA     #1cd_d4
    STA     P_Temp+6
    RTS
L_Hr_adress:
    LDA     #lcd_d5
    STA     P_Temp+5
    LDA     #1cd_d6
    STA     P_Temp+6
    RTS
L_Day_adress:
    LDA     #lcd_d7
    STA     P_Temp+5
    LDA     #1cd_d8
    STA     P_Temp+6
    RTS
L__adress:
    LDA     #lcd_d3
    STA     P_Temp+5
    LDA     #1cd_d4
    STA     P_Temp+6
    RTS