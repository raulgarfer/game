.module set_draw_tilemap_4x8.s
.include "cpctelera.h.s"
.globl cpct_etm_setDrawTilemap4x8_ag_asm
.globl _tiles_8x8_0
;;(1B C) width	Width in tiles of the view window to be drawn
;;(1B B) height	Height in tiles of the view window to be drawn
;;(2B DE) tilemapWidth	Width in tiles of the complete tilemap
;;(2B HL) tileset	Pointer to the start of the tileset definition (list of 32-byte tiles).
;;
;;Note: it also uses current interrupt status (register I) as a value.  It should be considered as an additional parameter.
;;Assembly call (Input parameters on Registers)
set_tilemap::
    ld c,#20
    ld b,#25
    ld de,#20
    ld hl,#_tiles_8x8_0
        call cpct_etm_setDrawTilemap4x8_ag_asm
ret
