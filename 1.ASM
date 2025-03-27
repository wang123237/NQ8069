;=====================================
;具体加几根据MAX_DIG决定,
;
L_Move_Right_One_Bit_Prog:
    CLC
L_Move_Right_One_Bit_Prog_C:
    ROL		Sys_Flag_Cala,X
	ROL		Sys_Flag_Cala+1,X
	ROL		Sys_Flag_Cala+2,X
	ROL		Sys_Flag_Cala+3,X
	ROL		Sys_Flag_Cala+4,X
	ROL		Sys_Flag_Cala+5,X
	ROL		Sys_Flag_Cala+6,X
	ROL		Sys_Flag_Cala+7,X
    RTS
;=====================================
L_Move_Right_One_DIG_Prog:;；向左平移了1个DIG位数
    JSR     L_Move_Right_One_Bit_Prog
    JSR     L_Move_Right_One_Bit_Prog
    JSR     L_Move_Right_One_Bit_Prog
    JSR     L_Move_Right_One_Bit_Prog
    RTS