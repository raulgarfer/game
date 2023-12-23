.module pinta_sprites
.include "cpctelera.h.s"
.globl my_draw_sprite
.globl cls
.globl _uno
pintar_sprites::
   ld de,#0xc000
   ld hl,#_uno
   ld c,#4
   ld b,#16
   ld de,#0xc000
      call my_draw_sprite
ret