.module rutinas_espera_tecla.s
.area _CODE
.include "cpctelera.h.s"
.globl cpct_scanKeyboard_f_asm
.globl cpct_isAnyKeyPressed_f_asm
;;============================================================================================
;;espera que no haya ninguna tecla pulsada y seguidamente a que se pulse una
;;altera  AF,BC,DE,HL
;;============================================================================================ 
espera_pulsacion_alguna_tecla::
 espera_que_no_se_pulse_tecla:
    call  cpct_scanKeyboard_f_asm
    call cpct_isAnyKeyPressed_f_asm
        jr nz,espera_que_no_se_pulse_tecla
 espera_que_si_se_pulse:
    call  cpct_scanKeyboard_f_asm
    call cpct_isAnyKeyPressed_f_asm
        jr z,espera_que_si_se_pulse
 ret 

