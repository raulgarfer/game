                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.6.8 #9946 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module tiles_16x8_M1
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _tiles_16x8_3
                             12 	.globl _tiles_16x8_2
                             13 	.globl _tiles_16x8_1
                             14 	.globl _tiles_16x8_0
                             15 ;--------------------------------------------------------
                             16 ; special function registers
                             17 ;--------------------------------------------------------
                             18 ;--------------------------------------------------------
                             19 ; ram data
                             20 ;--------------------------------------------------------
                             21 	.area _DATA
                             22 ;--------------------------------------------------------
                             23 ; ram data
                             24 ;--------------------------------------------------------
                             25 	.area _INITIALIZED
                             26 ;--------------------------------------------------------
                             27 ; absolute external ram data
                             28 ;--------------------------------------------------------
                             29 	.area _DABS (ABS)
                             30 ;--------------------------------------------------------
                             31 ; global & static initialisations
                             32 ;--------------------------------------------------------
                             33 	.area _HOME
                             34 	.area _GSINIT
                             35 	.area _GSFINAL
                             36 	.area _GSINIT
                             37 ;--------------------------------------------------------
                             38 ; Home
                             39 ;--------------------------------------------------------
                             40 	.area _HOME
                             41 	.area _HOME
                             42 ;--------------------------------------------------------
                             43 ; code
                             44 ;--------------------------------------------------------
                             45 	.area _CODE
                             46 	.area _CODE
   4384                      47 _tiles_16x8_0:
   4384 FF                   48 	.db #0xff	; 255
   4385 FF                   49 	.db #0xff	; 255
   4386 F0                   50 	.db #0xf0	; 240
   4387 F0                   51 	.db #0xf0	; 240
   4388 F0                   52 	.db #0xf0	; 240
   4389 F0                   53 	.db #0xf0	; 240
   438A FF                   54 	.db #0xff	; 255
   438B FF                   55 	.db #0xff	; 255
   438C FF                   56 	.db #0xff	; 255
   438D FF                   57 	.db #0xff	; 255
   438E F0                   58 	.db #0xf0	; 240
   438F F0                   59 	.db #0xf0	; 240
   4390 F0                   60 	.db #0xf0	; 240
   4391 F0                   61 	.db #0xf0	; 240
   4392 FF                   62 	.db #0xff	; 255
   4393 FF                   63 	.db #0xff	; 255
   4394 FF                   64 	.db #0xff	; 255
   4395 FF                   65 	.db #0xff	; 255
   4396 F0                   66 	.db #0xf0	; 240
   4397 F0                   67 	.db #0xf0	; 240
   4398 F0                   68 	.db #0xf0	; 240
   4399 F0                   69 	.db #0xf0	; 240
   439A FF                   70 	.db #0xff	; 255
   439B FF                   71 	.db #0xff	; 255
   439C FF                   72 	.db #0xff	; 255
   439D FF                   73 	.db #0xff	; 255
   439E F0                   74 	.db #0xf0	; 240
   439F F0                   75 	.db #0xf0	; 240
   43A0 F0                   76 	.db #0xf0	; 240
   43A1 F0                   77 	.db #0xf0	; 240
   43A2 FF                   78 	.db #0xff	; 255
   43A3 FF                   79 	.db #0xff	; 255
   43A4                      80 _tiles_16x8_1:
   43A4 FF                   81 	.db #0xff	; 255
   43A5 FF                   82 	.db #0xff	; 255
   43A6 FF                   83 	.db #0xff	; 255
   43A7 FF                   84 	.db #0xff	; 255
   43A8 FF                   85 	.db #0xff	; 255
   43A9 FF                   86 	.db #0xff	; 255
   43AA FF                   87 	.db #0xff	; 255
   43AB FF                   88 	.db #0xff	; 255
   43AC FF                   89 	.db #0xff	; 255
   43AD FF                   90 	.db #0xff	; 255
   43AE FF                   91 	.db #0xff	; 255
   43AF FF                   92 	.db #0xff	; 255
   43B0 FF                   93 	.db #0xff	; 255
   43B1 FF                   94 	.db #0xff	; 255
   43B2 FF                   95 	.db #0xff	; 255
   43B3 FF                   96 	.db #0xff	; 255
   43B4 FF                   97 	.db #0xff	; 255
   43B5 FF                   98 	.db #0xff	; 255
   43B6 FF                   99 	.db #0xff	; 255
   43B7 FF                  100 	.db #0xff	; 255
   43B8 FF                  101 	.db #0xff	; 255
   43B9 FF                  102 	.db #0xff	; 255
   43BA FF                  103 	.db #0xff	; 255
   43BB FF                  104 	.db #0xff	; 255
   43BC FF                  105 	.db #0xff	; 255
   43BD FF                  106 	.db #0xff	; 255
   43BE FF                  107 	.db #0xff	; 255
   43BF FF                  108 	.db #0xff	; 255
   43C0 FF                  109 	.db #0xff	; 255
   43C1 FF                  110 	.db #0xff	; 255
   43C2 FF                  111 	.db #0xff	; 255
   43C3 FF                  112 	.db #0xff	; 255
   43C4                     113 _tiles_16x8_2:
   43C4 F0                  114 	.db #0xf0	; 240
   43C5 F0                  115 	.db #0xf0	; 240
   43C6 FF                  116 	.db #0xff	; 255
   43C7 FF                  117 	.db #0xff	; 255
   43C8 FF                  118 	.db #0xff	; 255
   43C9 FF                  119 	.db #0xff	; 255
   43CA F0                  120 	.db #0xf0	; 240
   43CB F0                  121 	.db #0xf0	; 240
   43CC F0                  122 	.db #0xf0	; 240
   43CD F0                  123 	.db #0xf0	; 240
   43CE FF                  124 	.db #0xff	; 255
   43CF FF                  125 	.db #0xff	; 255
   43D0 FF                  126 	.db #0xff	; 255
   43D1 FF                  127 	.db #0xff	; 255
   43D2 F0                  128 	.db #0xf0	; 240
   43D3 F0                  129 	.db #0xf0	; 240
   43D4 F0                  130 	.db #0xf0	; 240
   43D5 F0                  131 	.db #0xf0	; 240
   43D6 FF                  132 	.db #0xff	; 255
   43D7 FF                  133 	.db #0xff	; 255
   43D8 FF                  134 	.db #0xff	; 255
   43D9 FF                  135 	.db #0xff	; 255
   43DA F0                  136 	.db #0xf0	; 240
   43DB F0                  137 	.db #0xf0	; 240
   43DC F0                  138 	.db #0xf0	; 240
   43DD F0                  139 	.db #0xf0	; 240
   43DE FF                  140 	.db #0xff	; 255
   43DF FF                  141 	.db #0xff	; 255
   43E0 FF                  142 	.db #0xff	; 255
   43E1 FF                  143 	.db #0xff	; 255
   43E2 F0                  144 	.db #0xf0	; 240
   43E3 F0                  145 	.db #0xf0	; 240
   43E4                     146 _tiles_16x8_3:
   43E4 F0                  147 	.db #0xf0	; 240
   43E5 F0                  148 	.db #0xf0	; 240
   43E6 F0                  149 	.db #0xf0	; 240
   43E7 F0                  150 	.db #0xf0	; 240
   43E8 F0                  151 	.db #0xf0	; 240
   43E9 F0                  152 	.db #0xf0	; 240
   43EA F0                  153 	.db #0xf0	; 240
   43EB F0                  154 	.db #0xf0	; 240
   43EC F0                  155 	.db #0xf0	; 240
   43ED F0                  156 	.db #0xf0	; 240
   43EE F0                  157 	.db #0xf0	; 240
   43EF F0                  158 	.db #0xf0	; 240
   43F0 F0                  159 	.db #0xf0	; 240
   43F1 F0                  160 	.db #0xf0	; 240
   43F2 F0                  161 	.db #0xf0	; 240
   43F3 F0                  162 	.db #0xf0	; 240
   43F4 F0                  163 	.db #0xf0	; 240
   43F5 F0                  164 	.db #0xf0	; 240
   43F6 F0                  165 	.db #0xf0	; 240
   43F7 F0                  166 	.db #0xf0	; 240
   43F8 F0                  167 	.db #0xf0	; 240
   43F9 F0                  168 	.db #0xf0	; 240
   43FA F0                  169 	.db #0xf0	; 240
   43FB F0                  170 	.db #0xf0	; 240
   43FC F0                  171 	.db #0xf0	; 240
   43FD F0                  172 	.db #0xf0	; 240
   43FE F0                  173 	.db #0xf0	; 240
   43FF F0                  174 	.db #0xf0	; 240
   4400 F0                  175 	.db #0xf0	; 240
   4401 F0                  176 	.db #0xf0	; 240
   4402 F0                  177 	.db #0xf0	; 240
   4403 F0                  178 	.db #0xf0	; 240
                            179 	.area _INITIALIZER
                            180 	.area _CABS (ABS)
