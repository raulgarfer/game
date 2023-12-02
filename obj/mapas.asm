;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.8 #9946 (Linux)
;--------------------------------------------------------
	.module mapas
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _pinta_mapa
	.globl _cpct_etm_drawTilemap4x8_ag
	.globl _cpct_etm_setDrawTilemap4x8_ag
	.globl _cpct_setPALColour
	.globl _cpct_setVideoMode
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/mapas.c:6: void pinta_mapa(){
;	---------------------------------
; Function pinta_mapa
; ---------------------------------
_pinta_mapa::
;src/mapas.c:7: cpct_setVideoMode(1);
	ld	l, #0x01
	call	_cpct_setVideoMode
;src/mapas.c:8: cpct_setBorder(HW_BLACK);
	ld	hl, #0x1410
	push	hl
	call	_cpct_setPALColour
;src/mapas.c:9: cpct_etm_setDrawTilemap4x8_ag(m1_sencillo_W,m1_sencillo_H,m1_sencillo_W,tiles_16x8_0);
	ld	hl, #_tiles_16x8_0
	push	hl
	ld	hl, #0x0010
	push	hl
	ld	h, #0x19
	push	hl
	call	_cpct_etm_setDrawTilemap4x8_ag
;src/mapas.c:10: cpct_etm_drawTilemap4x8_ag(CPCT_VMEM_START,m1_sencillo);
	ld	hl, #_m1_sencillo
	push	hl
	ld	hl, #0xc000
	push	hl
	call	_cpct_etm_drawTilemap4x8_ag
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
