
.module cpct_easytilemaps
.include "macros/cpct_opcodeConstants.h.s"
.include "macros/cpct_maths.h.s"

;;
;; ASM bindings for <cpct_etm_setDrawTilemap4x8_ag_asm>
;;
;; 0 microseconds, 0 bytes
;;
my_cpct_etm_setDrawTilemap4x8_ag_asm::

;;.include /cpct_etm_setDrawTilemap4x8_ag.asm/
;;.include src/cpct_func/my_cpct_etm_setDrawTilemap4x8_ag.asm

.macro my_setDrawTilemap4x8_ag_gen lblPrf

;; Declare global symbols used here
.globl lblPrf'tilesetPtr
.globl lblPrf'widthHeightSet
.globl lblPrf'restoreWidth
.globl lblPrf'updateWidth
.globl lblPrf'incrementHL
.globl lblPrf'restoreI

   ;; Set (tilesetPtr) placeholder
   ld (lblPrf'tilesetPtr), hl     ;; [5] Save HL into tilesetPtr placeholder

   ;; Set all Width values required by drawTileMap4x8_ag. First two values
   ;; (heightSet, widthSet) are values used at the start of the function for
   ;; initialization. The other one (restoreWidth) restores the value of the
   ;; width after each loop, as it is used as counter and decremented to 0.
   ld (lblPrf'widthHeightSet), bc ;; [6]
   ld     a, c                    ;; [1]
   ld (lblPrf'restoreWidth), a    ;; [4] Set restore width after each loop placeholder
   
   ;; In order to properly show a view of (Width x Height) tiles from within the
   ;; tilemap, every time a row has been drawn, we need to move tilemap pointer
   ;; to the start of the next row. As the complete tilemap is (tilemapWidth) bytes
   ;; wide and we are showing a view only (Width) tiles wide, to complete (tilemapWidth)
   ;; bytes at each loop, we need to add (tilemapWidth - Width) bytes.
   sub_de_a                      ;; [7] tilemapWidth - Width
   ld (lblPrf'updateWidth), de   ;; [6] set the difference in updateWidth placeholder

   ;; Calculate HL update that has to be performed for each new row loop.
   ;; HL advances through video memory as tiles are being drawn. When a row
   ;; is completely drawn, HL is at the right-most place of the screen.
   ;; As each screen row has a width of 0x50 bytes (in standard modes), 
   ;; if the Row that has been drawn has less than 0x50 bytes, this difference
   ;; has to be added to HL to make it point to the start of next screen row.
   ;; As each tile is 4-bytes wide, this amount is (0x50 - 4*Width). Also,
   ;; taking into account that 4*Width cannot exceed 255 (1-byte), a maximum
   ;; of 63 tiles can be considered as Width.
   ld     a, c                ;; [1] A = Width
   add    a                   ;; [1] A = 2*Width
   add    a                   ;; [1] A = 4*Width
   cpl                        ;; [1] A = -4*Width - 1
   add #0x50 + 1              ;; [2] A = -4*Width-1 + 0x50+1 = 0x50 - 4*Width
   ld (lblPrf'incrementHL), a ;; [4] Set HL increment in its placeholder

   ;; Set the restoring of Interrupt Status. drawTileMap4x8_ag disables interrupts before
   ;; drawing each tile row, and then it restores previous interrupt status after the row
   ;; has been drawn. To do this, present interrupt status is considered. This code detects
   ;; present interrupt status and sets a EI/DI instruction at the end of tile row drawing
   ;; to either reactivate interrupts or preserve interrupts disabled.
   ld     a, i             ;; [3] P/V flag set to current interrupt status (IFF2 flip-flop)
   ld     a, #opc_EI       ;; [2] A = Opcode for Enable Interrupts instruction (EI = 0xFB)
   jp    pe, int_enabled   ;; [3] If interrupts are enabled, EI is the appropriate instruction
     ld   a, #opc_DI       ;; [2] Otherwise, it is DI, so A = Opcode for Disable Interrupts instruction (DI = 0xF3)
int_enabled:
   ld (lblPrf'restoreI), a ;; [4] Set the Restore Interrupt status at the end with corresponding DI or EI

   ret                     ;; [3] Return to caller

.endm

   my_setDrawTilemap4x8_ag_gen cpct_etm_dtm4x8_ag_asm_
