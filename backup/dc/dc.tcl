##########################################################################################
# VARIABLES GLOBALES PARA SINTESIS
##########################################################################################

set DESIGN_NAME "system"  
set DESIGN $DESIGN_NAME
set REPORTS_DIR reports
set RESULTS_DIR results
set DCRM_FINAL_AREA_REPORT ${DESIGN_NAME}.area.rpt
set DCRM_FINAL_POWER_REPORT ${DESIGN_NAME}.power.rpt
set DCRM_FINAL_QOR_REPORT ${DESIGN_NAME}.qor.rpt
set DO_CLOCK_GATING false
exec rm -rf ${RESULTS_DIR} ${REPORTS_DIR}
exec mkdir ${RESULTS_DIR} ${REPORTS_DIR}

##########################################################################################
#         POR HACER!!!! REVISE QUE ESTAS RUTAS COINCIDAN CON LAS QUE ESTÁ TRABAJANDO
##########################################################################################
set WDIR "/home/synopsys/ie0411/proyecto/WORK" ; #ES NECESARIO MODIFICAR AL HOME USUARIO CORRECTO
set TOP ${WDIR}/..
set verilog_path "/share/synopsys/libs/ie0411/AMBER_ARM_2CORE/verilog"
set rtl_list_path "/share/synopsys/libs/ie0411/AMBER_ARM_2CORE/scripts/dc/rtl.list"

##########################################################################################
# VARIABLES DE CONFIGURACIÓN DE LIBRERIA NO MODIFICAR
##########################################################################################
set DESIGN_REF_PATH		  "/share/synopsys/libs/SAED14nm_PDK"
set DESIGN_REF_TECH_PATH          "${DESIGN_REF_PATH}/tech"

set ADDITIONAL_SEARCH_PATH      " \
        ${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm \
        ${DESIGN_REF_PATH}/lib/stdcell_hvt/db_nldm \
        ${DESIGN_REF_PATH}/lib/stdcell_lvt/db_nldm \
	${DESIGN_REF_PATH}/lib/sram/logic_synth/single \
	${DESIGN_REF_PATH}/lib/io_std/db_nldm \
	${DESIGN_REF_PATH}/lib/io_sp/db_nldm "


set_app_var verilogout_no_tri true
set_app_var timing_enable_multiple_clocks_per_reg true
set_app_var enable_recovery_removal_arcs true
set_app_var verilogout_show_unconnected_pins true
set_app_var compile_seqmap_propagate_constants false 
set_app_var sh_enable_page_mode false
set_app_var report_default_significant_digits 4


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

set target_library ${TARGET_LIBRARY_FILES}
set link_library  ${LINK_LIBRARY_FILES}

##########################################################################################
# CARGA DEL DISEÑO NO MODIFICAR
##########################################################################################
# DIRECTORIOS CON RTL
set rtl_search_path "${verilog_path} \
                     ${verilog_path}/system \
                     ${verilog_path}/tb \
                     ${verilog_path}/lib \
                     ${verilog_path}/ethmac \
                     ${verilog_path}/amber25" 

# MODULO TOP DEL DISEÑO
set my_toplevel system

# ACTUALIZACIÓN DEL SEARCH PATH
set search_path [concat $search_path [join $rtl_search_path]]
set search_path [concat $search_path [join $ADDITIONAL_SEARCH_PATH]]

# GENERACIÓN DE LA LISTA CON EL RTL
source $rtl_list_path
set my_verilog_files $RTL_LIST

##########################################################################################
# SINTESIS
##########################################################################################

analyze -f verilog $my_verilog_files

elaborate -library WORK -update system

current_design system

link
uniquify -dont_skip_empty_designs
current_design system


set_dont_touch [get_cell u_clocks_resets/sys_clk_buff] true
set_dont_touch [get_cell u_clocks_resets/sys_clk_slow_buff] true
set_dont_touch [get_cell u_clocks_resets/clk_200_buff] true

set auto_wire_load_selection true

##########################################################################################
# CLOCK GATING (SIN PROBAR, BAJO SU PROPIO RIESGO)
##########################################################################################
set pos_cg_cells [get_lib_cells */CGLP*]
set neg_cg_cells [get_lib_cells */CGLN*]

foreach_in_coll pos_cg_cell $pos_cg_cells {
    set pos_cg_cell_name [get_attr [get_lib_cell $pos_cg_cell] full_name]
    set_attribute [get_lib_cell $pos_cg_cell_name] clock_gating_integrated_cell latch_posedge
}
foreach_in_coll neg_cg_cell $neg_cg_cells {
    set neg_cg_cell_name [get_attr [get_lib_cell $neg_cg_cell] full_name]
    set_attribute [get_lib_cell $neg_cg_cell_name] clock_gating_integrated_cell latch_negedge
}
    
if {$DO_CLOCK_GATING == "true"} {
    set_clock_gating_style -minimum_bitwidth 4 -max_fanout 99999 \
        -positive_edge_logic integrated -negative_edge_logic integrated
}

# CELDAS QUE NO SE DEBEN MODIFICAR
set_verification_priority -all -high
set_fix_multiple_port_nets -buffer_constants -feedthroughs -outputs -constants
set dont_touch_cells [get_cells "u_wishbone_arbiter/m0_wb_cyc_r_reg u_eth_top/ethreg1/MODER_1/*_reg*"]
foreach_in_coll cell $dont_touch_cells {
	set cell_name [get_object_name $cell]
	#set_dont_touch [get_cells $cell_name]
	set_size_only [get_cells $cell_name]
#	echo "Setting dont_touch on $cell_name"
	set nets [get_nets -of [get_pins $cell_name/*]]
	foreach_in_collection net $nets {
		set net_name [get_object_name $net]
		set_dont_touch [get_net $net_name]
#		echo "Setting dont_touch on $net_name"
	}
}

# CARGA DE CONSTRAINTS
source -e -v "/share/synopsys/libs/ie0411/AMBER_ARM_2CORE/scripts/dc/constraints.sdc"


compile_ultra -exact_map -no_autoungroup

##########################################################################################
# RESULTADOS DE SINTESIS
##########################################################################################
change_names -hierarchy -rules verilog -log_changes ${REPORTS_DIR}/${DESIGN_NAME}.change_names.log

write -format ddc -hierarchy -output ${RESULTS_DIR}/${DESIGN_NAME}.ddc
write -f verilog -hierarchy -output ${RESULTS_DIR}/${DESIGN_NAME}.v

report_qor > ${REPORTS_DIR}/${DCRM_FINAL_QOR_REPORT}
report_threshold_voltage_group > ${REPORTS_DIR}/${DESIGN_NAME}.threshold_volt_group.rpt
report_timing -input_pins -capacitance -transition_time -nets -significant_digits 4 -nosplit -nworst 10 -max_paths 500 > ${REPORTS_DIR}/${DESIGN_NAME}.timing.rpt


report_area -hierarchy -nosplit > ${REPORTS_DIR}/${DCRM_FINAL_AREA_REPORT}

report_power -nosplit -hier > ${REPORTS_DIR}/${DCRM_FINAL_POWER_REPORT}

report_reference -nosplit -hierarchy > ${REPORTS_DIR}/${DESIGN_NAME}.reference.rpt
report_resources -nosplit -hierarchy > ${REPORTS_DIR}/${DESIGN_NAME}.resources.rpt

check_timing > ${REPORTS_DIR}/${DESIGN_NAME}.check_timing.rpt
report_constraint -nos -all_violators > ${REPORTS_DIR}/${DESIGN_NAME}.allvio.rpt
report_timing -cap -trans -input_pins -nos > ${REPORTS_DIR}/${DESIGN_NAME}.worst_setup_path.rpt
report_clock_gating > ${REPORTS_DIR}/${DESIGN_NAME}.clock_gating.rpt

#PARA LA PARTE FISICA SE DEBE USAR ESTE SCRIPT DE CONSTRAINTS GENERADAS, NO EL INICIAL
write_sdc -version 2.1 -full_path_lib_names ${RESULTS_DIR}/${DESIGN_NAME}.sdc
