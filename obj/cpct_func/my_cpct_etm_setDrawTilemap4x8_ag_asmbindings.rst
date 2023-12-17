ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 
                              2 .module cpct_easytilemaps
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              3 .include "macros/cpct_opcodeConstants.h.s"
                              1 ;;-----------------------------LICENSE NOTICE------------------------------------
                              2 ;;  This file is part of CPCtelera: An Amstrad CPC Game Engine 
                              3 ;;  Copyright (C) 2016 ronaldo / Fremos / Cheesetea / ByteRealms (@FranGallegoBR)
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
                             18 
                             19 ;;
                             20 ;; File: Opcodes
                             21 ;;
                             22 ;;    Constant definitions of Z80 opcodes. This will be normally used as data
                             23 ;; for self-modifying code.
                             24 ;;
                             25 
                             26 ;; Constant: opc_JR
                             27 ;;    Opcode for "JR xx" instruction. Requires 1-byte parameter (xx)
                     0018    28 opc_JR   = 0x18
                             29 
                             30 ;; Constant: opc_LD_D
                             31 ;;    Opcode for "LD d, xx" instruction. Requires 1-byte parameter (xx)
                     0016    32 opc_LD_D = 0x16
                             33 
                             34 ;; Constant: opc_EI
                             35 ;;    Opcode for "EI" instruction. 
                     00FB    36 opc_EI = 0xFB
                             37 
                             38 ;; Constant: opc_DI
                             39 ;;    Opcode for "DI" instruction. 
                     00F3    40 opc_DI = 0xF3
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              4 .include "macros/cpct_maths.h.s"
                              1 ;;-----------------------------LICENSE NOTICE------------------------------------
                              2 ;;  This file is part of CPCtelera: An Amstrad CPC Game Engine 
                              3 ;;  Copyright (C) 2017 ronaldo / Fremos / Cheesetea / ByteRealms (@FranGallegoBR)
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
                             18 
                             19 ;;
                             20 ;; File: Math Macros
                             21 ;;
                             22 ;;    Useful assembler macros for doing common math operations
                             23 ;;
                             24 
                             25 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             26 ;; Macro: add_REGPAIR_a 
                             27 ;;
                             28 ;;    Performs the operation REGPAIR = REGPAIR + A. REGPAIR is any given pair of 8-bit registers.
                             29 ;;
                             30 ;; ASM Definition:
                             31 ;;    .macro <add_REGPAIR_a> RH, RL
                             32 ;;
                             33 ;; Parameters:
                             34 ;;    RH    - Register 1 of the REGPAIR. Holds higher-byte value
                             35 ;;    RL    - Register 2 of the REGPAIR. Holds lower-byte value
                             36 ;; 
                             37 ;; Input Registers: 
                             38 ;;    RH:RL - 16-value used as left-operand and final storage for the sum
                             39 ;;    A     - Second sum operand
                             40 ;;
                             41 ;; Return Value:
                             42 ;;    RH:RL - Holds the sum of RH:RL + A
                             43 ;;
                             44 ;; Details:
                             45 ;;    This macro performs the sum of RH:RL + A and stores it directly on RH:RL.
                             46 ;; It uses only RH:RL and A to perform the operation.
                             47 ;;
                             48 ;; Modified Registers: 
                             49 ;;    A, RH, RL
                             50 ;;
                             51 ;; Required memory:
                             52 ;;    5 bytes
                             53 ;;
                             54 ;; Time Measures:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                             55 ;; (start code)
                             56 ;;  Case | microSecs(us) | CPU Cycles
                             57 ;; ------------------------------------
                             58 ;;  Any  |       5       |     20
                             59 ;; ------------------------------------
                             60 ;; (end code)
                             61 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             62 .macro add_REGPAIR_a rh, rl
                             63    ;; First Perform RH = E + A
                             64    add rl    ;; [1] A' = RL + A 
                             65    ld  rl, a ;; [1] RL' = A' = RL + A. It might generate Carry that must be added to RH
                             66    
                             67    ;; Then Perform RH = RH + Carry 
                             68    adc rh    ;; [1] A'' = A' + RH + Carry = RL + A + RH + Carry
                             69    sub rl    ;; [1] Remove RL'. A''' = A'' - RL' = RL + A + RH + Carry - (RL + A) = RH + Carry
                             70    ld  rh, a ;; [1] Save into RH (RH' = A''' = RH + Carry)
                             71 .endm
                             72 
                             73 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             74 ;; Macro: add_de_a
                             75 ;;
                             76 ;;    Performs the operation DE = DE + A
                             77 ;;
                             78 ;; ASM Definition:
                             79 ;;    .macro <add_de_a>
                             80 ;;
                             81 ;; Parameters:
                             82 ;;    None
                             83 ;; 
                             84 ;; Input Registers: 
                             85 ;;    DE    - First sum operand and Destination Register
                             86 ;;    A     - Second sum operand
                             87 ;;
                             88 ;; Return Value:
                             89 ;;    DE - Holds the sum of DE + A
                             90 ;;
                             91 ;; Details:
                             92 ;;    This macro performs the sum of DE + A and stores it directly on DE.
                             93 ;; It uses only DE and A to perform the operation.
                             94 ;;    This macro is a direct instantiation of the macro <add_REGPAIR_a>.
                             95 ;;
                             96 ;; Modified Registers: 
                             97 ;;    A, DE
                             98 ;;
                             99 ;; Required memory:
                            100 ;;    5 bytes
                            101 ;;
                            102 ;; Time Measures:
                            103 ;; (start code)
                            104 ;;  Case | microSecs(us) | CPU Cycles
                            105 ;; ------------------------------------
                            106 ;;  Any  |       5       |     20
                            107 ;; ------------------------------------
                            108 ;; (end code)
                            109 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                            110 .macro add_de_a
                            111    add_REGPAIR_a  d, e
                            112 .endm
                            113 
                            114 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            115 ;; Macro: add_hl_a
                            116 ;;
                            117 ;;    Performs the operation HL = HL + A
                            118 ;;
                            119 ;; ASM Definition:
                            120 ;;    .macro <add_hl_a>
                            121 ;;
                            122 ;; Parameters:
                            123 ;;    None
                            124 ;; 
                            125 ;; Input Registers: 
                            126 ;;    HL    - First sum operand and Destination Register
                            127 ;;    A     - Second sum operand
                            128 ;;
                            129 ;; Return Value:
                            130 ;;    HL - Holds the sum of HL + A
                            131 ;;
                            132 ;; Details:
                            133 ;;    This macro performs the sum of HL + A and stores it directly on HL.
                            134 ;; It uses only HL and A to perform the operation.
                            135 ;;    This macro is a direct instantiation of the macro <add_REGPAIR_a>.
                            136 ;;
                            137 ;; Modified Registers: 
                            138 ;;    A, HL
                            139 ;;
                            140 ;; Required memory:
                            141 ;;    5 bytes
                            142 ;;
                            143 ;; Time Measures:
                            144 ;; (start code)
                            145 ;;  Case | microSecs(us) | CPU Cycles
                            146 ;; ------------------------------------
                            147 ;;  Any  |       5       |     20
                            148 ;; ------------------------------------
                            149 ;; (end code)
                            150 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            151 .macro add_hl_a
                            152    add_REGPAIR_a  h, l
                            153 .endm
                            154 
                            155 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            156 ;; Macro: add_bc_a
                            157 ;;
                            158 ;;    Performs the operation BC = BC + A
                            159 ;;
                            160 ;; ASM Definition:
                            161 ;;    .macro <add_bc_a>
                            162 ;;
                            163 ;; Parameters:
                            164 ;;    None
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                            165 ;; 
                            166 ;; Input Registers: 
                            167 ;;    BC    - First sum operand and Destination Register
                            168 ;;    A     - Second sum operand
                            169 ;;
                            170 ;; Return Value:
                            171 ;;    BC - Holds the sum of BC + A
                            172 ;;
                            173 ;; Details:
                            174 ;;    This macro performs the sum of BC + A and stores it directly on BC.
                            175 ;; It uses only BC and A to perform the operation.
                            176 ;;    This macro is a direct instantiation of the macro <add_REGPAIR_a>.
                            177 ;;
                            178 ;; Modified Registers: 
                            179 ;;    A, BC
                            180 ;;
                            181 ;; Required memory:
                            182 ;;    5 bytes
                            183 ;;
                            184 ;; Time Measures:
                            185 ;; (start code)
                            186 ;;  Case | microSecs(us) | CPU Cycles
                            187 ;; ------------------------------------
                            188 ;;  Any  |       5       |     20
                            189 ;; ------------------------------------
                            190 ;; (end code)
                            191 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            192 .macro add_bc_a
                            193    add_REGPAIR_a  b, c
                            194 .endm
                            195 
                            196 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            197 ;; Macro: sub_REGPAIR_a 
                            198 ;;
                            199 ;;    Performs the operation REGPAIR = REGPAIR - A. REGPAIR is any given pair of 8-bit registers.
                            200 ;;
                            201 ;; ASM Definition:
                            202 ;;    .macro <sub_REGPAIR_a> RH, RL
                            203 ;;
                            204 ;; Parameters:
                            205 ;;    RH    - Register 1 of the REGPAIR. Holds higher-byte value
                            206 ;;    RL    - Register 2 of the REGPAIR. Holds lower-byte value
                            207 ;;  ?JMPLBL - Optional Jump label. A temporal one will be produced if none is given.
                            208 ;; 
                            209 ;; Input Registers: 
                            210 ;;    RH:RL - 16-value used as left-operand and final storage for the subtraction
                            211 ;;    A     - Second subtraction operand (A > 0)
                            212 ;;
                            213 ;; Preconditions:
                            214 ;;    A > 0 - Value in register A is considered to be unsigned and must be greater
                            215 ;;            than 0 for this macro to work properly.
                            216 ;;
                            217 ;; Return Value:
                            218 ;;    RH:RL - Holds the result of RH:RL - A
                            219 ;;
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                            220 ;; Details:
                            221 ;;    This macro performs the subtraction of RH:RL - A and stores it directly on RH:RL.
                            222 ;; It uses only RH:RL and A to perform the operation.
                            223 ;;    With respect to the optional label ?JMPLBL, it is often better not to provide 
                            224 ;; this parameter. A temporal local symbol will be automatically generated for that label.
                            225 ;; Only provide it when you have a specific reason to do that.
                            226 ;;
                            227 ;; Modified Registers: 
                            228 ;;    A, RH, RL
                            229 ;;
                            230 ;; Required memory:
                            231 ;;    7 bytes
                            232 ;;
                            233 ;; Time Measures:
                            234 ;; (start code)
                            235 ;;  Case | microSecs(us) | CPU Cycles
                            236 ;; ------------------------------------
                            237 ;;  Any  |       7       |     28
                            238 ;; ------------------------------------
                            239 ;; (end code)
                            240 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            241 .macro sub_REGPAIR_a rh, rl, ?jmplbl
                            242    ;; First Perform A' = A - 1 - RL 
                            243    ;; (Inverse subtraction minus 1, used  to test for Carry, needed to know when to subtract 1 from RH)
                            244    dec    a          ;; [1] --A (In case A == RL, inverse subtraction should produce carry not to decrement RH)
                            245    sub   rl          ;; [1] A' = A - 1 - RL
                            246    jr     c, jmplbl  ;; [2/3] If A <= RL, Carry will be produced, and no decrement of RH is required, so jump over it
                            247      dec   rh        ;; [1] --RH (A > RL, so RH must be decremented)
                            248 jmplbl:   
                            249    ;; Now invert A to get the subtraction we wanted 
                            250    ;; { RL' = -A' - 1 = -(A - 1 - RL) - 1 = RL - A }
                            251    cpl            ;; [1] A'' = RL - A (Original subtraction we wanted, calculated trough one's complement of A')
                            252    ld    rl, a    ;; [1] Save into RL (RL' = RL - A)
                            253 .endm
                            254 
                            255 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            256 ;; Macro: sub_de_a 
                            257 ;;
                            258 ;;    Performs the operation DE = DE - A. DE is any given pair of 8-bit registers.
                            259 ;;
                            260 ;; ASM Definition:
                            261 ;;    .macro <sub_de_a>
                            262 ;; 
                            263 ;; Input Registers: 
                            264 ;;    DE - 16-value used as left-operand and final storage for the subtraction
                            265 ;;    A  - Second subtraction operand
                            266 ;;
                            267 ;; Return Value:
                            268 ;;    DE - Holds the result of DE - A
                            269 ;;
                            270 ;; Details:
                            271 ;;    This macro performs the subtraction of DE - A and stores it directly on DE.
                            272 ;; It uses only DE and A to perform the operation.
                            273 ;;
                            274 ;; Modified Registers: 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                            275 ;;    A, DE
                            276 ;;
                            277 ;; Required memory:
                            278 ;;    7 bytes
                            279 ;;
                            280 ;; Time Measures:
                            281 ;; (start code)
                            282 ;;  Case | microSecs(us) | CPU Cycles
                            283 ;; ------------------------------------
                            284 ;;  Any  |       7       |     28
                            285 ;; ------------------------------------
                            286 ;; (end code)
                            287 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            288 .macro sub_de_a
                            289    sub_REGPAIR_a  d, e
                            290 .endm
                            291 
                            292 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            293 ;; Macro: sub_hl_a 
                            294 ;;
                            295 ;;    Performs the operation HL = HL - A. HL is any given pair of 8-bit registers.
                            296 ;;
                            297 ;; ASM Definition:
                            298 ;;    .macro <sub_hl_a>
                            299 ;; 
                            300 ;; Input Registers: 
                            301 ;;    HL - 16-value used as left-operand and final storage for the subtraction
                            302 ;;    A  - Second subtraction operand
                            303 ;;
                            304 ;; Return Value:
                            305 ;;    HL - Holds the result of HL - A
                            306 ;;
                            307 ;; Details:
                            308 ;;    This macro performs the subtraction of HL - A and stores it directly on HL.
                            309 ;; It uses only HL and A to perform the operation.
                            310 ;;
                            311 ;; Modified Registers: 
                            312 ;;    A, HL
                            313 ;;
                            314 ;; Required memory:
                            315 ;;    7 bytes
                            316 ;;
                            317 ;; Time Measures:
                            318 ;; (start code)
                            319 ;;  Case | microSecs(us) | CPU Cycles
                            320 ;; ------------------------------------
                            321 ;;  Any  |       7       |     28
                            322 ;; ------------------------------------
                            323 ;; (end code)
                            324 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            325 .macro sub_hl_a
                            326    sub_REGPAIR_a  h, l
                            327 .endm
                            328 
                            329 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



                            330 ;; Macro: sub_bc_a 
                            331 ;;
                            332 ;;    Performs the operation BC = BC - A. BC is any given pair of 8-bit registers.
                            333 ;;
                            334 ;; ASM Definition:
                            335 ;;    .macro <sub_bc_a>
                            336 ;; 
                            337 ;; Input Registers: 
                            338 ;;    BC - 16-value used as left-operand and final storage for the subtraction
                            339 ;;    A  - Second subtraction operand
                            340 ;;
                            341 ;; Return Value:
                            342 ;;    BC - Holds the result of BC - A
                            343 ;;
                            344 ;; Details:
                            345 ;;    This macro performs the subtraction of BC - A and stores it directly on BC.
                            346 ;; It uses only BC and A to perform the operation.
                            347 ;;
                            348 ;; Modified Registers: 
                            349 ;;    A, BC
                            350 ;;
                            351 ;; Required memory:
                            352 ;;    7 bytes
                            353 ;;
                            354 ;; Time Measures:
                            355 ;; (start code)
                            356 ;;  Case | microSecs(us) | CPU Cycles
                            357 ;; ------------------------------------
                            358 ;;  Any  |       7       |     28
                            359 ;; ------------------------------------
                            360 ;; (end code)
                            361 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            362 .macro sub_bc_a
                            363    sub_REGPAIR_a  b, c
                            364 .endm
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



                              5 
                              6 ;;
                              7 ;; ASM bindings for <cpct_etm_setDrawTilemap4x8_ag_asm>
                              8 ;;
                              9 ;; 0 microseconds, 0 bytes
                             10 ;;
   461F                      11 my_cpct_etm_setDrawTilemap4x8_ag_asm::
                             12 
                             13 ;;.include /cpct_etm_setDrawTilemap4x8_ag.asm/
                             14 ;;.include src/cpct_func/my_cpct_etm_setDrawTilemap4x8_ag.asm
                             15 
                             16 .macro my_setDrawTilemap4x8_ag_gen lblPrf
                             17 
                             18 ;; Declare global symbols used here
                             19 .globl lblPrf'tilesetPtr
                             20 .globl lblPrf'widthHeightSet
                             21 .globl lblPrf'restoreWidth
                             22 .globl lblPrf'updateWidth
                             23 .globl lblPrf'incrementHL
                             24 .globl lblPrf'restoreI
                             25 
                             26    ;; Set (tilesetPtr) placeholder
                             27    ld (lblPrf'tilesetPtr), hl     ;; [5] Save HL into tilesetPtr placeholder
                             28 
                             29    ;; Set all Width values required by drawTileMap4x8_ag. First two values
                             30    ;; (heightSet, widthSet) are values used at the start of the function for
                             31    ;; initialization. The other one (restoreWidth) restores the value of the
                             32    ;; width after each loop, as it is used as counter and decremented to 0.
                             33    ld (lblPrf'widthHeightSet), bc ;; [6]
                             34    ld     a, c                    ;; [1]
                             35    ld (lblPrf'restoreWidth), a    ;; [4] Set restore width after each loop placeholder
                             36    
                             37    ;; In order to properly show a view of (Width x Height) tiles from within the
                             38    ;; tilemap, every time a row has been drawn, we need to move tilemap pointer
                             39    ;; to the start of the next row. As the complete tilemap is (tilemapWidth) bytes
                             40    ;; wide and we are showing a view only (Width) tiles wide, to complete (tilemapWidth)
                             41    ;; bytes at each loop, we need to add (tilemapWidth - Width) bytes.
                             42    sub_de_a                      ;; [7] tilemapWidth - Width
                             43    ld (lblPrf'updateWidth), de   ;; [6] set the difference in updateWidth placeholder
                             44 
                             45    ;; Calculate HL update that has to be performed for each new row loop.
                             46    ;; HL advances through video memory as tiles are being drawn. When a row
                             47    ;; is completely drawn, HL is at the right-most place of the screen.
                             48    ;; As each screen row has a width of 0x50 bytes (in standard modes), 
                             49    ;; if the Row that has been drawn has less than 0x50 bytes, this difference
                             50    ;; has to be added to HL to make it point to the start of next screen row.
                             51    ;; As each tile is 4-bytes wide, this amount is (0x50 - 4*Width). Also,
                             52    ;; taking into account that 4*Width cannot exceed 255 (1-byte), a maximum
                             53    ;; of 63 tiles can be considered as Width.
                             54    ld     a, c                ;; [1] A = Width
                             55    add    a                   ;; [1] A = 2*Width
                             56    add    a                   ;; [1] A = 4*Width
                             57    cpl                        ;; [1] A = -4*Width - 1
                             58    add #0x50 + 1              ;; [2] A = -4*Width-1 + 0x50+1 = 0x50 - 4*Width
                             59    ld (lblPrf'incrementHL), a ;; [4] Set HL increment in its placeholder
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



                             60 
                             61    ;; Set the restoring of Interrupt Status. drawTileMap4x8_ag disables interrupts before
                             62    ;; drawing each tile row, and then it restores previous interrupt status after the row
                             63    ;; has been drawn. To do this, present interrupt status is considered. This code detects
                             64    ;; present interrupt status and sets a EI/DI instruction at the end of tile row drawing
                             65    ;; to either reactivate interrupts or preserve interrupts disabled.
                             66    ld     a, i             ;; [3] P/V flag set to current interrupt status (IFF2 flip-flop)
                             67    ld     a, #opc_EI       ;; [2] A = Opcode for Enable Interrupts instruction (EI = 0xFB)
                             68    jp    pe, int_enabled   ;; [3] If interrupts are enabled, EI is the appropriate instruction
                             69      ld   a, #opc_DI       ;; [2] Otherwise, it is DI, so A = Opcode for Disable Interrupts instruction (DI = 0xF3)
                             70 int_enabled:
                             71    ld (lblPrf'restoreI), a ;; [4] Set the Restore Interrupt status at the end with corresponding DI or EI
                             72 
                             73    ret                     ;; [3] Return to caller
                             74 
                             75 .endm
                             76 
   0000                      77    my_setDrawTilemap4x8_ag_gen cpct_etm_dtm4x8_ag_asm_
                              1 
                              2 ;; Declare global symbols used here
                              3 .globl cpct_etm_dtm4x8_ag_asm_tilesetPtr
                              4 .globl cpct_etm_dtm4x8_ag_asm_widthHeightSet
                              5 .globl cpct_etm_dtm4x8_ag_asm_restoreWidth
                              6 .globl cpct_etm_dtm4x8_ag_asm_updateWidth
                              7 .globl cpct_etm_dtm4x8_ag_asm_incrementHL
                              8 .globl cpct_etm_dtm4x8_ag_asm_restoreI
                              9 
                             10    ;; Set (tilesetPtr) placeholder
   461F 22 9E 45      [16]   11    ld (cpct_etm_dtm4x8_ag_asm_tilesetPtr), hl     ;; [5] Save HL into tilesetPtr placeholder
                             12 
                             13    ;; Set all Width values required by drawTileMap4x8_ag. First two values
                             14    ;; (heightSet, widthSet) are values used at the start of the function for
                             15    ;; initialization. The other one (restoreWidth) restores the value of the
                             16    ;; width after each loop, as it is used as counter and decremented to 0.
   4622 ED 43 88 45   [20]   17    ld (cpct_etm_dtm4x8_ag_asm_widthHeightSet), bc ;; [6]
   4626 79            [ 4]   18    ld     a, c                    ;; [1]
   4627 32 14 46      [13]   19    ld (cpct_etm_dtm4x8_ag_asm_restoreWidth), a    ;; [4] Set restore width after each loop placeholder
                             20    
                             21    ;; In order to properly show a view of (Width x Height) tiles from within the
                             22    ;; tilemap, every time a row has been drawn, we need to move tilemap pointer
                             23    ;; to the start of the next row. As the complete tilemap is (tilemapWidth) bytes
                             24    ;; wide and we are showing a view only (Width) tiles wide, to complete (tilemapWidth)
                             25    ;; bytes at each loop, we need to add (tilemapWidth - Width) bytes.
   000B                      26    sub_de_a                      ;; [7] tilemapWidth - Width
   000B                       1    sub_REGPAIR_a  d, e
                              1    ;; First Perform A' = A - 1 - RL 
                              2    ;; (Inverse subtraction minus 1, used  to test for Carry, needed to know when to subtract 1 from RH)
   462A 3D            [ 4]    3    dec    a          ;; [1] --A (In case A == RL, inverse subtraction should produce carry not to decrement RH)
   462B 93            [ 4]    4    sub   e          ;; [1] A' = A - 1 - RL
   462C 38 01         [12]    5    jr     c, 10000$  ;; [2/3] If A <= RL, Carry will be produced, and no decrement of RH is required, so jump over it
   462E 15            [ 4]    6      dec   d        ;; [1] --RH (A > RL, so RH must be decremented)
   462F                       7 10000$:   
                              8    ;; Now invert A to get the subtraction we wanted 
                              9    ;; { RL' = -A' - 1 = -(A - 1 - RL) - 1 = RL - A }
   462F 2F            [ 4]   10    cpl            ;; [1] A'' = RL - A (Original subtraction we wanted, calculated trough one's complement of A')
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



   4630 5F            [ 4]   11    ld    e, a    ;; [1] Save into RL (RL' = RL - A)
   4631 ED 53 17 46   [20]   27    ld (cpct_etm_dtm4x8_ag_asm_updateWidth), de   ;; [6] set the difference in updateWidth placeholder
                             28 
                             29    ;; Calculate HL update that has to be performed for each new row loop.
                             30    ;; HL advances through video memory as tiles are being drawn. When a row
                             31    ;; is completely drawn, HL is at the right-most place of the screen.
                             32    ;; As each screen row has a width of 0x50 bytes (in standard modes), 
                             33    ;; if the Row that has been drawn has less than 0x50 bytes, this difference
                             34    ;; has to be added to HL to make it point to the start of next screen row.
                             35    ;; As each tile is 4-bytes wide, this amount is (0x50 - 4*Width). Also,
                             36    ;; taking into account that 4*Width cannot exceed 255 (1-byte), a maximum
                             37    ;; of 63 tiles can be considered as Width.
   4635 79            [ 4]   38    ld     a, c                ;; [1] A = Width
   4636 87            [ 4]   39    add    a                   ;; [1] A = 2*Width
   4637 87            [ 4]   40    add    a                   ;; [1] A = 4*Width
   4638 2F            [ 4]   41    cpl                        ;; [1] A = -4*Width - 1
   4639 C6 51         [ 7]   42    add #0x50 + 1              ;; [2] A = -4*Width-1 + 0x50+1 = 0x50 - 4*Width
   463B 32 0F 46      [13]   43    ld (cpct_etm_dtm4x8_ag_asm_incrementHL), a ;; [4] Set HL increment in its placeholder
                             44 
                             45    ;; Set the restoring of Interrupt Status. drawTileMap4x8_ag disables interrupts before
                             46    ;; drawing each tile row, and then it restores previous interrupt status after the row
                             47    ;; has been drawn. To do this, present interrupt status is considered. This code detects
                             48    ;; present interrupt status and sets a EI/DI instruction at the end of tile row drawing
                             49    ;; to either reactivate interrupts or preserve interrupts disabled.
   463E ED 57         [ 9]   50    ld     a, i             ;; [3] P/V flag set to current interrupt status (IFF2 flip-flop)
   4640 3E FB         [ 7]   51    ld     a, #opc_EI       ;; [2] A = Opcode for Enable Interrupts instruction (EI = 0xFB)
   4642 EA 47 46      [10]   52    jp    pe, int_enabled   ;; [3] If interrupts are enabled, EI is the appropriate instruction
   4645 3E F3         [ 7]   53      ld   a, #opc_DI       ;; [2] Otherwise, it is DI, so A = Opcode for Disable Interrupts instruction (DI = 0xF3)
   4647                      54 int_enabled:
   4647 32 09 46      [13]   55    ld (cpct_etm_dtm4x8_ag_asm_restoreI), a ;; [4] Set the Restore Interrupt status at the end with corresponding DI or EI
                             56 
   464A C9            [10]   57    ret                     ;; [3] Return to caller
                             58 
