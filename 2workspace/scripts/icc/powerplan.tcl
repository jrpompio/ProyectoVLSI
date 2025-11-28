
##########################################################################################
# DISTRIBUCIÓN DE VDD/VSS
##########################################################################################

##########################################################################################
# ANILLO DE VDD/VSS
##########################################################################################

set top_ring_width 20
set top_offset 2
set top_ring_spacing 5
set gprs_ring_width 1.5
set gprs_offset -5
set gprs_ring_spacing 2
set hm_gprs M7
set vm_gprs M8
set hm_top M6
set vm_top M5

create_pg_region top_power_ring_region -core -expand_by_edge  \
          "{{side: 1} {offset: $top_offset}} {{side: 2} {offset: $top_offset}} {{side: 3} {offset: $top_offset}} {{side: 4} {offset: $top_offset}}"
	 
create_pg_ring_pattern \
                 ring \
                 -horizontal_layer $hm_top -vertical_layer $vm_top \
                 -horizontal_width $top_ring_width -vertical_width $top_ring_width \
                 -horizontal_spacing $top_ring_spacing -vertical_spacing $top_ring_spacing

set_pg_strategy  ring -pg_regions { top_power_ring_region } -pattern {{ name: ring} { nets: "VSS VDD" }}

compile_pg -strategies ring 

##########################################################################################
# REJILLA DE VDD/VSS
##########################################################################################
create_pg_mesh_pattern P_top_two \
	-layers { \
		{ {horizontal_layer: M7} {width: 0.45} {spacing: interleaving} {pitch: 25} {offset: 0.856} {trim : true} } \
		{ {vertical_layer: M6}   {width: 0.45} {spacing: interleaving} {pitch: 25} {offset: 6.08}  {trim : true} } \
		} 

set_pg_strategy S_default_vddvss \
	-core \
	-pattern   { {name: P_top_two} {nets:{VSS VDD}} } \
	-extension { {{stop:design_boundary_and_generate_pin}} }
	
compile_pg -strategies {S_default_vddvss} 
	
##########################################################################################
# RIELES DE VDD/VSS
##########################################################################################
create_pg_std_cell_conn_pattern std_rail_conn1 -rail_width 0.094 -layers M1

set_pg_strategy  std_rail_1 -pattern {{name : std_rail_conn1} {nets: "VDD VSS"}} -core

##########################################################################################
# PADS DE VDD/VSS (PUEDE AGREGAR MÁS SI LO CONSIDERA NECESARIO)
##########################################################################################
##########################################################################################
# PADS DE VDD/VSS (V5: ESTRATEGIA ENJAMBRE)
##########################################################################################

##########################################################################################
# PADS DE VDD/VSS FINAL
##########################################################################################

set_virtual_pad -net VDD -coordinate {90 503}  -layer M6
set_virtual_pad -net VSS -coordinate {110 503} -layer M6
set_virtual_pad -net VSS -coordinate {135 503} -layer M6
set_virtual_pad -net VSS -coordinate {180 503} -layer M6
set_virtual_pad -net VDD -coordinate {270 503} -layer M6
set_virtual_pad -net VSS -coordinate {360 503} -layer M6
set_virtual_pad -net VDD -coordinate {410 503} -layer M6

set_virtual_pad -net VDD -coordinate {90 7}  -layer M6
set_virtual_pad -net VDD -coordinate {160 7} -layer M6
set_virtual_pad -net VSS -coordinate {180 7} -layer M6
set_virtual_pad -net VDD -coordinate {300 7} -layer M6
set_virtual_pad -net VDD -coordinate {326 7} -layer M6
set_virtual_pad -net VSS -coordinate {360 7} -layer M6

set_virtual_pad -net VDD -coordinate {7 102} -layer M7
set_virtual_pad -net VDD -coordinate {7 135} -layer M7
set_virtual_pad -net VDD -coordinate {7 157} -layer M7
set_virtual_pad -net VSS -coordinate {7 204} -layer M7
set_virtual_pad -net VDD -coordinate {7 306} -layer M7
set_virtual_pad -net VSS -coordinate {7 347} -layer M7
set_virtual_pad -net VSS -coordinate {7 365} -layer M7

set_virtual_pad -net VDD -coordinate {443 135} -layer M7
set_virtual_pad -net VDD -coordinate {443 157} -layer M7
set_virtual_pad -net VSS -coordinate {443 172} -layer M7
set_virtual_pad -net VSS -coordinate {443 204} -layer M7
set_virtual_pad -net VDD -coordinate {443 306} -layer M7
set_virtual_pad -net VSS -coordinate {443 408} -layer M7

##########################################################################################
compile_pg -strategies std_rail_1

##########################################################################################
# CONEXION DE VDD/VSS A MACROS
##########################################################################################
create_pg_macro_conn_pattern macro_pat -nets {VDD VSS}    -direction horizontal -width 1 -layers M6 -spacing minimum    -pitch 5 -pin_conn_type long_pin
set_pg_strategy macro_strat -core    -pattern {{pattern: macro_pat} {nets: {VDD VSS}}}
compile_pg -strategies macro_strat

##########################################################################################
# ANÁLISIS INICIAL DE IR DROP
##########################################################################################
analyze_power_plan -nets {VDD VSS} -power_budget 75
