ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .module my_cpct_sprites
                              2 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                              3 ;;
                              4 ;; Function: cpct_drawSprite
                              5 ;;
                              6 ;;    Copies a sprite from an array to video memory (or to a screen buffer).
                              7 ;;
                              8 ;; C Definition:
                              9 ;;    void <cpct_drawSprite> (void* *sprite*, void* *memory*, <u8> *width*, <u8> *height*) __z88dk_callee;
                             10 ;;
                             11 ;; Input Parameters (6 bytes):
                             12 ;;  (2B HL) sprite - Source Sprite Pointer (array with pixel data)
                             13 ;;  (2B DE) memory - Destination video memory pointer
                             14 ;;  (1B C ) width  - Sprite Width in *bytes* [1-63] (Beware, *not* in pixels!)
                             15 ;;  (1B B ) height - Sprite Height in bytes (>0)
                             16 ;;
                             17 ;; Assembly call (Input parameters on registers):
                             18 ;;    > call cpct_drawSprite_asm
                             19 ;;
                             20 ;; Parameter Restrictions:
                             21 ;;  * *sprite* must be an array containing sprite's pixels data in screen pixel format.
                             22 ;; Sprite must be rectangular and all bytes in the array must be consecutive pixels, 
                             23 ;; starting from top-left corner and going left-to-right, top-to-bottom down to the
                             24 ;; bottom-right corner. Total amount of bytes in pixel array should be *width* x *height*.
                             25 ;; You may check screen pixel format for mode 0 (<cpct_px2byteM0>) and mode 1 
                             26 ;; (<cpct_px2byteM1>) as for mode 2 is linear (1 bit = 1 pixel).
                             27 ;;  * *memory* could be any place in memory, inside or outside current video memory. It
                             28 ;; will be equally treated as video memory (taking into account CPC's video memory 
                             29 ;; disposition). This lets you copy sprites to software or hardware backbuffers, and
                             30 ;; not only video memory.
                             31 ;;  * *width* must be the width of the sprite *in bytes*, and must be in the range [1-63].
                             32 ;; A sprite width outside the range [1-63] will probably make the program hang or crash, 
                             33 ;; due to the optimization technique used. Always remember that the width must be 
                             34 ;; expressed in bytes and *not* in pixels. The correspondence is:
                             35 ;;    mode 0      - 1 byte = 2 pixels
                             36 ;;    modes 1 / 3 - 1 byte = 4 pixels
                             37 ;;    mode 2      - 1 byte = 8 pixels
                             38 ;;  * *height* must be the height of the sprite in bytes, and must be greater than 0. 
                             39 ;; There is no practical upper limit to this value. Height of a sprite in
                             40 ;; bytes and pixels is the same value, as bytes only group consecutive pixels in
                             41 ;; the horizontal space.
                             42 ;;
                             43 ;; Known limitations:
                             44 ;;     * This function does not do any kind of boundary check or clipping. If you 
                             45 ;; try to draw sprites on the frontier of your video memory or screen buffer 
                             46 ;; if might potentially overwrite memory locations beyond boundaries. This 
                             47 ;; could cause your program to behave erratically, hang or crash. Always 
                             48 ;; take the necessary steps to guarantee that you are drawing inside screen
                             49 ;; or buffer boundaries.
                             50 ;;     * As this function receives a byte-pointer to memory, it can only 
                             51 ;; draw byte-sized and byte-aligned sprites. This means that the box cannot
                             52 ;; start on non-byte aligned pixels (like odd-pixels, for instance) and 
                             53 ;; their sizes must be a multiple of a byte (2 in mode 0, 4 in mode 1 and
                             54 ;; 8 in mode 2).
                             55 ;;     * This function *will not work from ROM*, as it uses self-modifying code.
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                             56 ;;     * Although this function can be used under hardware-scrolling conditions,
                             57 ;; it does not take into account video memory wrap-around (0x?7FF or 0x?FFF 
                             58 ;; addresses, the end of character pixel lines).It  will produce a "step" 
                             59 ;; in the middle of sprites when drawing near wrap-around.
                             60 ;;
                             61 ;; Details:
                             62 ;;    This function copies a generic WxH bytes sprite from memory to a 
                             63 ;; video-memory location (either present video-memory or software / hardware  
                             64 ;; backbuffer). The original sprite must be stored as an array (i.e. with 
                             65 ;; all of its pixels stored as consecutive bytes in memory). It only works 
                             66 ;; for solid, rectangular sprites, with 1-63 bytes width
                             67 ;;
                             68 ;;    This function will just copy bytes, not taking care of colours or 
                             69 ;; transparencies. If you wanted to copy a sprite without erasing the background
                             70 ;; just check for masked sprites and <cpct_drawMaskedSprite>.
                             71 ;;
                             72 ;;    Copying a sprite to video memory is a complex operation due to the 
                             73 ;; particular distribution of screen pixels in CPC's video memory. At power on,
                             74 ;; video memory starts at address 0xC000 (it can be changed by BASIC's scroll,
                             75 ;; or using functions <cpct_setVideoMemoryPage> and <cpct_setVideoMemoryOffset>).
                             76 ;; This means that the byte at 0xC000 contains first pixels colour values, the ones
                             77 ;; at the top-left corner of the screen (2 first pixels in mode 0, 4 in mode 1 and 
                             78 ;; 8 in mode 2). Byte at 0xC001 contains next pixel values to the right, etc. 
                             79 ;; However, this configuration is not always linear. First 80 bytes encode the 
                             80 ;; first screen pixel line (line 0), next 80 bytes encode pixel line 8, next 
                             81 ;; 80 encode pixel line 16, and so on. Pixel line 1 start right next to pixel
                             82 ;; line 200 (the last one on screen), then goes pixel line 9, and so on. 
                             83 ;; 
                             84 ;; This particular distribution was thought to be used in 'characters' when it 
                             85 ;; was conceived. As a character has 8x8 pixels, pixel lines have a distribution
                             86 ;; in jumps of 8. This means that the screen has 25 character lines, each one
                             87 ;; with 8 pixel lines. This distribution is shown at table 1, depicting memory 
                             88 ;; locations where every pixel line starts, related to their character lines. 
                             89 ;; (start code)
                             90 ;; | Character   |  Pixel |  Pixel |  Pixel |  Pixel |  Pixel |  Pixel |  Pixel |  Pixel |
                             91 ;; |   Line      | Line 0 | Line 1 | Line 2 | Line 3 | Line 4 | Line 5 | Line 6 | Line 7 |
                             92 ;; ---------------------------------------------------------------------------------------
                             93 ;; |      1      | 0xC000 | 0xC800 | 0xD000 | 0xD800 | 0xE000 | 0xE800 | 0xF000 | 0xF800 |
                             94 ;; |      2      | 0xC050 | 0xC850 | 0xD050 | 0xD850 | 0xE050 | 0xE850 | 0xF050 | 0xF850 |
                             95 ;; |      3      | 0xC0A0 | 0xC8A0 | 0xD0A0 | 0xD8A0 | 0xE0A0 | 0xE8A0 | 0xF0A0 | 0xF8A0 |
                             96 ;; |      4      | 0xC0F0 | 0xC8F0 | 0xD0F0 | 0xD8F0 | 0xE0F0 | 0xE8F0 | 0xF0F0 | 0xF8F0 |
                             97 ;; |      5      | 0xC140 | 0xC940 | 0xD140 | 0xD940 | 0xE140 | 0xE940 | 0xF140 | 0xF940 |
                             98 ;; |      6      | 0xC190 | 0xC990 | 0xD190 | 0xD990 | 0xE190 | 0xE990 | 0xF190 | 0xF990 |
                             99 ;; |      7      | 0xC1E0 | 0xC9E0 | 0xD1E0 | 0xD9E0 | 0xE1E0 | 0xE9E0 | 0xF1E0 | 0xF9E0 |
                            100 ;; |      8      | 0xC230 | 0xCA30 | 0xD230 | 0xDA30 | 0xE230 | 0xEA30 | 0xF230 | 0xFA30 |
                            101 ;; |      9      | 0xC280 | 0xCA80 | 0xD280 | 0xDA80 | 0xE280 | 0xEA80 | 0xF280 | 0xFA80 |
                            102 ;; |     10      | 0xC2D0 | 0xCAD0 | 0xD2D0 | 0xDAD0 | 0xE2D0 | 0xEAD0 | 0xF2D0 | 0xFAD0 |
                            103 ;; |     11      | 0xC320 | 0xCB20 | 0xD320 | 0xDB20 | 0xE320 | 0xEB20 | 0xF320 | 0xFB20 |
                            104 ;; |     12      | 0xC370 | 0xCB70 | 0xD370 | 0xDB70 | 0xE370 | 0xEB70 | 0xF370 | 0xFB70 |
                            105 ;; |     13      | 0xC3C0 | 0xCBC0 | 0xD3C0 | 0xDBC0 | 0xE3C0 | 0xEBC0 | 0xF3C0 | 0xFBC0 |
                            106 ;; |     14      | 0xC410 | 0xCC10 | 0xD410 | 0xDC10 | 0xE410 | 0xEC10 | 0xF410 | 0xFC10 |
                            107 ;; |     15      | 0xC460 | 0xCC60 | 0xD460 | 0xDC60 | 0xE460 | 0xEC60 | 0xF460 | 0xFC60 |
                            108 ;; |     16      | 0xC4B0 | 0xCCB0 | 0xD4B0 | 0xDCB0 | 0xE4B0 | 0xECB0 | 0xF4B0 | 0xFCB0 |
                            109 ;; |     17      | 0xC500 | 0xCD00 | 0xD500 | 0xDD00 | 0xE500 | 0xED00 | 0xF500 | 0xFD00 |
                            110 ;; |     18      | 0xC550 | 0xCD50 | 0xD550 | 0xDD50 | 0xE550 | 0xED50 | 0xF550 | 0xFD50 |
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                            111 ;; |     19      | 0xC5A0 | 0xCDA0 | 0xD5A0 | 0xDDA0 | 0xE5A0 | 0xEDA0 | 0xF5A0 | 0xFDA0 |
                            112 ;; |     20      | 0xC5F0 | 0xCDF0 | 0xD5F0 | 0xDDF0 | 0xE5F0 | 0xED50 | 0xF550 | 0xFD50 |
                            113 ;; |     21      | 0xC640 | 0xCE40 | 0xD640 | 0xDE40 | 0xE640 | 0xEE40 | 0xF640 | 0xFE40 |
                            114 ;; |     22      | 0xC690 | 0xCE90 | 0xD690 | 0xDE90 | 0xE690 | 0xEE90 | 0xF690 | 0xFE90 |
                            115 ;; |     23      | 0xC6E0 | 0xCEE0 | 0xD6E0 | 0xDEE0 | 0xE6E0 | 0xEEE0 | 0xF6E0 | 0xFEE0 |
                            116 ;; |     24      | 0xC730 | 0xCF30 | 0xD730 | 0xDF30 | 0xE730 | 0xEF30 | 0xF730 | 0xFF30 |
                            117 ;; |     25      | 0xC780 | 0xCF80 | 0xD780 | 0xDF80 | 0xE780 | 0xEF80 | 0xF780 | 0xFF80 |
                            118 ;; | spare start | 0xC7D0 | 0xCFD0 | 0xD7D0 | 0xDFD0 | 0xE7D0 | 0xEFD0 | 0xF7D0 | 0xFFD0 |
                            119 ;; | spare end   | 0xC7FF | 0xCFFF | 0xD7FF | 0xDFFF | 0xE7FF | 0xEFFF | 0xF7FF | 0xFFFF |
                            120 ;; ---------------------------------------------------------------------------------------
                            121 ;;           Table 1 - Video memory starting locations for all pixel lines 
                            122 ;; (end)
                            123 ;;    *Note on how to interpret Table 1*: Table 1 contains starting video memory locations 
                            124 ;; for all 200 pixel lines on the screen (with default configuration). To know where does 
                            125 ;; a particular pixel line start, please read Table 1 left-to-right, top-to-bottom. So, 
                            126 ;; ROW 1 at Table 1 contains the memory start locations for the first 8 pixel lines on 
                            127 ;; screen (0 to 7), ROW 2 refers to pixel lines 8 to 15, ROW 3 has pixel lines 16 to 23, 
                            128 ;; and so on.
                            129 ;;
                            130 ;; Destroyed Register values: 
                            131 ;;    AF, BC, DE, HL
                            132 ;;
                            133 ;; Required memory:
                            134 ;;     C-bindings - 165 bytes
                            135 ;;   ASM-bindings - 160 bytes
                            136 ;;
                            137 ;; Time Measures:
                            138 ;; (start code)
                            139 ;;  Case      |   microSecs (us)       |        CPU Cycles
                            140 ;; ----------------------------------------------------------------
                            141 ;;  Best      | 20 + (21 + 5W)H + 9HH  | 80 + (84 + 20W)H + 36HH
                            142 ;;  Worst     |       Best + 9         |      Best + 36
                            143 ;; ----------------------------------------------------------------
                            144 ;;  W=2,H=16  |        525 /  534      |   2100 / 2136
                            145 ;;  W=4,H=32  |       1359 / 1368      |   5436 / 5472
                            146 ;; ----------------------------------------------------------------
                            147 ;; Asm saving |         -16            |        -64
                            148 ;; ----------------------------------------------------------------
                            149 ;; (end code)
                            150 ;;    W = *width* in bytes, H = *height* in bytes, HH = [(H-1)/8]
                            151 ;;
                            152 ;; Credits:
                            153 ;;    This routine was inspired in the original *cpc_PutSprite* from
                            154 ;; CPCRSLib by Raul Simarro.
                            155 ;;
                            156 ;;    Thanks to *Mochilote* / <CPCMania at http://cpcmania.com> for creating the original
                            157 ;; <video memory locations table at 
                            158 ;; http://www.cpcmania.com/Docs/Programming/Painting_pixels_introduction_to_video_memory.htm>.
                            159 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   46C4                     160 my_draw_sprite::
                            161    ;; Modify code using width to jump in drawSpriteWidth
   46C4 3E 7E         [ 7]  162    ld    a, #126           ;; [2] We need to jump 126 bytes (63 LDIs*2 bytes) minus the width of the sprite * 2 (2B)
   46C6 91            [ 4]  163    sub   c                 ;; [1]    to do as much LDIs as bytes the Sprite is wide
   46C7 91            [ 4]  164    sub   c                 ;; [1]
   46C8 32 D2 46      [13]  165    ld (ds_drawSpriteWidth+#4), a ;; [4] Modify JR data to create the jump we need
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                            166 
   46CB 78            [ 4]  167    ld    a, b              ;; [1] A = Height (used as counter for the number of lines we have to copy)
   46CC EB            [ 4]  168    ex   de, hl             ;; [1] Instead of jumping over the next line, we do the inverse operation because 
                            169                            ;; .... it is only 4 cycles and not 10, as a JP would be)
                            170 
   46CD                     171 ds_drawSpriteWidth_next:
                            172    ;; NEXT LINE
   46CD EB            [ 4]  173    ex   de, hl             ;; [1] HL and DE are exchanged every line to do 16bit maths with DE. 
                            174                            ;; .... This line reverses it before proceeding to copy the next line.
   46CE                     175 ds_drawSpriteWidth:
                            176    ;; Draw a sprite-line of n bytes
   46CE 01 00 08      [10]  177    ld   bc, #0x800  ;; [3] 0x800 bytes is the distance in memory from one pixel line to the next within every 8 pixel lines
                            178                     ;; ... Each LDI performed will decrease this by 1, as we progress through memory copying the present line
   46D1 18 00               179    .DW #0x0018            ;; [3] Self modifying instruction: the '00' will be substituted by the required jump forward. 
                            180                     ;; ... (Note: Writting JR 0 compiles but later it gives odd linking errors)
   46D3 ED A0         [16]  181    ldi              ;; [5] <| 63 LDIs, which are able to copy up to 63 bytes each time.
   46D5 ED A0         [16]  182    ldi              ;; [5]  | That means that each Sprite line should be 63 bytes width at most.
   46D7 ED A0         [16]  183    ldi              ;; [5]  | The JR instruction at the start makes us ignore the LDIs we don't need 
   46D9 ED A0         [16]  184    ldi              ;; [5] <| (jumping over them) That ensures we will be doing only as much LDIs 
   46DB ED A0         [16]  185    ldi              ;; [5] <| as bytes our sprite is wide.
   46DD ED A0         [16]  186    ldi              ;; [5]  |
   46DF ED A0         [16]  187    ldi              ;; [5]  |
   46E1 ED A0         [16]  188    ldi              ;; [5] <|
   46E3 ED A0         [16]  189    ldi              ;; [5] <|
   46E5 ED A0         [16]  190    ldi              ;; [5]  |
   46E7 ED A0         [16]  191    ldi              ;; [5]  |
   46E9 ED A0         [16]  192    ldi              ;; [5] <|
   46EB ED A0         [16]  193    ldi              ;; [5] <|
   46ED ED A0         [16]  194    ldi              ;; [5]  |
   46EF ED A0         [16]  195    ldi              ;; [5]  |
   46F1 ED A0         [16]  196    ldi              ;; [5] <|
   46F3 ED A0         [16]  197    ldi              ;; [5] <|
   46F5 ED A0         [16]  198    ldi              ;; [5]  |
   46F7 ED A0         [16]  199    ldi              ;; [5]  |
   46F9 ED A0         [16]  200    ldi              ;; [5] <|
   46FB ED A0         [16]  201    ldi              ;; [5]  |
   46FD ED A0         [16]  202    ldi              ;; [5] <|
   46FF ED A0         [16]  203    ldi              ;; [5] <|
   4701 ED A0         [16]  204    ldi              ;; [5]  |
   4703 ED A0         [16]  205    ldi              ;; [5]  |
   4705 ED A0         [16]  206    ldi              ;; [5] <|
   4707 ED A0         [16]  207    ldi              ;; [5] <|
   4709 ED A0         [16]  208    ldi              ;; [5]  |
   470B ED A0         [16]  209    ldi              ;; [5]  |
   470D ED A0         [16]  210    ldi              ;; [5] <|
   470F ED A0         [16]  211    ldi              ;; [5]  |
   4711 ED A0         [16]  212    ldi              ;; [5] <|
   4713 ED A0         [16]  213    ldi              ;; [5] <|
   4715 ED A0         [16]  214    ldi              ;; [5]  |
   4717 ED A0         [16]  215    ldi              ;; [5]  |
   4719 ED A0         [16]  216    ldi              ;; [5] <|
   471B ED A0         [16]  217    ldi              ;; [5] <|
   471D ED A0         [16]  218    ldi              ;; [5]  |
   471F ED A0         [16]  219    ldi              ;; [5]  |
   4721 ED A0         [16]  220    ldi              ;; [5] <|
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



   4723 ED A0         [16]  221    ldi              ;; [5]  |
   4725 ED A0         [16]  222    ldi              ;; [5] <|
   4727 ED A0         [16]  223    ldi              ;; [5] <|
   4729 ED A0         [16]  224    ldi              ;; [5]  |
   472B ED A0         [16]  225    ldi              ;; [5]  |
   472D ED A0         [16]  226    ldi              ;; [5] <|
   472F ED A0         [16]  227    ldi              ;; [5] <|
   4731 ED A0         [16]  228    ldi              ;; [5]  |
   4733 ED A0         [16]  229    ldi              ;; [5]  |
   4735 ED A0         [16]  230    ldi              ;; [5] <|
   4737 ED A0         [16]  231    ldi              ;; [5]  |
   4739 ED A0         [16]  232    ldi              ;; [5] <|
   473B ED A0         [16]  233    ldi              ;; [5] <|
   473D ED A0         [16]  234    ldi              ;; [5]  |
   473F ED A0         [16]  235    ldi              ;; [5]  |
   4741 ED A0         [16]  236    ldi              ;; [5] <|
   4743 ED A0         [16]  237    ldi              ;; [5] <|
   4745 ED A0         [16]  238    ldi              ;; [5]  |
   4747 ED A0         [16]  239    ldi              ;; [5]  |
   4749 ED A0         [16]  240    ldi              ;; [5] <|
   474B ED A0         [16]  241    ldi              ;; [5] <|
   474D ED A0         [16]  242    ldi              ;; [5]  |
   474F ED A0         [16]  243    ldi              ;; [5]  |
                            244  
   4751 3D            [ 4]  245    dec   a          ;; [1] Another line finished: we discount it from A
   4752 C8            [11]  246    ret   z          ;; [2/4] If that was the last line, we safely return
                            247 
                            248    ;; Jump destination pointer to the start of the next line in video memory
   4753 EB            [ 4]  249    ex   de, hl      ;; [1] DE has destination, but we have to exchange it with HL to be able to do 16bit maths
   4754 09            [11]  250    add  hl, bc      ;; [3] We add 0x800 minus the width of the sprite (BC) to destination pointer 
   4755 47            [ 4]  251    ld    b, a       ;; [1] Save A into B (B = A)
   4756 7C            [ 4]  252    ld    a, h       ;; [1] We check if we have crossed video memory boundaries (which will happen every 8 lines). 
                            253                     ;; .... If that happens, bits 13,12 and 11 of destination pointer will be 0
   4757 E6 38         [ 7]  254    and   #0x38      ;; [2] leave out only bits 13,12 and 11 from new memory address (00xxx000 00000000)
   4759 78            [ 4]  255    ld    a, b       ;; [1] Restore A from B (A = B)
   475A C2 CD 46      [10]  256    jp   nz, ds_drawSpriteWidth_next ;; [3] If any bit from {13,12,11} is not 0, we are still inside 
                            257                                     ;; .... video memory boundaries, so proceed with next line
                            258 
                            259    ;; Every 8 lines, we cross the 16K video memory boundaries and have to
                            260    ;; reposition destination pointer. That means our next line is 16K-0x50 bytes back
                            261    ;; which is the same as advancing 48K+0x50 = 0xC050 bytes, as memory is 64K 
                            262    ;; and our 16bit pointers cycle over it
                            263    ;;
                            264    ;;aqui hay quew cambiar el bc para adpatarlo al ancho de pantalla
                            265    ;;
                            266    ;;ld   bc, #0xC050           ;; [3] We advance destination pointer to next line
   475D 06 C0         [ 7]  267    ld b,#0xc0
                            268    ;;cuatro tiles menos, son ahora 16 en vez de 20
                            269    ;;le restamos 16,4 por cada tile de menos
                            270    ;;imagino que al ensancharlo sera al contrario
   475F 0E 50         [ 7]  271    ld c,#0x50;;-16
   4761 09            [11]  272    add  hl, bc                ;; [3]  HL += 0xC050
   4762 C3 CD 46      [10]  273    jp ds_drawSpriteWidth_next ;; [3] Continue copying
