ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .module declaracion_entidades.s
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              2 .include "macros_entidad.inc"
                              1 .module macros_entidad.inc
                              2 .macro Entidad nombre,tipo,x,y,vx,vy,ancho,alto,sprite
                              3     nombre::
                              4         .db tipo    ;;tipo
                              5         .db x       ;;x
                              6         .db y       ;;y
                              7         .db vx      ;;velocidadx
                              8         .db vy      ;;velocidady
                              9         .db ancho   ;;ancho
                             10         .db alto    ;;ALto
                             11         .dw sprite  ;;sprite (2B)
                             12 .endm
                             13 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              3 .globl _uno
                              4 .globl _fuego
   44F0                       5     Entidad jugador,0,10,10,0,0,4,8,_uno
   0000                       1     jugador::
   44F0 00                    2         .db 0    ;;tipo
   44F1 0A                    3         .db 10       ;;x
   44F2 0A                    4         .db 10       ;;y
   44F3 00                    5         .db 0      ;;velocidadx
   44F4 00                    6         .db 0      ;;velocidady
   44F5 04                    7         .db 4   ;;ancho
   44F6 08                    8         .db 8    ;;ALto
   44F7 F4 41                 9         .dw _uno  ;;sprite (2B)
   44F9                       6     Entidad enemigo,10,10,10,10,0,4,8,_fuego
   0009                       1     enemigo::
   44F9 0A                    2         .db 10    ;;tipo
   44FA 0A                    3         .db 10       ;;x
   44FB 0A                    4         .db 10       ;;y
   44FC 0A                    5         .db 10      ;;velocidadx
   44FD 00                    6         .db 0      ;;velocidady
   44FE 04                    7         .db 4   ;;ancho
   44FF 08                    8         .db 8    ;;ALto
   4500 34 42                 9         .dw _fuego  ;;sprite (2B)
