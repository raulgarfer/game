.module set_draw_tilemap_4x8.s
.include "cpctelera.h.s"
.globl my_cpct_etm_setDrawTilemap4x8_ag_asm
.globl cpct_etm_drawTilemap4x8_ag_asm
.globl _tiles_8x8_0
max_W=20
max_H =25
.globl _max
set_tilemap::
    ld c,#max_W     ;;ancho de pantalla en chars
    ld b,#max_H     ;;alto de pantalla en chars
    ld de,#max_W    ;;ancho total a mostrar en chars
    ld hl,#_tiles_8x8_0     ;;direccion de los tiles a usar
        call my_cpct_etm_setDrawTilemap4x8_ag_asm
ret
draw_tilemap::
    ;;2B HL) memory	Video memory location where to draw the tilemap (character & 4-byte aligned)
;;(2B DE) tilemap	Pointer to the upper-left tile of the view to be drawn of the tilemap
ld hl,#0xc000
ld de,#_max
call cpct_etm_drawTilemap4x8_ag_asm
ret