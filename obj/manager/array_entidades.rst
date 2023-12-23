ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .module array_entidades.s
                              2 ;;creacion de array de entidades . multipicamos entidades por tamaño
   4489                       3 array_entidades::
   4489                       4     .ds 10*10
   44ED                       5 byte_fin::                  ;;byte a 0 para terminar array
   44ED 00                    6     .db 0
   44EE                       7 primera_entidad_libre::
   44EE 89 44                 8     .dw array_entidades
