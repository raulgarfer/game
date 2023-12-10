ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .module setreg
                              2 ;;preparamos el crt para pantall de 20*25 tiles
   51C9                       3 setreg::
   51C9 01 01 BC      [10]    4  ld    bc, #0xBC01  ;; [3] B=0xBC CRTC Select Register, C=register number to be selected
   51CC ED 49         [12]    5     out  (c), c             ;; [4] Select register
   51CE 01 30 BD      [10]    6  ld    bc, #0xBD30  ;; [3] B=0xBD CRTC Set Register, C=Value to be set
   51D1 ED 49         [12]    7     out  (c), c             ;; [4] Set the value
                              8 ;;out #0xbc00,#12
                              9 ;;out #0xbc00,#0x2c
   51D3 06 BC         [ 7]   10 ld b,#0xbc
   51D5 0E 0C         [ 7]   11 ld c,#12
   51D7 ED 49         [12]   12     out (c),c
   51D9 01 2C BD      [10]   13 ld bc,#0xbd2c
   51DC ED 49         [12]   14     out (c),c
   51DE C9            [10]   15  ret
