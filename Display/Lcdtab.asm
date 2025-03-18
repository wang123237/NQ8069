;--------COM------------
c0	.equ	4
c1	.equ	3
c2	.equ	2
c3	.equ	1
c4	.equ	0
; c5	.equ	5
; c6	.equ	6
;;--------SEG------------
; s47	.equ	47
; s46	.equ	46
; s45	.equ	45
; s44	.equ	44
; s43	.equ	43
s42	.equ	0
s41	.equ	1
s40	.equ	2
; s39	.equ	39
; s38	.equ	38
; s37	.equ	37
; s36	.equ	36
; s35	.equ	35
; s34	.equ	34
; s33	.equ	33
; s32	.equ	32
; s31	.equ	31
; s30	.equ	30
; s29	.equ	29
; s28	.equ	28
; s27	.equ	27
; s26	.equ	26
; s25	.equ	25
; s24	.equ	24
; s23	.equ	23
; s22	.equ	22
; s21	.equ	21
; s20	.equ	20
; s19	.equ	19
; s18	.equ	18
; s17	.equ	17
; s16	.equ	16
s15	.equ	3
s14	.equ	4
s13	.equ	5
s12	.equ	6
s11	.equ	7
s10	.equ	8
s9	.equ	9
s8	.equ	10
s7	.equ	11
s6	.equ	12
s5	.equ	13
s4	.equ	14
s3	.equ	15
s2	.equ	40
s1	.equ	41
s0	.equ	42


.MACRO  db_c_s	com,seg
          .BYTE com*6+seg/8
.ENDMACRO

.MACRO  db_c_y	com,seg
	      .BYTE 1.shl.(seg-seg/8*8)
.ENDMACRO

Lcd_byte:	;段码
lcd_table1:
lcd_d1 .equ	lcd_table1-lcd_table1
	db_c_s	c0,s15	;;1A
	db_c_s	c0,s40	;;1B
	db_c_s	c0,s12	;;1C
	db_c_s	c0,s10	;;1D
	db_c_s	c0,s11	;;1E
	db_c_s	c0,s14	;;1F
	db_c_s	c0,s13	;;1G

lcd_d2	.equ lcd_d1+7
	db_c_s	c0,s8	;;2A
	db_c_s	c0,s9	;;2B
	db_c_s	c0,s5	;;2C
	db_c_s	c0,s3	;;2D
	db_c_s	c0,s4	;;2E
	db_c_s	c0,s7	;;2F
	db_c_s	c0,s6	;;2G
	
lcd_d3	.equ lcd_d2+7
	
	db_c_s	c2,s42	;;3A
	db_c_s	c1,s41	;;3B
	db_c_s	c1,s40	;;3C
	db_c_s	c1,s15	;;3D
	db_c_s	c2,s15	;;3E
	db_c_s	c2,s41	;;3F
	db_c_s	c2,s40	;;3G

lcd_d4	.equ lcd_d3+7

	db_c_s	c2,s14	;;4A
	db_c_s	c1,s14	;;4B
	db_c_s	c1,s12	;;4C
	db_c_s	c1,s11	;;4D
	db_c_s	c2,s12	;;4E
	db_c_s	c2,s13	;;4F
	db_c_s	c1,s13	;;4G



lcd_d5	.equ lcd_d4+7

	db_c_s	c1,s9	;;5A
	db_c_s	c1,s8	;;5B
	db_c_s	c1,s5	;;5C
	db_c_s	c1,s3	;;5D
	db_c_s	c1,s4	;;5E
	db_c_s	c1,s7	;;5F
	db_c_s	c1,s6	;;5G
lcd_d6	.equ lcd_d5+7

	db_c_s	c1,s0	;;6A
	db_c_s	c1,s2	;;6B
	db_c_s	c1,s1	;;6C
	db_c_s	c1,s0	;;6D
	db_c_s	c1,s0	;;6E
	db_c_s	c1,s0	;;6F
	db_c_s	c1,s0	;;6G

lcd_d7	.equ lcd_d6+7

	db_c_s	c4,s42	;;7A
	db_c_s	c3,s42	;;7B
	db_c_s	c3,s40	;;7C
	db_c_s	c3,s15	;;7D
	db_c_s	c4,s40	;;7E
	db_c_s	c4,s41	;;7F
	db_c_s	c3,s41	;;7G
lcd_d8	.equ lcd_d7+7

	db_c_s	c4,s13	;;8A
	db_c_s	c4,s14	;;8B
	db_c_s	c4,s15	;;8C
	db_c_s	c3,s14	;;8D
	db_c_s	c3,s12	;;8E
	db_c_s	c4,s12	;;8F
	db_c_s	c3,s13	;;8G
lcd_d9	.equ lcd_d8+7

	db_c_s	c4,s9	;;9A
	db_c_s	c4,s10	;;9B
	db_c_s	c3,s11	;;9C
	db_c_s	c2,s11	;;9D
	db_c_s	c2,s10	;;9E
	db_c_s	c3,s9	;;9F
	db_c_s	c3,s10	;;9G
lcd_d10	.equ lcd_d9+7

	db_c_s	c2,s9	;;10A
	
lcd_d11	.equ lcd_d10+1

	db_c_s	c4,s7	;;11A
	db_c_s	c4,s8	;;11B
	db_c_s	c3,s8	;;11C
	db_c_s	c2,s8	;;11D
	db_c_s	c2,s7	;;11E
	db_c_s	c3,s6	;;11F
	db_c_s	c3,s7	;;11G
lcd_d12	.equ lcd_d11+7

	db_c_s	c4,s4	;;12A
	db_c_s	c4,s5	;;12B
	db_c_s	c3,s5	;;12C
	db_c_s	c2,s5	;;12D
	db_c_s	c2,s4	;;12E
	db_c_s	c3,s3	;;12F
	db_c_s	c3,s4	;;12G
lcd_d13	.equ lcd_d12+7

	db_c_s	c4,s1	;;13A
	db_c_s	c4,s2	;;13B
	db_c_s	c2,s3	;;13C
	db_c_s	c2,s2	;;13D
	db_c_s	c2,s1	;;13E
	db_c_s	c3,s1	;;13F
	db_c_s	c3,s2	;;13G



Lcd_dot:
lcd_col .equ Lcd_dot-lcd_table1
	db_c_s	c1,s10	;;COL
	
	db_c_s	c2,s6	;;11I
	db_c_s	c4,s6	;;11H

	db_c_s	c4,s3	;;12H

	db_c_s	c2,s0	;;13I
	db_c_s	c4,s0	;;13H
	db_c_s	c3,s0	;;13J

	db_c_s	c0,s41	;;ALM
	db_c_s	c0,s42	;;SNZ
	db_c_s	c1,s42	;;SIG

	
	
	db_c_s	c0,s0	;;24小时,D1
	db_c_s	c0,s1	;;D2
	
	db_c_s	c0,s2	;;PM
	db_c_s	c4,s11	;;正计时D3

	lcd_11I				.EQU	lcd_col+1	
	lcd_11H				.EQU	lcd_col+2
	lcd_12H				.EQU	lcd_col+3
	lcd_13I				.EQU	lcd_col+4
	lcd_13H				.EQU	lcd_col+5
	lcd_13J				.EQU	lcd_col+6
	lcd_Alm				.EQU	lcd_col+7
	lcd_Snz				.EQU	lcd_col+8
	lcd_Sig				.EQU	lcd_col+9
	lcd_D1				.EQU	lcd_col+10
	lcd_D2				.EQU	lcd_col+11					
	lcd_D3				.EQU	lcd_col+12					
	lcd_D4				.EQU	lcd_col+13	

	lcd_24				.EQU	lcd_D1		
	lcd_PM				.EQU	lcd_D2
	lcd_Timer_Zheng		.EQU	lcd_D3
;=============.EQU	lcd_=============================================
;==========================================================
Lcd_bit:
	

	
	db_c_y	c0,s15	;;1A
	db_c_y	c0,s40	;;1B
	db_c_y	c0,s12	;;1C
	db_c_y	c0,s10	;;1D
	db_c_y	c0,s11	;;1E
	db_c_y	c0,s14	;;1F
	db_c_y	c0,s13	;;1G


	db_c_y	c0,s8	;;2A
	db_c_y	c0,s9	;;2B
	db_c_y	c0,s5	;;2C
	db_c_y	c0,s3	;;2D
	db_c_y	c0,s4	;;2E
	db_c_y	c0,s7	;;2F
	db_c_y	c0,s6	;;2G
	

	
	db_c_y	c2,s42	;;3A
	db_c_y	c1,s41	;;3B
	db_c_y	c1,s40	;;3C
	db_c_y	c1,s15	;;3D
	db_c_y	c2,s15	;;3E
	db_c_y	c2,s41	;;3F
	db_c_y	c2,s40	;;3G



	db_c_y	c2,s14	;;4A
	db_c_y	c1,s14	;;4B
	db_c_y	c1,s12	;;4C
	db_c_y	c1,s11	;;4D
	db_c_y	c2,s12	;;4E
	db_c_y	c2,s13	;;4F
	db_c_y	c1,s13	;;4G





	db_c_y	c1,s9	;;5A
	db_c_y	c1,s8	;;5B
	db_c_y	c1,s5	;;5C
	db_c_y	c1,s3	;;5D
	db_c_y	c1,s4	;;5E
	db_c_y	c1,s7	;;5F
	db_c_y	c1,s6	;;5G


	db_c_y	c1,s0	;;6A
	db_c_y	c1,s2	;;6B
	db_c_y	c1,s1	;;6C
	db_c_y	c1,s0	;;6D
	db_c_y	c1,s0	;;6E
	db_c_y	c1,s0	;;6F
	db_c_y	c1,s0	;;6G



	db_c_y	c4,s42	;;7A
	db_c_y	c3,s42	;;7B
	db_c_y	c3,s40	;;7C
	db_c_y	c3,s15	;;7D
	db_c_y	c4,s40	;;7E
	db_c_y	c4,s41	;;7F
	db_c_y	c3,s41	;;7G


	db_c_y	c4,s13	;;8A
	db_c_y	c4,s14	;;8B
	db_c_y	c4,s15	;;8C
	db_c_y	c3,s14	;;8D
	db_c_y	c3,s12	;;8E
	db_c_y	c4,s12	;;8F
	db_c_y	c3,s13	;;8G


	db_c_y	c4,s9	;;9A
	db_c_y	c4,s10	;;9B
	db_c_y	c3,s11	;;9C
	db_c_y	c2,s11	;;9D
	db_c_y	c2,s10	;;9E
	db_c_y	c3,s9	;;9F
	db_c_y	c3,s10	;;9G


	db_c_y	c2,s9	;;10A
	


	db_c_y	c4,s7	;;11A
	db_c_y	c4,s8	;;11B
	db_c_y	c3,s8	;;11C
	db_c_y	c2,s8	;;11D
	db_c_y	c2,s7	;;11E
	db_c_y	c3,s6	;;11F
	db_c_y	c3,s7	;;11G


	db_c_y	c4,s4	;;12A
	db_c_y	c4,s5	;;12B
	db_c_y	c3,s5	;;12C
	db_c_y	c2,s5	;;12D
	db_c_y	c2,s4	;;12E
	db_c_y	c3,s3	;;12F
	db_c_y	c3,s4	;;12G


	db_c_y	c4,s1	;;13A
	db_c_y	c4,s2	;;13B
	db_c_y	c2,s3	;;13C
	db_c_y	c2,s2	;;13D
	db_c_y	c2,s1	;;13E
	db_c_y	c3,s1	;;13F
	db_c_y	c3,s2	;;13G




	db_c_y	c1,s10	;;COL
	
	db_c_y	c2,s6	;;11I
	db_c_y	c4,s6	;;11H

	db_c_y	c4,s3	;;12H

	db_c_y	c2,s0	;;13I
	db_c_y	c4,s0	;;13H
	db_c_y	c3,s0	;;13J

	db_c_y	c0,s41	;;ALM
	db_c_y	c0,s42	;;SNZ
	db_c_y	c1,s42	;;SIG

	
	
	db_c_y	c0,s0	;;24小时,D1
	db_c_y	c0,s1	;;D2
	
	db_c_y	c0,s2	;;PM
	db_c_y	c4,s11	;;正计时D3