                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.6.8 #9946 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module mapas
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _pinta_mapa
                             12 	.globl _cpct_etm_drawTilemap4x8_ag
                             13 	.globl _cpct_etm_setDrawTilemap4x8_ag
                             14 	.globl _cpct_setPALColour
                             15 	.globl _cpct_setVideoMode
                             16 ;--------------------------------------------------------
                             17 ; special function registers
                             18 ;--------------------------------------------------------
                             19 ;--------------------------------------------------------
                             20 ; ram data
                             21 ;--------------------------------------------------------
                             22 	.area _DATA
                             23 ;--------------------------------------------------------
                             24 ; ram data
                             25 ;--------------------------------------------------------
                             26 	.area _INITIALIZED
                             27 ;--------------------------------------------------------
                             28 ; absolute external ram data
                             29 ;--------------------------------------------------------
                             30 	.area _DABS (ABS)
                             31 ;--------------------------------------------------------
                             32 ; global & static initialisations
                             33 ;--------------------------------------------------------
                             34 	.area _HOME
                             35 	.area _GSINIT
                             36 	.area _GSFINAL
                             37 	.area _GSINIT
                             38 ;--------------------------------------------------------
                             39 ; Home
                             40 ;--------------------------------------------------------
                             41 	.area _HOME
                             42 	.area _HOME
                             43 ;--------------------------------------------------------
                             44 ; code
                             45 ;--------------------------------------------------------
                             46 	.area _CODE
                             47 ;src/mapas.c:6: void pinta_mapa(){
                             48 ;	---------------------------------
                             49 ; Function pinta_mapa
                             50 ; ---------------------------------
   4484                      51 _pinta_mapa::
                             52 ;src/mapas.c:7: cpct_setVideoMode(1);
   4484 2E 01         [ 7]   53 	ld	l, #0x01
   4486 CD F2 45      [17]   54 	call	_cpct_setVideoMode
                             55 ;src/mapas.c:8: cpct_setBorder(HW_BLACK);
   4489 21 10 14      [10]   56 	ld	hl, #0x1410
   448C E5            [11]   57 	push	hl
   448D CD CD 44      [17]   58 	call	_cpct_setPALColour
                             59 ;src/mapas.c:9: cpct_etm_setDrawTilemap4x8_ag(m1_sencillo_W,m1_sencillo_H,m1_sencillo_W,tiles_16x8_0);
   4490 21 84 43      [10]   60 	ld	hl, #_tiles_16x8_0
   4493 E5            [11]   61 	push	hl
   4494 21 10 00      [10]   62 	ld	hl, #0x0010
   4497 E5            [11]   63 	push	hl
   4498 26 19         [ 7]   64 	ld	h, #0x19
   449A E5            [11]   65 	push	hl
   449B CD 11 46      [17]   66 	call	_cpct_etm_setDrawTilemap4x8_ag
                             67 ;src/mapas.c:10: cpct_etm_drawTilemap4x8_ag(CPCT_VMEM_START,m1_sencillo);
   449E 21 00 40      [10]   68 	ld	hl, #_m1_sencillo
   44A1 E5            [11]   69 	push	hl
   44A2 21 00 C0      [10]   70 	ld	hl, #0xc000
   44A5 E5            [11]   71 	push	hl
   44A6 CD 4D 45      [17]   72 	call	_cpct_etm_drawTilemap4x8_ag
   44A9 C9            [10]   73 	ret
                             74 	.area _CODE
                             75 	.area _INITIALIZER
                             76 	.area _CABS (ABS)
