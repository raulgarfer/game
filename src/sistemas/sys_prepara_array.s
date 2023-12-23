.module sys_prepara_array.s
.include "manager/macro_struct.inc"
.globl array_entidades
.globl primera_entidad_libre
.globl jugador
;;hl puntero entidad a aser copiada
copia_entidad_al_array::
    ld de,(primera_entidad_libre)
    ld bc, #10
    ldir
    ld (primera_entidad_libre),de
ret
crea_entidad::
    ld hl,#jugador
    call copia_entidad_al_array
ret

