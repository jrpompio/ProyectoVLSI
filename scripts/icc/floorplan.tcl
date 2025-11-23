##########################################################################################
# FLOORPLAN
##########################################################################################
# USE ESTE ARCHIVO PARA CUALQUIER COMANDO RELACIONADO A FLOORPLAN
# AQUI HAY ALGUNOS EJEMPLOS DE COSAS QUE PODRÍAN FUNCIONARLE


# INICIALIZACIÓN DE LA FORMA
initialize_floorplan \
  -flip_first_row true \
  -boundary {{0 0} {210 210}} \
  -core_offset {15 15 15 15}


##########################################################################################
# POSICIONAMIENTO DE SRAMS
##########################################################################################
#set obj [get_cells -hierarchical *myram*]
#set_attribute -quiet $obj orientation R0
#move_objects $obj -x [expr $x_coordinate] \
#                  -y [expr $y_coordinate]
#set_attribute -quiet $obj is_placed true
#set_attribute -quiet $obj is_fixed true
#set_attribute -quiet $obj is_soft_fixed false
#set_attribute -quiet $obj eco_status eco_reset

##########################################################################################
# BLOQUEOS DE PLACEMENT
##########################################################################################
#set bbox [get_attribute [get_cells -hierarchical *myram*] bbox]
#set xl [lindex [lindex $bbox 0] 0]
#set yl [lindex [lindex $bbox 0] 1]
#set xh [lindex [lindex $bbox 1] 0]
#set yh [lindex [lindex $bbox 1] 1]
#create_placement_blockage -bbox [list $xl $zyl $xh $yh] -type hard


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
