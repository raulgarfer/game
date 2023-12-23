.module macro_struct.inc
;;macro para hacer un tipo similar a struct en C
.mdelete Begin_struct
.macro Begin_struct struct
    struct'_offset  =   0
.endm

.mdelete Struct_Field
.macro Struct_Field struct,size
    struct'_'Struct_Field   =  struct'_offset
    struct'_offset  =   struct'_offset + size
.endm

.mdelete End_struct
.macro End_struct
    sizeof_'struct = struct'_offset
.endm
