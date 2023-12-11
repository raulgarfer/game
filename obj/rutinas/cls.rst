ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .module cls
                              2 ;;WWWWWWWWWWWWWWWWWWWWWWWWWWW
                              3 ;;borra toda la pantalla
                              4 ;;input DE direccion memoria (c000 o 8000)
                              5 ;;MMMMMMMMMMMMMMMMMMMMMMMMMM
   51F0                       6 cls::
   51F0 3E 00         [ 7]    7     ld a,#0
   51F2 62            [ 4]    8     ld h,d
   51F3 6B            [ 4]    9     ld l,e
   51F4 77            [ 7]   10     ld (hl),a
   51F5 13            [ 6]   11     inc de
   51F6 01 FF 3F      [10]   12     ld bc,#0x4000-1
   51F9 ED B0         [21]   13     ldir
   51FB C9            [10]   14 ret
