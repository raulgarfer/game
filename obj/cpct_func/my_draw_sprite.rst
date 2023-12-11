ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;-----------------------------LICENSE NOTICE------------------------------------
                              2 ;;  This file is part of CPCtelera: An Amstrad CPC Game Engine 
                              3 ;;  Copyright (C) 2014-2015 ronaldo / Fremos / Cheesetea / ByteRealms (@FranGallegoBR)
                              4 ;;
                              5 ;;  This program is free software: you can redistribute it and/or modify
                              6 ;;  it under the terms of the GNU Lesser General Public License as published by
                              7 ;;  the Free Software Foundation, either version 3 of the License, or
                              8 ;;  (at your option) any later version.
                              9 ;;
                             10 ;;  This program is distributed in the hope that it will be useful,
                             11 ;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
                             12 ;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                             13 ;;  GNU Lesser General Public License for more details.
                             14 ;;
                             15 ;;  You should have received a copy of the GNU Lesser General Public License
                             16 ;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.
                             17 ;;-------------------------------------------------------------------------------
                             18 .module my_cpct_sprites
                             19 
                             20 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             21 ;;
                             22 ;; Function: cpct_drawSprite
                             23 ;;
                             24 ;;    Copies a sprite from an array to video memory (or to a screen buffer).
                             25 ;;
                             26 ;; C Definition:
                             27 ;;    void <cpct_drawSprite> (void* *sprite*, void* *memory*, <u8> *width*, <u8> *height*) __z88dk_callee;
                             28 ;;
                             29 ;; Input Parameters (6 bytes):
                             30 ;;  (2B HL) sprite - Source Sprite Pointer (array with pixel data)
                             31 ;;  (2B DE) memory - Destination video memory pointer
                             32 ;;  (1B C ) width  - Sprite Width in *bytes* [1-63] (Beware, *not* in pixels!)
                             33 ;;  (1B B ) height - Sprite Height in bytes (>0)
                             34 ;;
                             35 ;; Assembly call (Input parameters on registers):
                             36 ;;    > call cpct_drawSprite_asm
                             37 ;;
                             38 ;; Parameter Restrictions:
                             39 ;;  * *sprite* must be an array containing sprite's pixels data in screen pixel format.
                             40 ;; Sprite must be rectangular and all bytes in the array must be consecutive pixels, 
                             41 ;; starting from top-left corner and going left-to-right, top-to-bottom down to the
                             42 ;; bottom-right corner. Total amount of bytes in pixel array should be *width* x *height*.
                             43 ;; You may check screen pixel format for mode 0 (<cpct_px2byteM0>) and mode 1 
                             44 ;; (<cpct_px2byteM1>) as for mode 2 is linear (1 bit = 1 pixel).
                             45 ;;  * *memory* could be any place in memory, inside or outside current video memory. It
                             46 ;; will be equally treated as video memory (taking into account CPC's video memory 
                             47 ;; disposition). This lets you copy sprites to software or hardware backbuffers, and
                             48 ;; not only video memory.
                             49 ;;  * *width* must be the width of the sprite *in bytes*, and must be in the range [1-63].
                             50 ;; A sprite width outside the range [1-63] will probably make the program hang or crash, 
                             51 ;; due to the optimization technique used. Always remember that the width must be 
                             52 ;; expressed in bytes and *not* in pixels. The correspondence is:
                             53 ;;    mode 0      - 1 byte = 2 pixels
                             54 ;;    modes 1 / 3 - 1 byte = 4 pixels
                             55 ;;    mode 2      - 1 byte = 8 pixels
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                             56 ;;  * *height* must be the height of the sprite in bytes, and must be greater than 0. 
                             57 ;; There is no practical upper limit to this value. Height of a sprite in
                             58 ;; bytes and pixels is the same value, as bytes only group consecutive pixels in
                             59 ;; the horizontal space.
                             60 ;;
                             61 ;; Known limitations:
                             62 ;;     * This function does not do any kind of boundary check or clipping. If you 
                             63 ;; try to draw sprites on the frontier of your video memory or screen buffer 
                             64 ;; if might potentially overwrite memory locations beyond boundaries. This 
                             65 ;; could cause your program to behave erratically, hang or crash. Always 
                             66 ;; take the necessary steps to guarantee that you are drawing inside screen
                             67 ;; or buffer boundaries.
                             68 ;;     * As this function receives a byte-pointer to memory, it can only 
                             69 ;; draw byte-sized and byte-aligned sprites. This means that the box cannot
                             70 ;; start on non-byte aligned pixels (like odd-pixels, for instance) and 
                             71 ;; their sizes must be a multiple of a byte (2 in mode 0, 4 in mode 1 and
                             72 ;; 8 in mode 2).
                             73 ;;     * This function *will not work from ROM*, as it uses self-modifying code.
                             74 ;;     * Although this function can be used under hardware-scrolling conditions,
                             75 ;; it does not take into account video memory wrap-around (0x?7FF or 0x?FFF 
                             76 ;; addresses, the end of character pixel lines).It  will produce a "step" 
                             77 ;; in the middle of sprites when drawing near wrap-around.
                             78 ;;
                             79 ;; Details:
                             80 ;;    This function copies a generic WxH bytes sprite from memory to a 
                             81 ;; video-memory location (either present video-memory or software / hardware  
                             82 ;; backbuffer). The original sprite must be stored as an array (i.e. with 
                             83 ;; all of its pixels stored as consecutive bytes in memory). It only works 
                             84 ;; for solid, rectangular sprites, with 1-63 bytes width
                             85 ;;
                             86 ;;    This function will just copy bytes, not taking care of colours or 
                             87 ;; transparencies. If you wanted to copy a sprite without erasing the background
                             88 ;; just check for masked sprites and <cpct_drawMaskedSprite>.
                             89 ;;
                             90 ;;    Copying a sprite to video memory is a complex operation due to the 
                             91 ;; particular distribution of screen pixels in CPC's video memory. At power on,
                             92 ;; video memory starts at address 0xC000 (it can be changed by BASIC's scroll,
                             93 ;; or using functions <cpct_setVideoMemoryPage> and <cpct_setVideoMemoryOffset>).
                             94 ;; This means that the byte at 0xC000 contains first pixels colour values, the ones
                             95 ;; at the top-left corner of the screen (2 first pixels in mode 0, 4 in mode 1 and 
                             96 ;; 8 in mode 2). Byte at 0xC001 contains next pixel values to the right, etc. 
                             97 ;; However, this configuration is not always linear. First 80 bytes encode the 
                             98 ;; first screen pixel line (line 0), next 80 bytes encode pixel line 8, next 
                             99 ;; 80 encode pixel line 16, and so on. Pixel line 1 start right next to pixel
                            100 ;; line 200 (the last one on screen), then goes pixel line 9, and so on. 
                            101 ;; 
                            102 ;; This particular distribution was thought to be used in 'characters' when it 
                            103 ;; was conceived. As a character has 8x8 pixels, pixel lines have a distribution
                            104 ;; in jumps of 8. This means that the screen has 25 character lines, each one
                            105 ;; with 8 pixel lines. This distribution is shown at table 1, depicting memory 
                            106 ;; locations where every pixel line starts, related to their character lines. 
                            107 ;; (start code)
                            108 ;; | Character   |  Pixel |  Pixel |  Pixel |  Pixel |  Pixel |  Pixel |  Pixel |  Pixel |
                            109 ;; |   Line      | Line 0 | Line 1 | Line 2 | Line 3 | Line 4 | Line 5 | Line 6 | Line 7 |
                            110 ;; ---------------------------------------------------------------------------------------
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                            111 ;; |      1      | 0xC000 | 0xC800 | 0xD000 | 0xD800 | 0xE000 | 0xE800 | 0xF000 | 0xF800 |
                            112 ;; |      2      | 0xC050 | 0xC850 | 0xD050 | 0xD850 | 0xE050 | 0xE850 | 0xF050 | 0xF850 |
                            113 ;; |      3      | 0xC0A0 | 0xC8A0 | 0xD0A0 | 0xD8A0 | 0xE0A0 | 0xE8A0 | 0xF0A0 | 0xF8A0 |
                            114 ;; |      4      | 0xC0F0 | 0xC8F0 | 0xD0F0 | 0xD8F0 | 0xE0F0 | 0xE8F0 | 0xF0F0 | 0xF8F0 |
                            115 ;; |      5      | 0xC140 | 0xC940 | 0xD140 | 0xD940 | 0xE140 | 0xE940 | 0xF140 | 0xF940 |
                            116 ;; |      6      | 0xC190 | 0xC990 | 0xD190 | 0xD990 | 0xE190 | 0xE990 | 0xF190 | 0xF990 |
                            117 ;; |      7      | 0xC1E0 | 0xC9E0 | 0xD1E0 | 0xD9E0 | 0xE1E0 | 0xE9E0 | 0xF1E0 | 0xF9E0 |
                            118 ;; |      8      | 0xC230 | 0xCA30 | 0xD230 | 0xDA30 | 0xE230 | 0xEA30 | 0xF230 | 0xFA30 |
                            119 ;; |      9      | 0xC280 | 0xCA80 | 0xD280 | 0xDA80 | 0xE280 | 0xEA80 | 0xF280 | 0xFA80 |
                            120 ;; |     10      | 0xC2D0 | 0xCAD0 | 0xD2D0 | 0xDAD0 | 0xE2D0 | 0xEAD0 | 0xF2D0 | 0xFAD0 |
                            121 ;; |     11      | 0xC320 | 0xCB20 | 0xD320 | 0xDB20 | 0xE320 | 0xEB20 | 0xF320 | 0xFB20 |
                            122 ;; |     12      | 0xC370 | 0xCB70 | 0xD370 | 0xDB70 | 0xE370 | 0xEB70 | 0xF370 | 0xFB70 |
                            123 ;; |     13      | 0xC3C0 | 0xCBC0 | 0xD3C0 | 0xDBC0 | 0xE3C0 | 0xEBC0 | 0xF3C0 | 0xFBC0 |
                            124 ;; |     14      | 0xC410 | 0xCC10 | 0xD410 | 0xDC10 | 0xE410 | 0xEC10 | 0xF410 | 0xFC10 |
                            125 ;; |     15      | 0xC460 | 0xCC60 | 0xD460 | 0xDC60 | 0xE460 | 0xEC60 | 0xF460 | 0xFC60 |
                            126 ;; |     16      | 0xC4B0 | 0xCCB0 | 0xD4B0 | 0xDCB0 | 0xE4B0 | 0xECB0 | 0xF4B0 | 0xFCB0 |
                            127 ;; |     17      | 0xC500 | 0xCD00 | 0xD500 | 0xDD00 | 0xE500 | 0xED00 | 0xF500 | 0xFD00 |
                            128 ;; |     18      | 0xC550 | 0xCD50 | 0xD550 | 0xDD50 | 0xE550 | 0xED50 | 0xF550 | 0xFD50 |
                            129 ;; |     19      | 0xC5A0 | 0xCDA0 | 0xD5A0 | 0xDDA0 | 0xE5A0 | 0xEDA0 | 0xF5A0 | 0xFDA0 |
                            130 ;; |     20      | 0xC5F0 | 0xCDF0 | 0xD5F0 | 0xDDF0 | 0xE5F0 | 0xED50 | 0xF550 | 0xFD50 |
                            131 ;; |     21      | 0xC640 | 0xCE40 | 0xD640 | 0xDE40 | 0xE640 | 0xEE40 | 0xF640 | 0xFE40 |
                            132 ;; |     22      | 0xC690 | 0xCE90 | 0xD690 | 0xDE90 | 0xE690 | 0xEE90 | 0xF690 | 0xFE90 |
                            133 ;; |     23      | 0xC6E0 | 0xCEE0 | 0xD6E0 | 0xDEE0 | 0xE6E0 | 0xEEE0 | 0xF6E0 | 0xFEE0 |
                            134 ;; |     24      | 0xC730 | 0xCF30 | 0xD730 | 0xDF30 | 0xE730 | 0xEF30 | 0xF730 | 0xFF30 |
                            135 ;; |     25      | 0xC780 | 0xCF80 | 0xD780 | 0xDF80 | 0xE780 | 0xEF80 | 0xF780 | 0xFF80 |
                            136 ;; | spare start | 0xC7D0 | 0xCFD0 | 0xD7D0 | 0xDFD0 | 0xE7D0 | 0xEFD0 | 0xF7D0 | 0xFFD0 |
                            137 ;; | spare end   | 0xC7FF | 0xCFFF | 0xD7FF | 0xDFFF | 0xE7FF | 0xEFFF | 0xF7FF | 0xFFFF |
                            138 ;; ---------------------------------------------------------------------------------------
                            139 ;;           Table 1 - Video memory starting locations for all pixel lines 
                            140 ;; (end)
                            141 ;;    *Note on how to interpret Table 1*: Table 1 contains starting video memory locations 
                            142 ;; for all 200 pixel lines on the screen (with default configuration). To know where does 
                            143 ;; a particular pixel line start, please read Table 1 left-to-right, top-to-bottom. So, 
                            144 ;; ROW 1 at Table 1 contains the memory start locations for the first 8 pixel lines on 
                            145 ;; screen (0 to 7), ROW 2 refers to pixel lines 8 to 15, ROW 3 has pixel lines 16 to 23, 
                            146 ;; and so on.
                            147 ;;
                            148 ;; Destroyed Register values: 
                            149 ;;    AF, BC, DE, HL
                            150 ;;
                            151 ;; Required memory:
                            152 ;;     C-bindings - 165 bytes
                            153 ;;   ASM-bindings - 160 bytes
                            154 ;;
                            155 ;; Time Measures:
                            156 ;; (start code)
                            157 ;;  Case      |   microSecs (us)       |        CPU Cycles
                            158 ;; ----------------------------------------------------------------
                            159 ;;  Best      | 20 + (21 + 5W)H + 9HH  | 80 + (84 + 20W)H + 36HH
                            160 ;;  Worst     |       Best + 9         |      Best + 36
                            161 ;; ----------------------------------------------------------------
                            162 ;;  W=2,H=16  |        525 /  534      |   2100 / 2136
                            163 ;;  W=4,H=32  |       1359 / 1368      |   5436 / 5472
                            164 ;; ----------------------------------------------------------------
                            165 ;; Asm saving |         -16            |        -64
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                            166 ;; ----------------------------------------------------------------
                            167 ;; (end code)
                            168 ;;    W = *width* in bytes, H = *height* in bytes, HH = [(H-1)/8]
                            169 ;;
                            170 ;; Credits:
                            171 ;;    This routine was inspired in the original *cpc_PutSprite* from
                            172 ;; CPCRSLib by Raul Simarro.
                            173 ;;
                            174 ;;    Thanks to *Mochilote* / <CPCMania at http://cpcmania.com> for creating the original
                            175 ;; <video memory locations table at 
                            176 ;; http://www.cpcmania.com/Docs/Programming/Painting_pixels_introduction_to_video_memory.htm>.
                            177 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   51FC                     178 my_draw_sprite::
                            179    ;; Modify code using width to jump in drawSpriteWidth
   51FC 3E 7E         [ 7]  180    ld    a, #126           ;; [2] We need to jump 126 bytes (63 LDIs*2 bytes) minus the width of the sprite * 2 (2B)
   51FE 91            [ 4]  181    sub   c                 ;; [1]    to do as much LDIs as bytes the Sprite is wide
   51FF 91            [ 4]  182    sub   c                 ;; [1]
   5200 32 0A 52      [13]  183    ld (ds_drawSpriteWidth+#4), a ;; [4] Modify JR data to create the jump we need
                            184 
   5203 78            [ 4]  185    ld    a, b              ;; [1] A = Height (used as counter for the number of lines we have to copy)
   5204 EB            [ 4]  186    ex   de, hl             ;; [1] Instead of jumping over the next line, we do the inverse operation because 
                            187                            ;; .... it is only 4 cycles and not 10, as a JP would be)
                            188 
   5205                     189 ds_drawSpriteWidth_next:
                            190    ;; NEXT LINE
   5205 EB            [ 4]  191    ex   de, hl             ;; [1] HL and DE are exchanged every line to do 16bit maths with DE. 
                            192                            ;; .... This line reverses it before proceeding to copy the next line.
   5206                     193 ds_drawSpriteWidth:
                            194    ;; Draw a sprite-line of n bytes
   5206 01 00 08      [10]  195    ld   bc, #0x800  ;; [3] 0x800 bytes is the distance in memory from one pixel line to the next within every 8 pixel lines
                            196                     ;; ... Each LDI performed will decrease this by 1, as we progress through memory copying the present line
   5209 18 00               197    .DW #0x0018            ;; [3] Self modifying instruction: the '00' will be substituted by the required jump forward. 
                            198                     ;; ... (Note: Writting JR 0 compiles but later it gives odd linking errors)
   520B ED A0         [16]  199    ldi              ;; [5] <| 63 LDIs, which are able to copy up to 63 bytes each time.
   520D ED A0         [16]  200    ldi              ;; [5]  | That means that each Sprite line should be 63 bytes width at most.
   520F ED A0         [16]  201    ldi              ;; [5]  | The JR instruction at the start makes us ignore the LDIs we don't need 
   5211 ED A0         [16]  202    ldi              ;; [5] <| (jumping over them) That ensures we will be doing only as much LDIs 
   5213 ED A0         [16]  203    ldi              ;; [5] <| as bytes our sprite is wide.
   5215 ED A0         [16]  204    ldi              ;; [5]  |
   5217 ED A0         [16]  205    ldi              ;; [5]  |
   5219 ED A0         [16]  206    ldi              ;; [5] <|
   521B ED A0         [16]  207    ldi              ;; [5] <|
   521D ED A0         [16]  208    ldi              ;; [5]  |
   521F ED A0         [16]  209    ldi              ;; [5]  |
   5221 ED A0         [16]  210    ldi              ;; [5] <|
   5223 ED A0         [16]  211    ldi              ;; [5] <|
   5225 ED A0         [16]  212    ldi              ;; [5]  |
   5227 ED A0         [16]  213    ldi              ;; [5]  |
   5229 ED A0         [16]  214    ldi              ;; [5] <|
   522B ED A0         [16]  215    ldi              ;; [5] <|
   522D ED A0         [16]  216    ldi              ;; [5]  |
   522F ED A0         [16]  217    ldi              ;; [5]  |
   5231 ED A0         [16]  218    ldi              ;; [5] <|
   5233 ED A0         [16]  219    ldi              ;; [5]  |
   5235 ED A0         [16]  220    ldi              ;; [5] <|
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



   5237 ED A0         [16]  221    ldi              ;; [5] <|
   5239 ED A0         [16]  222    ldi              ;; [5]  |
   523B ED A0         [16]  223    ldi              ;; [5]  |
   523D ED A0         [16]  224    ldi              ;; [5] <|
   523F ED A0         [16]  225    ldi              ;; [5] <|
   5241 ED A0         [16]  226    ldi              ;; [5]  |
   5243 ED A0         [16]  227    ldi              ;; [5]  |
   5245 ED A0         [16]  228    ldi              ;; [5] <|
   5247 ED A0         [16]  229    ldi              ;; [5]  |
   5249 ED A0         [16]  230    ldi              ;; [5] <|
   524B ED A0         [16]  231    ldi              ;; [5] <|
   524D ED A0         [16]  232    ldi              ;; [5]  |
   524F ED A0         [16]  233    ldi              ;; [5]  |
   5251 ED A0         [16]  234    ldi              ;; [5] <|
   5253 ED A0         [16]  235    ldi              ;; [5] <|
   5255 ED A0         [16]  236    ldi              ;; [5]  |
   5257 ED A0         [16]  237    ldi              ;; [5]  |
   5259 ED A0         [16]  238    ldi              ;; [5] <|
   525B ED A0         [16]  239    ldi              ;; [5]  |
   525D ED A0         [16]  240    ldi              ;; [5] <|
   525F ED A0         [16]  241    ldi              ;; [5] <|
   5261 ED A0         [16]  242    ldi              ;; [5]  |
   5263 ED A0         [16]  243    ldi              ;; [5]  |
   5265 ED A0         [16]  244    ldi              ;; [5] <|
   5267 ED A0         [16]  245    ldi              ;; [5] <|
   5269 ED A0         [16]  246    ldi              ;; [5]  |
   526B ED A0         [16]  247    ldi              ;; [5]  |
   526D ED A0         [16]  248    ldi              ;; [5] <|
   526F ED A0         [16]  249    ldi              ;; [5]  |
   5271 ED A0         [16]  250    ldi              ;; [5] <|
   5273 ED A0         [16]  251    ldi              ;; [5] <|
   5275 ED A0         [16]  252    ldi              ;; [5]  |
   5277 ED A0         [16]  253    ldi              ;; [5]  |
   5279 ED A0         [16]  254    ldi              ;; [5] <|
   527B ED A0         [16]  255    ldi              ;; [5] <|
   527D ED A0         [16]  256    ldi              ;; [5]  |
   527F ED A0         [16]  257    ldi              ;; [5]  |
   5281 ED A0         [16]  258    ldi              ;; [5] <|
   5283 ED A0         [16]  259    ldi              ;; [5] <|
   5285 ED A0         [16]  260    ldi              ;; [5]  |
   5287 ED A0         [16]  261    ldi              ;; [5]  |
                            262  
   5289 3D            [ 4]  263    dec   a          ;; [1] Another line finished: we discount it from A
   528A C8            [11]  264    ret   z          ;; [2/4] If that was the last line, we safely return
                            265 
                            266    ;; Jump destination pointer to the start of the next line in video memory
   528B EB            [ 4]  267    ex   de, hl      ;; [1] DE has destination, but we have to exchange it with HL to be able to do 16bit maths
   528C 09            [11]  268    add  hl, bc      ;; [3] We add 0x800 minus the width of the sprite (BC) to destination pointer 
   528D 47            [ 4]  269    ld    b, a       ;; [1] Save A into B (B = A)
   528E 7C            [ 4]  270    ld    a, h       ;; [1] We check if we have crossed video memory boundaries (which will happen every 8 lines). 
                            271                     ;; .... If that happens, bits 13,12 and 11 of destination pointer will be 0
   528F E6 38         [ 7]  272    and   #0x38      ;; [2] leave out only bits 13,12 and 11 from new memory address (00xxx000 00000000)
   5291 78            [ 4]  273    ld    a, b       ;; [1] Restore A from B (A = B)
   5292 C2 05 52      [10]  274    jp   nz, ds_drawSpriteWidth_next ;; [3] If any bit from {13,12,11} is not 0, we are still inside 
                            275                                     ;; .... video memory boundaries, so proceed with next line
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                            276 
                            277    ;; Every 8 lines, we cross the 16K video memory boundaries and have to
                            278    ;; reposition destination pointer. That means our next line is 16K-0x50 bytes back
                            279    ;; which is the same as advancing 48K+0x50 = 0xC050 bytes, as memory is 64K 
                            280    ;; and our 16bit pointers cycle over it
                            281    ;;
                            282    ;;aqui hay quew cambiar el bc para adpatarlo al ancho de pantalla
                            283    ;;
                            284    ;;ld   bc, #0xC050           ;; [3] We advance destination pointer to next line
   5295 01 60 C0      [10]  285    ld bc,#0xc060
   5298 09            [11]  286    add  hl, bc                ;; [3]  HL += 0xC050
   5299 C3 05 52      [10]  287    jp ds_drawSpriteWidth_next ;; [3] Continue copying
