L_Display_Calculator_Prog:
    LDA     #0
    LDX     #lcd_d8
    JSR     L_Dis_8Bit_DigitDot_Prog
    RTS