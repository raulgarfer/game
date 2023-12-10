;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.8 #9946 (Linux)
;--------------------------------------------------------
	.module tiles_8x8_M0
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _tiles_8x8_7
	.globl _tiles_8x8_6
	.globl _tiles_8x8_5
	.globl _tiles_8x8_4
	.globl _tiles_8x8_3
	.globl _tiles_8x8_2
	.globl _tiles_8x8_1
	.globl _tiles_8x8_0
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
	.area _CODE
_tiles_8x8_0:
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc4	; 196
	.db #0xc4	; 196
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xc4	; 196
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc4	; 196
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xc0	; 192
	.db #0xc4	; 196
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc4	; 196
	.db #0xc0	; 192
_tiles_8x8_1:
	.db #0x9c	; 156
	.db #0x3c	; 60
	.db #0x9c	; 156
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x9c	; 156
	.db #0x3c	; 60
	.db #0x9c	; 156
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xc8	; 200
	.db #0x9c	; 156
	.db #0x9c	; 156
	.db #0x6c	; 108	'l'
	.db #0xcc	; 204
	.db #0x3c	; 60
	.db #0xc8	; 200
	.db #0xc4	; 196
	.db #0x9c	; 156
	.db #0x3c	; 60
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0x3c	; 60
	.db #0xcc	; 204
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x9c	; 156
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xcc	; 204
_tiles_8x8_2:
	.db #0x3c	; 60
	.db #0xc0	; 192
	.db #0x3c	; 60
	.db #0x6c	; 108	'l'
	.db #0x6c	; 108	'l'
	.db #0x94	; 148
	.db #0xc0	; 192
	.db #0x68	; 104	'h'
	.db #0xc4	; 196
	.db #0xc4	; 196
	.db #0xc0	; 192
	.db #0xc4	; 196
	.db #0x6c	; 108	'l'
	.db #0xc0	; 192
	.db #0xcc	; 204
	.db #0xc0	; 192
	.db #0x68	; 104	'h'
	.db #0xc0	; 192
	.db #0x94	; 148
	.db #0x68	; 104	'h'
	.db #0x6c	; 108	'l'
	.db #0x3c	; 60
	.db #0xc0	; 192
	.db #0x3c	; 60
	.db #0xc0	; 192
	.db #0xcc	; 204
	.db #0xc8	; 200
	.db #0x68	; 104	'h'
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc4	; 196
	.db #0xc0	; 192
_tiles_8x8_3:
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x68	; 104	'h'
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x94	; 148
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x68	; 104	'h'
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x94	; 148
	.db #0x3c	; 60
	.db #0x68	; 104	'h'
	.db #0x94	; 148
	.db #0x3c	; 60
_tiles_8x8_4:
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0x66	; 102	'f'
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x99	; 153
	.db #0x99	; 153
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x99	; 153
	.db #0x00	; 0
	.db #0x99	; 153
	.db #0x66	; 102	'f'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x88	; 136
	.db #0x44	; 68	'D'
	.db #0x00	; 0
	.db #0x44	; 68	'D'
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x88	; 136
	.db #0xcc	; 204
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0xcc	; 204
_tiles_8x8_5:
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc4	; 196
	.db #0xc4	; 196
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xc4	; 196
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc4	; 196
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xc0	; 192
	.db #0xc4	; 196
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc4	; 196
	.db #0xc0	; 192
_tiles_8x8_6:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xcc	; 204
	.db #0x88	; 136
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0x88	; 136
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0x88	; 136
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0x44	; 68	'D'
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_tiles_8x8_7:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.area _INITIALIZER
	.area _CABS (ABS)
