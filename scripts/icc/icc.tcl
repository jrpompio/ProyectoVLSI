##########################################################################################
# VARIABLES GLOBALES REVISE QUE APUNTEN A LOS DIRECTORIOS ADECUADOS
##########################################################################################
set DESIGN_NAME system
set REPORTS_DIR ../reportsICC
set RESULTS_DIR ../resultsICC
set SCRIPTS_DIR "$env(HOME)/ie0411/proyecto/scripts/" ; # DONDE SEA QUE COPIARON LOS SCRIPTS
set SDC_FILE "$env(HOME)/ie0411/proyecto/resultsDC/system.sdc" ; # ESTE ARCHIVO ES EL GENERADO POR SINTESIS, NO EL DADO POR EL PROFESOR PARA INICIAR SINTESIS
set WDIR "$env(HOME)/ie0411/proyecto/WORK" ; #ES NECESARIO MODIFICAR AL HOME USUARIO CORRECTO
set TOP ${WDIR}/..
set gate_verilog "$env(HOME)/ie0411/proyecto/resultsDC/system.v" ; #ES NECESARIO MODIFICAR AL PATH CORRECTO

##########################################################################################
# CONFIGURACIONES GENERALES
##########################################################################################
set COMMON_SETUP_SCRIPT "$env(HOME)/ie0411/proyecto/scripts/icc/common_setup.tcl"

source $COMMON_SETUP_SCRIPT

###################################################################################
# INICIALIZACIÓN DE LA LIBRERÍA
###################################################################################

set_host_options -max_cores 10

set link_library   $LINK_LIBRARY_FILES
set target_library $TARGET_LIBRARY_FILES

set lib_path "${WORK_DIR}/${DESIGN}_lib"

if {[file exists $lib_path]} {
    file delete -force $lib_path
}
create_lib  -ref_libs $NDM_REFERENCE_LIB_DIRS  -technology $TECH_FILE ${DESIGN_NAME}_lib

read_parasitic_tech -tlup $TLUPLUS_MAX_FILE  -layermap  $MAP_FILE 
read_parasitic_tech -tlup $TLUPLUS_MIN_FILE  -layermap  $MAP_FILE 


##########################################################################################
# CARGA DE LIBRERÍA Y GENERACIÓN DE ESCENARIOS DE ANÁLISIS NO MODIFICAR
##########################################################################################

set lib_dir ${DESIGN_REF_PATH}/lib
set std_library $LINK_LIBRARY_FILES

set search_path $ADDITIONAL_SEARCH_PATH

set target_library "${std_library}"
set link_library [concat * $std_library]

read_verilog -top $DESIGN_NAME $gate_verilog

current_design $DESIGN

read_sdc $SDC_FILE

remove_corners -all
remove_modes -all
remove_scenarios -all

create_corner slow
create_corner fast

read_parasitic_tech \
	-tlup $TLUPLUS_MAX_FILE \
	-layermap $MAP_FILE \
	-name tlup_max

read_parasitic_tech \
	-tlup $TLUPLUS_MIN_FILE \
	-layermap $MAP_FILE \
	-name tlup_min

set_parasitics_parameters \
	-early_spec tlup_min \
	-late_spec tlup_min \
	-corners {fast}

set_parasitics_parameters \
	-early_spec tlup_max \
	-late_spec tlup_max \
	-corners {slow}

create_mode func
current_mode func
create_scenario -mode func -corner fast -name func_fast
create_scenario -mode func -corner slow -name func_slow

current_scenario func_fast
read_sdc $SDC_FILE

current_scenario func_slow
read_sdc $SDC_FILE


save_block -as ${DESIGN}_1_imported

##########################################################################################
# FLOORPLAN
##########################################################################################
source ${SCRIPTS_DIR}/icc/floorplan.tcl
save_block -as ${DESIGN}_2_post_floorplan

##########################################################################################
# DISTRIBUCIÓN DE POTENCIA
##########################################################################################
source ${SCRIPTS_DIR}/icc/powerplan.tcl
save_block -as ${DESIGN}_3_post_power

##########################################################################################
# POSICIONAMIENTO
##########################################################################################
source ${SCRIPTS_DIR}/icc/placement.tcl
save_block -as ${DESIGN}_4_post_place

##########################################################################################
# SÍNTESIS DE ÁRBOL DE RELOJ
##########################################################################################
source ${SCRIPTS_DIR}/icc/cts.tcl
save_block -as ${DESIGN}_5_post_cts

##########################################################################################
# ENRUTAMIENTO
##########################################################################################
source ${SCRIPTS_DIR}/icc/routing.tcl
save_block -as ${DESIGN}_6_post_route

##########################################################################################
# ECO
##########################################################################################
source ${SCRIPTS_DIR}/icc/eco.tcl
save_block -as ${DESIGN}_7_post_eco

##########################################################################################
# GENERACIÓN DE RESULTADOS
#########################################################################################
source ${SCRIPTS_DIR}/icc/dump_results.tcl
