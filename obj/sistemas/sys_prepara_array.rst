ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .module sys_prepara_array.s
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              2 .include "manager/macro_struct.inc"
                              1 .module macro_struct.inc
                              2 ;;macro para hacer un tipo similar a struct en C
                              3 .mdelete Begin_struct
                              4 .macro Begin_struct struct
                              5     struct'_offset  =   0
                              6 .endm
                              7 
                              8 .mdelete Struct_Field
                              9 .macro Struct_Field struct,size
                             10     struct'_'Struct_Field   =  struct'_offset
                             11     struct'_offset  =   struct'_offset + size
                             12 .endm
                             13 
                             14 .mdelete End_struct
                             15 .macro End_struct
                             16     sizeof_'struct = struct'_offset
                             17 .endm
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              3 .globl array_entidades
                              4 .globl primera_entidad_libre
                              5 .globl jugador
                              6 ;;hl puntero entidad a aser copiada
   45DE                       7 copia_entidad_al_array::
   45DE ED 5B EE 44   [20]    8     ld de,(primera_entidad_libre)
   45E2 01 0A 00      [10]    9     ld bc, #10
   45E5 ED B0         [21]   10     ldir
   45E7 ED 53 EE 44   [20]   11     ld (primera_entidad_libre),de
   45EB C9            [10]   12 ret
   45EC                      13 crea_entidad::
   45EC 21 F0 44      [10]   14     ld hl,#jugador
   45EF CD DE 45      [17]   15     call copia_entidad_al_array
   45F2 C9            [10]   16 ret
                             17 
