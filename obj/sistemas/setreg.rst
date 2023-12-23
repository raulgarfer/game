ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .module setreg
                              2 ;;preparamos el crt para pantall de 48*34 tiles,mode 0
   45C9                       3 setreg::
   45C9 01 01 BC      [10]    4     ld    bc, #0xBC01  ;; [3] B=0xBC CRTC Select Register, C=register number to be selected
   45CC ED 49         [12]    5         out  (c), c             ;; [4] Select register
   45CE 06 BD         [ 7]    6     ld    b, #0xBD  ;; [3] B=0xBD CRTC Set Register, C=Value to be set
   45D0 0E 20         [ 7]    7     ld c,#32
   45D2 ED 49         [12]    8         out  (c), c             ;; [4] Set the value
   45D4 01 02 BC      [10]    9     ld bc,#0xbc02       ;;coloca el raster horizontal para cuadrarlo
   45D7 ED 49         [12]   10         out (c),c
   45D9 06 BD         [ 7]   11     ld b,#0xbd
   45DB 0E 2A         [ 7]   12     ld c,#0x2a
                             13     ;;    out (c),c
                             14    ;; ld b,#0xbc              ;;pone los registros para usar la memoria desde
                             15    ;; ld c,#12                ;;8000 a ffff seguida.son unos 24kb de 32 usables
                             16    ;;     out (c),c
                             17    ;; ld bc,#0xbd2c
                             18    ;;     out (c),c
                             19    
                             20    ;; ld bc,#0xbc06       ;;pone al alto de chars en 34
                             21    ;;  ;;   out (c),c
                             22    ;; ld b,#0xbd
                             23    ;; ld c,#0x22
                             24    ;;  ;;   out (c),c
                             25    ;; ld bc,#0xbc07       ;;centra el scan vertical
                             26    ;;     out (c),c
                             27    ;; ld bc,#0xbd23
                             28    ;;    ;; out (c),c
   45DD C9            [10]   29  ret
