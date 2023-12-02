#include "cpctelera.h"
#include "media/sencillo.h"
#include "media/tileset_32x8.h"
void pinta_mapa(){
    cpct_setVideoMode(0);
    cpct_setBorder(HW_BLACK);
    cpct_etm_setDrawTilemap4x8_ag(m_sencillo_W,m_sencillo_H,m_sencillo_W,tileset_32x8_0);
    cpct_etm_drawTilemap4x8_ag(CPCT_VMEM_START,m_sencillo);
}