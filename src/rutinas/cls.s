.module cls
;;WWWWWWWWWWWWWWWWWWWWWWWWWWW
;;borra toda la pantalla
;;input DE direccion memoria (c000 o 8000)
;;MMMMMMMMMMMMMMMMMMMMMMMMMM
cls::
    ld a,#0
    ld h,d
    ld l,e
    ld (hl),a
    inc de
    ld bc,#0x4000-1
    ldir
ret