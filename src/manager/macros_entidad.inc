.module macros_entidad.inc
.macro Entidad nombre,tipo,x,y,vx,vy,ancho,alto,sprite
    nombre::
        .db tipo    ;;tipo
        .db x       ;;x
        .db y       ;;y
        .db vx      ;;velocidadx
        .db vy      ;;velocidady
        .db ancho   ;;ancho
        .db alto    ;;ALto
        .dw sprite  ;;sprite (2B)
.endm

