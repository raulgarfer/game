.module array_entidades.s
;;creacion de array de entidades . multipicamos entidades por tamaño
array_entidades::
    .ds 10*10
byte_fin::                  ;;byte a 0 para terminar array
    .db 0
primera_entidad_libre::
    .dw array_entidades
