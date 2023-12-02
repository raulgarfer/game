##
## NEW MACROS
##

## 16 colours palette
PALETTE=0 1 2 3 6 9 11 12 13 15 16 18 20 24 25 26
PALETTE_M1=0 1 2 3 

## Default values
$(eval $(call IMG2SP, SET_MODE        , 0                  ))  
#$(eval $(call IMG2SP, SET_MASK        , none               ))  { interlaced, none }
$(eval $(call IMG2SP, SET_FOLDER      , src/media               ))
#$(eval $(call IMG2SP, SET_EXTRAPAR    ,                    ))
#$(eval $(call IMG2SP, SET_IMG_FORMAT  , sprites            ))	{ sprites, zgtiles, screen }
#$(eval $(call IMG2SP, SET_OUTPUT      , c                  ))  { bin, c }
$(eval $(call IMG2SP, SET_PALETTE_FW  , $(PALETTE)         ))
$(eval $(call IMG2SP, SET_PALETTE_FW  , $(PALETTE_M1)         ))

#$(eval $(call IMG2SP, CONVERT_PALETTE , $(PALETTE), g_palette ))
#$(eval $(call IMG2SP, CONVERT         , img.png , w, h, array, palette, tileset))
$(eval $(call IMG2SP, SET_IMG_FORMAT  , sprites            ))
$(eval $(call IMG2SP, SET_IMG_FORMAT  , zgtiles            ))
$(eval $(call IMG2SP, CONVERT         , src/tiles/tileset_32x8.png , 8, 8, tileset_32x8))
$(eval $(call IMG2SP, SET_MODE        , 1                  ))  
$(eval $(call IMG2SP, SET_IMG_FORMAT  , zgtiles            ))
$(eval $(call IMG2SP, SET_PALETTE_FW  , $(PALETTE_M1)         ))
$(eval $(call IMG2SP, CONVERT         , src/sprites/tiles_16x8_M1.png , 16, 8, tiles_16x8))