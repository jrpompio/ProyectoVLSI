##########################################################################################
# FLOORPLAN
##########################################################################################
# USE ESTE ARCHIVO PARA CUALQUIER COMANDO RELACIONADO A FLOORPLAN
# AQUI HAY ALGUNOS EJEMPLOS DE COSAS QUE PODRÍAN FUNCIONARLE


# INICIALIZACIÓN DE LA FORMA
initialize_floorplan \
  -flip_first_row true \
  -boundary {{0 0} {540 504}} \
  -core_offset {15 15 15 15}

rotate_objects [get_cells u_iobuf/IO_tri] -angle CW90 -force

set all_macros [get_cells -hierarchical -filter "is_hard_macro==true"]
if {[sizeof_collection $all_macros] > 0} {
    puts "--> Liberando [sizeof_collection $all_macros] macros para posicionamiento automático..."
    set_attribute -objects $all_macros -name is_fixed -value false
    set_attribute -objects $all_macros -name is_placed -value false
}

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

########set obj [get_cells -hierarchical *myram*]
########if {[sizeof_collection $obj] > 0} {
########    # Nota: Si tienes múltiples RAMs, deberías iterar con un 'foreach_in_collection'
########    # Asumimos aquí que 'obj' es una sola celda o que quieres moverlas todas al mismo punto (cuidado con esto).
########    
########    set_attribute -quiet $obj orientation R0
########    move_objects $obj -x 100 -y 200
########    set_attribute -quiet $obj is_placed true
########    set_attribute -quiet $obj is_fixed true
########    set_attribute -quiet $obj is_soft_fixed false
########    set_attribute -quiet $obj eco_status eco_reset
########
########    # Crear blockage alrededor de la macro
########    # Obtenemos el Bounding Box. El formato retornado es {{x1 y1} {x2 y2}}
########    set bbox [get_attribute $obj bbox]
########    
########    # Usamos el bbox directamente en -boundary, ya que el formato es compatible
########    create_placement_blockage -boundary $bbox -type hard
########}

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
