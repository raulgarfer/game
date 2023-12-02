#include "cpctelera.h"
//#include "media/sencillo.h"
//#include "media/tileset_32x8.h"
#include "media/tiles_16x8_M1.h"
#include "media/m1.h"
void pinta_mapa(){
    cpct_setVideoMode(1);
    cpct_setBorder(HW_BLACK);
    cpct_etm_setDrawTilemap4x8_ag(m1_sencillo_W,m1_sencillo_H,m1_sencillo_W,tiles_16x8_0);
    cpct_etm_drawTilemap4x8_ag(CPCT_VMEM_START,m1_sencillo);
}