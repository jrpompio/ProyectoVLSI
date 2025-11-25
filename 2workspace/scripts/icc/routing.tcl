####################################################################################
# ENRUTAMIENTO
####################################################################################
remove_ignored_layers -all
set_ignored_layers \
    -min_routing_layer  $MIN_ROUTING_LAYER \
    -max_routing_layer  $MAX_ROUTING_LAYER
    
route_opt

check_routability

####################################################################################
# INSERCION DE CELDAS FILLERS
####################################################################################
set pnr_std_fillers "SAEDRVT14_FILL*"
set std_fillers ""
foreach filler $pnr_std_fillers { lappend std_fillers "*/${filler}" }
create_stdcell_filler -lib_cell $std_fillers

####################################################################################
# CONEXIÓN DE VDD/VSS
####################################################################################
connect_pg_net -net $NDM_POWER_NET [get_pins -hierarchical "*/VDD"]
connect_pg_net -net $NDM_GROUND_NET [get_pins -hierarchical "*/VSS"]
