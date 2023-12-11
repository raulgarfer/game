ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .module setreg
                              2 ;;preparamos el crt para pantall de 20*25 tiles
   51CF                       3 setreg::
   51CF 01 01 BC      [10]    4     ld    bc, #0xBC01  ;; [3] B=0xBC CRTC Select Register, C=register number to be selected
   51D2 ED 49         [12]    5         out  (c), c             ;; [4] Select register
   51D4 01 30 BD      [10]    6     ld    bc, #0xBD30  ;; [3] B=0xBD CRTC Set Register, C=Value to be set
   51D7 ED 49         [12]    7         out  (c), c             ;; [4] Set the value
   51D9 06 BC         [ 7]    8     ld b,#0xbc              ;;pone los registros para usar la memoria desde
   51DB 0E 0C         [ 7]    9     ld c,#12                ;;8000 a ffff seguida.son unos 24kb de 32 usables
   51DD ED 49         [12]   10         out (c),c
   51DF 01 2C BD      [10]   11     ld bc,#0xbd2c
   51E2 ED 49         [12]   12         out (c),c
   51E4 01 02 BC      [10]   13     ld bc,#0xbc02       ;;coloca el raster horizontal para cuadrarlo
   51E7 ED 49         [12]   14     out (c),c
   51E9 06 BD         [ 7]   15     ld b,#0xbd
   51EB 0E 32         [ 7]   16     ld c,#0x32
   51ED ED 49         [12]   17         out (c),c
   51EF 01 06 BC      [10]   18     ld bc,#0xbc06       ;;pone al alto de chars en 34
   51F2 ED 49         [12]   19         out (c),c
   51F4 06 BD         [ 7]   20     ld b,#0xbd
   51F6 0E 22         [ 7]   21     ld c,#0x22
   51F8 ED 49         [12]   22         out (c),c
   51FA 01 07 BC      [10]   23     ld bc,#0xbc07       ;;centra el scan vertical
   51FD ED 49         [12]   24         out (c),c
   51FF 01 23 BD      [10]   25     ld bc,#0xbd23
   5202 ED 49         [12]   26         out (c),c
   5204 C9            [10]   27  ret
