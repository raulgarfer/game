;; Include all CPCtelera constant definitions, macros and variables
.include "cpctelera.h.s"
.area _DATA
.area _CODE
;; 
;; Declare all function entry points as global symbols for the compiler.
;; (The linker will know what to do with them)
;; WARNING: Every global symbol declared will be linked, so DO NOT declare 
;; symbols for functions you do not use.
;;
.globl cpct_disableFirmware_asm
.globl cpct_getScreenPtr_asm
;;.globl _pinta_mapa
.globl cpct_setCRTCReg_asm
.globl cpct_setVideoMemoryOffset_asm
.globl cpct_waitVSYNC_asm
.globl set_tilemap
.globl my_draw_sprite
.globl _uno
.globl setreg
.globl cls
.globl cpct_setVideoMode_asm
.globl cpct_setVideoMemoryPage_asm
.globl pintar_sprites
.globl draw_tilemap
.globl crea_entidad
;;
;; MAIN function. This is the entry point of the application.
;;    _main:: global symbol is required for correctly compiling and linking
;;
_main::
   ;; Disable firmware to prevent it from interfering with string drawing
  call cpct_disableFirmware_asm
  cpctm_setBorder_asm HW_PINK
  call set_tilemap
   ld c,#0
    call cpct_setVideoMode_asm
;;
call draw_tilemap
call crea_entidad
  call pintar_sprites
   ;; Loop forever
loop:
   jr    loop

