.module setreg
;;preparamos el crt para pantall de 48*34 tiles,mode 0
setreg::
    ld    bc, #0xBC01  ;; [3] B=0xBC CRTC Select Register, C=register number to be selected
        out  (c), c             ;; [4] Select register
    ld    b, #0xBD  ;; [3] B=0xBD CRTC Set Register, C=Value to be set
    ld c,#32
        out  (c), c             ;; [4] Set the value
    ld bc,#0xbc02       ;;coloca el raster horizontal para cuadrarlo
        out (c),c
    ld b,#0xbd
    ld c,#0x2a
    ;;    out (c),c
   ;; ld b,#0xbc              ;;pone los registros para usar la memoria desde
   ;; ld c,#12                ;;8000 a ffff seguida.son unos 24kb de 32 usables
   ;;     out (c),c
   ;; ld bc,#0xbd2c
   ;;     out (c),c
   
   ;; ld bc,#0xbc06       ;;pone al alto de chars en 34
   ;;  ;;   out (c),c
   ;; ld b,#0xbd
   ;; ld c,#0x22
   ;;  ;;   out (c),c
   ;; ld bc,#0xbc07       ;;centra el scan vertical
   ;;     out (c),c
   ;; ld bc,#0xbd23
   ;;    ;; out (c),c
 ret