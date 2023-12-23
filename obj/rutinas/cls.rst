ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .module cls
                              2 ;;WWWWWWWWWWWWWWWWWWWWWWWWWWW
                              3 ;;borra toda la pantalla
                              4 ;;input DE direccion memoria (c000 o 8000)
                              5 ;;MMMMMMMMMMMMMMMMMMMMMMMMMM
   45F3                       6 cls::
   45F3 3E 00         [ 7]    7     ld a,#0
   45F5 62            [ 4]    8     ld h,d
   45F6 6B            [ 4]    9     ld l,e
   45F7 77            [ 7]   10     ld (hl),a
   45F8 13            [ 6]   11     inc de
   45F9 01 FF 3F      [10]   12     ld bc,#0x4000-1
   45FC ED B0         [21]   13     ldir
   45FE C9            [10]   14 ret
