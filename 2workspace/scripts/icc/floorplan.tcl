##########################################################################################
# FLOORPLAN
##########################################################################################
# USE ESTE ARCHIVO PARA CUALQUIER COMANDO RELACIONADO A FLOORPLAN
# AQUI HAY ALGUNOS EJEMPLOS DE COSAS QUE PODRÍAN FUNCIONARLE

set x_max 450
set y_max 510
set core_offset 15

initialize_floorplan \
  -flip_first_row true \
  -boundary [list [list 0 0] [list $x_max $y_max]] \
  -core_offset [list $core_offset $core_offset $core_offset $core_offset]

set attraction_region [list \
    [list [expr {int($x_max / 10)}] [expr {int($y_max / 10)}]] \
    [list [expr {int($x_max * 9 / 10)}] [expr {int($y_max * 9 / 10)}]]]

set all_std_cells [get_flat_cells -filter "!is_hard_macro"]
if {[sizeof_collection $all_std_cells] > 0} {
    create_bound -name "StdCells_CenterRegion" -boundary $attraction_region -type soft $all_std_cells
}

set all_macros [get_cells -hierarchical -filter "is_hard_macro==true"]
if {[sizeof_collection $all_macros] > 0} {
    set_attribute -objects $all_macros -name is_fixed -value false
    set_attribute -objects $all_macros -name is_placed -value false
}


##########################################################################################
# POSICIONAMIENTO DE PINES
##########################################################################################
place_pins -ports [get_ports *]

##########################################################################################
# INICIALIZACIÓN DE REDES DE VDD/VSS
##########################################################################################
create_net -power $NDM_POWER_NET
create_net -ground $NDM_GROUND_NET 

connect_pg_net -net $NDM_POWER_NET [get_pins -hierarchical "*/VDD"]
connect_pg_net -net $NDM_GROUND_NET [get_pins -hierarchical "*/VSS"]

##########################################################################################
# POSICIONAMIENTO INICIAL
##########################################################################################
create_placement -floorplan -timing_driven
legalize_placement
