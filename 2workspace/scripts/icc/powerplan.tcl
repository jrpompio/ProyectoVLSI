##########################################################################################
# DISTRIBUCIÓN DE VDD/VSS
##########################################################################################

##########################################################################################
# ANILLO DE VDD/VSS
##########################################################################################

set top_ring_width 5
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
		{ {horizontal_layer: M7} {width: 0.2} {spacing: interleaving} {pitch: 30} {offset: 0.856} {trim : true} } \
		{ {vertical_layer: M6}   {width: 0.2} {spacing: interleaving} {pitch: 30} {offset: 6.08}  {trim : true} } \
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
set_virtual_pad -net VDD -coordinate {-5 -5} -layer M6
set_virtual_pad -net VSS -coordinate {955 955} -layer M6

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

