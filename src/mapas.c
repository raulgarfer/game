#include "cpctelera.h"
//#include "media/sencillo.h"
//#include "media/tileset_32x8.h"
#include "media/tiles_8x8_M0.h"

#include "mapas/max.h"
extern const u8 PALETTE_M1;
void pinta_mapa(){
    cpct_setVideoMode(0);
    //cpct_setPalette(PALETTE_M1,4);
    cpct_setBorder(HW_BLACK);
    
    //cpct_etm_setDrawTilemap4x8_ag(max_W,max_H,max_W,tiles_8x8_0);
    //cpct_etm_drawTilemap4x8_ag(CPCT_VMEM_START,max);
}