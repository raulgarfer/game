##
## NEW MACROS
##

## 16 colours palette
#PALETTE=0 1 2 3 6 9 11 12 13 15 16 18 20 24 25 26
#PALETTE_M1=1 24 6 19

## Default values
#$(eval $(call IMG2SP, SET_MODE        , 0                  ))  
#$(eval $(call IMG2SP, SET_MASK        , none               ))  { interlaced, none }
$(eval $(call IMG2SP, SET_FOLDER      , src/media               ))
#$(eval $(call IMG2SP, SET_EXTRAPAR    ,                    ))
#$(eval $(call IMG2SP, SET_IMG_FORMAT  , sprites            ))	{ sprites, zgtiles, screen }
#$(eval $(call IMG2SP, SET_OUTPUT      , c                  ))  { bin, c }
#$(eval $(call IMG2SP, SET_PALETTE_FW  , $(PALETTE)         ))
#$(eval $(call IMG2SP, SET_PALETTE_FW  , $(PALETTE_M1)         ))

#$(eval $(call IMG2SP, CONVERT_PALETTE , $(PALETTE), g_palette ))
#$(eval $(call IMG2SP, CONVERT         , img.png , w, h, array, palette, tileset))
#$(eval $(call IMG2SP, SET_IMG_FORMAT  , sprites            ))
#$(eval $(call IMG2SP, SET_IMG_FORMAT  , zgtiles            ))
#$(eval $(call IMG2SP, CONVERT         , src/tiles/tileset_32x8.png , 8, 8, tileset_32x8))
$(eval $(call IMG2SP, SET_MODE        , 0                  ))  
$(eval $(call IMG2SP, SET_IMG_FORMAT  , zgtiles            ))
#$(eval $(call IMG2SP, SET_PALETTE_FW  , $(PALETTE)         ))
$(eval $(call IMG2SP, CONVERT         , src/sprites/tiles_8x8_M0.png , 8, 8, tiles_8x8))

$(eval $(call IMG2SP, SET_IMG_FORMAT  , sprites            ))
$(eval $(call IMG2SP, CONVERT         , src/sprites/fuego.png , 0, 0, fuego))
$(eval $(call IMG2SP, CONVERT         , src/sprites/uno.png , 0, 0, uno))
