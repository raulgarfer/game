.module declaracion_entidades.s
.include "macros_entidad.inc"
.globl _uno
.globl _fuego
    Entidad jugador,0,10,10,0,0,4,8,_uno
    Entidad enemigo,10,10,10,10,0,4,8,_fuego
