set DESIGN_NAME "system"  
set DESIGN $DESIGN_NAME

##########################################################################################
#         POR HACER!!!! REVISE QUE ESTAS RUTAS COINCIDAN CON LAS QUE ESTÁ TRABAJANDO
##########################################################################################
set WORK_DIR "$env(HOME)/ie0411/proyecto/2workspace/WORK" ; #ES NECESARIO MODIFICAR AL HOME USUARIO CORRECTO


##########################################################################################
# VARIABLES DE CONFIGURACIÓN DE LIBRERIA ; MODIFICAR CON CUIDADO
# PARA CADA LIBRERÍA UTILIZADA; DEBERÁ HABER 3 ESQUINAS
##########################################################################################

set DESIGN_REF_PATH		  "/share/synopsys/libs/SAED14nm_PDK"
set DESIGN_REF_TECH_PATH          "${DESIGN_REF_PATH}/tech"

set ADDITIONAL_SEARCH_PATH      " \
        ${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm \
        ${DESIGN_REF_PATH}/lib/stdcell_hvt/db_nldm \
        ${DESIGN_REF_PATH}/lib/stdcell_lvt/db_nldm \
	${DESIGN_REF_PATH}/lib/sram_lp/logic_synth/singlelp \
	${DESIGN_REF_PATH}/lib/io_std/db_nldm \
	${DESIGN_REF_PATH}/lib/io_sp/db_nldm "


#multi-voltage, multi-corner
set LINK_LIBRARY_FILES   "\
${DESIGN_REF_PATH}/lib/stdcell_lvt/db_nldm/saed14lvt_dlvl_tt0p8v25c_i0p8v.db \
${DESIGN_REF_PATH}/lib/stdcell_lvt/db_nldm/saed14lvt_dlvl_ff0p88v25c_i0p88v.db \
${DESIGN_REF_PATH}/lib/stdcell_lvt/db_nldm/saed14lvt_dlvl_ss0p72v25c_i0p72v.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_dlvl_tt0p8v25c_i0p8v.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_dlvl_ff0p88v25c_i0p88v.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_dlvl_ss0p72v25c_i0p72v.db \
${DESIGN_REF_PATH}/lib/stdcell_hvt/db_nldm/saed14hvt_dlvl_tt0p8v25c_i0p8v.db \
${DESIGN_REF_PATH}/lib/stdcell_hvt/db_nldm/saed14hvt_dlvl_ff0p88v25c_i0p88v.db \
${DESIGN_REF_PATH}/lib/stdcell_hvt/db_nldm/saed14hvt_dlvl_ss0p72v25c_i0p72v.db \
${DESIGN_REF_PATH}/lib/stdcell_lvt/db_nldm/saed14lvt_pg_tt0p8v25c.db \
${DESIGN_REF_PATH}/lib/stdcell_lvt/db_nldm/saed14lvt_pg_ff0p88v25c.db \
${DESIGN_REF_PATH}/lib/stdcell_lvt/db_nldm/saed14lvt_pg_ss0p72v25c.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_pg_tt0p8v25c.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_pg_ff0p88v25c.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_pg_ss0p72v25c.db \
${DESIGN_REF_PATH}/lib/stdcell_hvt/db_nldm/saed14hvt_pg_tt0p8v25c.db \
${DESIGN_REF_PATH}/lib/stdcell_hvt/db_nldm/saed14hvt_pg_ff0p88v25c.db \
${DESIGN_REF_PATH}/lib/stdcell_hvt/db_nldm/saed14hvt_pg_ss0p72v25c.db \
${DESIGN_REF_PATH}/lib/stdcell_lvt/db_nldm/saed14lvt_tt0p8v25c.db \
${DESIGN_REF_PATH}/lib/stdcell_lvt/db_nldm/saed14lvt_ss0p72v25c.db \
${DESIGN_REF_PATH}/lib/stdcell_lvt/db_nldm/saed14lvt_ff0p88v25c.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_tt0p8v25c.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_ss0p72v25c.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_ff0p88v25c.db \
${DESIGN_REF_PATH}/lib/stdcell_hvt/db_nldm/saed14hvt_tt0p8v25c.db \
${DESIGN_REF_PATH}/lib/stdcell_hvt/db_nldm/saed14hvt_ss0p72v25c.db \
${DESIGN_REF_PATH}/lib/stdcell_hvt/db_nldm/saed14hvt_ff0p88v25c.db \
${DESIGN_REF_PATH}/lib/stdcell_lvt/db_nldm/saed14lvt_ulvl_tt0p8v25c_i0p8v.db \
${DESIGN_REF_PATH}/lib/stdcell_lvt/db_nldm/saed14lvt_ulvl_ss0p72v25c_i0p72v.db \
${DESIGN_REF_PATH}/lib/stdcell_lvt/db_nldm/saed14lvt_ulvl_ff0p88v25c_i0p88v.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_ulvl_tt0p8v25c_i0p8v.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_ulvl_ss0p72v25c_i0p72v.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_ulvl_ff0p88v25c_i0p88v.db \
${DESIGN_REF_PATH}/lib/stdcell_hvt/db_nldm/saed14hvt_ulvl_tt0p8v25c_i0p8v.db \
${DESIGN_REF_PATH}/lib/stdcell_hvt/db_nldm/saed14hvt_ulvl_ss0p72v25c_i0p72v.db \
${DESIGN_REF_PATH}/lib/stdcell_hvt/db_nldm/saed14hvt_ulvl_ff0p88v25c_i0p88v.db \
${DESIGN_REF_PATH}/lib/sram/logic_synth/single/saed14sram_tt0p8v25c.db \
${DESIGN_REF_PATH}/lib/sram/logic_synth/single/saed14sram_ss0p72v25c.db \
${DESIGN_REF_PATH}/lib/sram/logic_synth/single/saed14sram_ff0p88v25c.db \
${DESIGN_REF_PATH}/lib/io_sp/db_nldm/saed14io_fc_sp_tt0p8v25c_1p8v.db \
${DESIGN_REF_PATH}/lib/io_sp/db_nldm/saed14io_fc_sp_ss0p72v25c_1p62v.db \
${DESIGN_REF_PATH}/lib/io_sp/db_nldm/saed14io_fc_sp_ff0p88v25c_1p96v.db \
${DESIGN_REF_PATH}/lib/io_sp/db_nldm/saed14io_wb_sp_tt0p8v25c_1p8v.db \
${DESIGN_REF_PATH}/lib/io_sp/db_nldm/saed14io_wb_sp_ss0p72v25c_1p62v.db \
${DESIGN_REF_PATH}/lib/io_sp/db_nldm/saed14io_wb_sp_ff0p88v25c_1p96v.db \
${DESIGN_REF_PATH}/lib/io_std/db_nldm/saed14io_fc_tt0p8v25c_1p8v.db \
${DESIGN_REF_PATH}/lib/io_std/db_nldm/saed14io_fc_ss0p72v25c_1p62v.db \
${DESIGN_REF_PATH}/lib/io_std/db_nldm/saed14io_fc_ff0p88v25c_1p96v.db \
${DESIGN_REF_PATH}/lib/io_std/db_nldm/saed14io_wb_tt0p8v25c_1p8v.db \
${DESIGN_REF_PATH}/lib/io_std/db_nldm/saed14io_wb_ss0p72v25c_1p62v.db \
${DESIGN_REF_PATH}/lib/io_std/db_nldm/saed14io_wb_ff0p88v25c_1p96v.db "

#multi-voltage, multi-corner
set TARGET_LIBRARY_FILES    "\
${DESIGN_REF_PATH}/lib/stdcell_lvt/db_nldm/saed14lvt_dlvl_tt0p8v25c_i0p8v.db \
${DESIGN_REF_PATH}/lib/stdcell_lvt/db_nldm/saed14lvt_dlvl_ff0p88v25c_i0p88v.db \
${DESIGN_REF_PATH}/lib/stdcell_lvt/db_nldm/saed14lvt_dlvl_ss0p72v25c_i0p72v.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_dlvl_tt0p8v25c_i0p8v.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_dlvl_ff0p88v25c_i0p88v.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_dlvl_ss0p72v25c_i0p72v.db \
${DESIGN_REF_PATH}/lib/stdcell_hvt/db_nldm/saed14hvt_dlvl_tt0p8v25c_i0p8v.db \
${DESIGN_REF_PATH}/lib/stdcell_hvt/db_nldm/saed14hvt_dlvl_ff0p88v25c_i0p88v.db \
${DESIGN_REF_PATH}/lib/stdcell_hvt/db_nldm/saed14hvt_dlvl_ss0p72v25c_i0p72v.db \
${DESIGN_REF_PATH}/lib/stdcell_lvt/db_nldm/saed14lvt_pg_tt0p8v25c.db \
${DESIGN_REF_PATH}/lib/stdcell_lvt/db_nldm/saed14lvt_pg_ff0p88v25c.db \
${DESIGN_REF_PATH}/lib/stdcell_lvt/db_nldm/saed14lvt_pg_ss0p72v25c.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_pg_tt0p8v25c.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_pg_ff0p88v25c.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_pg_ss0p72v25c.db \
${DESIGN_REF_PATH}/lib/stdcell_hvt/db_nldm/saed14hvt_pg_tt0p8v25c.db \
${DESIGN_REF_PATH}/lib/stdcell_hvt/db_nldm/saed14hvt_pg_ff0p88v25c.db \
${DESIGN_REF_PATH}/lib/stdcell_hvt/db_nldm/saed14hvt_pg_ss0p72v25c.db \
${DESIGN_REF_PATH}/lib/stdcell_lvt/db_nldm/saed14lvt_tt0p8v25c.db \
${DESIGN_REF_PATH}/lib/stdcell_lvt/db_nldm/saed14lvt_ss0p72v25c.db \
${DESIGN_REF_PATH}/lib/stdcell_lvt/db_nldm/saed14lvt_ff0p88v25c.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_tt0p8v25c.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_ss0p72v25c.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_ff0p88v25c.db \
${DESIGN_REF_PATH}/lib/stdcell_hvt/db_nldm/saed14hvt_tt0p8v25c.db \
${DESIGN_REF_PATH}/lib/stdcell_hvt/db_nldm/saed14hvt_ss0p72v25c.db \
${DESIGN_REF_PATH}/lib/stdcell_hvt/db_nldm/saed14hvt_ff0p88v25c.db \
${DESIGN_REF_PATH}/lib/stdcell_lvt/db_nldm/saed14lvt_ulvl_tt0p8v25c_i0p8v.db \
${DESIGN_REF_PATH}/lib/stdcell_lvt/db_nldm/saed14lvt_ulvl_ss0p72v25c_i0p72v.db \
${DESIGN_REF_PATH}/lib/stdcell_lvt/db_nldm/saed14lvt_ulvl_ff0p88v25c_i0p88v.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_ulvl_tt0p8v25c_i0p8v.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_ulvl_ss0p72v25c_i0p72v.db \
${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm/saed14rvt_ulvl_ff0p88v25c_i0p88v.db \
${DESIGN_REF_PATH}/lib/stdcell_hvt/db_nldm/saed14hvt_ulvl_tt0p8v25c_i0p8v.db \
${DESIGN_REF_PATH}/lib/stdcell_hvt/db_nldm/saed14hvt_ulvl_ss0p72v25c_i0p72v.db \
${DESIGN_REF_PATH}/lib/stdcell_hvt/db_nldm/saed14hvt_ulvl_ff0p88v25c_i0p88v.db \
${DESIGN_REF_PATH}/lib/sram/logic_synth/single/saed14sram_tt0p8v25c.db \
${DESIGN_REF_PATH}/lib/sram/logic_synth/single/saed14sram_ss0p72v25c.db \
${DESIGN_REF_PATH}/lib/sram/logic_synth/single/saed14sram_ff0p88v25c.db \
${DESIGN_REF_PATH}/lib/io_sp/db_nldm/saed14io_fc_sp_tt0p8v25c_1p8v.db \
${DESIGN_REF_PATH}/lib/io_sp/db_nldm/saed14io_fc_sp_ss0p72v25c_1p62v.db \
${DESIGN_REF_PATH}/lib/io_sp/db_nldm/saed14io_fc_sp_ff0p88v25c_1p96v.db \
${DESIGN_REF_PATH}/lib/io_sp/db_nldm/saed14io_wb_sp_tt0p8v25c_1p8v.db \
${DESIGN_REF_PATH}/lib/io_sp/db_nldm/saed14io_wb_sp_ss0p72v25c_1p62v.db \
${DESIGN_REF_PATH}/lib/io_sp/db_nldm/saed14io_wb_sp_ff0p88v25c_1p96v.db \
${DESIGN_REF_PATH}/lib/io_std/db_nldm/saed14io_fc_tt0p8v25c_1p8v.db \
${DESIGN_REF_PATH}/lib/io_std/db_nldm/saed14io_fc_ss0p72v25c_1p62v.db \
${DESIGN_REF_PATH}/lib/io_std/db_nldm/saed14io_fc_ff0p88v25c_1p96v.db \
${DESIGN_REF_PATH}/lib/io_std/db_nldm/saed14io_wb_tt0p8v25c_1p8v.db \
${DESIGN_REF_PATH}/lib/io_std/db_nldm/saed14io_wb_ss0p72v25c_1p62v.db \
${DESIGN_REF_PATH}/lib/io_std/db_nldm/saed14io_wb_ff0p88v25c_1p96v.db "

set NDM_REFERENCE_LIB_DIRS  " \
	${DESIGN_REF_PATH}/lib/stdcell_rvt/ndm/saed14rvt_frame_timing_ccs.ndm \
	${DESIGN_REF_PATH}/lib/stdcell_hvt/ndm/saed14hvt_frame_timing_ccs.ndm \
	${DESIGN_REF_PATH}/lib/stdcell_lvt/ndm/saed14lvt_frame_timing_ccs.ndm \
        ${DESIGN_REF_PATH}/lib/sram/ndm/saed14_sram_1rw_frame_only.ndm \
        ${DESIGN_REF_PATH}/lib/io_sp/ndm/saed14io_fc_sp_frame_timing_ccs.ndm \
        ${DESIGN_REF_PATH}/lib/io_sp/ndm/saed14io_wb_sp_frame_timing_ccs.ndm \
        ${DESIGN_REF_PATH}/lib/io_std/ndm/saed14io_fc_frame_timing_ccs.ndm\
        ${DESIGN_REF_PATH}/lib/io_std/ndm/saed14io_wb_frame_timing_ccs.ndm "
        
set TECH_FILE 		"${DESIGN_REF_TECH_PATH}/milkyway/saed14nm_1p9m_mw.tf"  
set MAP_FILE            "${DESIGN_REF_TECH_PATH}/star_rc/saed14nm_tf_itf_tluplus.map"  
set TLUPLUS_MAX_FILE    "${DESIGN_REF_TECH_PATH}/star_rc/max/saed14nm_1p9m_Cmax.tluplus"  
set TLUPLUS_MIN_FILE    "${DESIGN_REF_TECH_PATH}/star_rc/min/saed14nm_1p9m_Cmin.tluplus" 
set GDS_MAP_FILE        "${DESIGN_REF_TECH_PATH}/milkyway/saed14nm_1p9m_gdsout_mw.map"
set STD_CELL_GDS "${DESIGN_REF_PATH}/lib/stdcell_rvt/gds/saed14rvt.gds"
set SRAMLP_SINGLELP_GDS "${DESIGN_REF_PATH}/lib/sram_lp/gds/singlelp.gds"

###################################################################################
# CONFIGURACIONES INICIALES DE POWER Y ROUTING
###################################################################################

set NDM_POWER_NET                "VDD" ;#
set NDM_POWER_PORT               "VDD" ;#
set NDM_GROUND_NET               "VSS" ;#
set NDM_GROUND_PORT              "VSS" ;#

set MIN_ROUTING_LAYER            "M2"   ;# Min routing layer
set MAX_ROUTING_LAYER            "M8"   ;# Max routing layer
