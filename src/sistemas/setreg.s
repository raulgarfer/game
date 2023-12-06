.module setreg
;;preparamos el crt para pantall de 20*25 tiles
setreg::
 ld    bc, #0xBC01  ;; [3] B=0xBC CRTC Select Register, C=register number to be selected
 out  (c), c             ;; [4] Select register
 ld    bc, #0xBD30  ;; [3] B=0xBD CRTC Set Register, C=Value to be set
 out  (c), c             ;; [4] Set the value
 ret