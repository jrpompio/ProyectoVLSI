##########################################################################################
# ANILLO MÁS GRUESO (30 µm en vez de 15)
##########################################################################################
set top_ring_width 30
set top_offset 2
set top_ring_spacing 5
set hm_top M6
set vm_top M5

create_pg_region top_power_ring_region -core -expand_by_edge \
          "{{side: 1} {offset: $top_offset}} {{side: 2} {offset: $top_offset}} {{side: 3} {offset: $top_offset}} {{side: 4} {offset: $top_offset}}"

create_pg_ring_pattern ring \
                 -horizontal_layer $hm_top -vertical_layer $vm_top \
                 -horizontal_width $top_ring_width -vertical_width $top_ring_width \
                 -horizontal_spacing $top_ring_spacing -vertical_spacing $top_ring_spacing

set_pg_strategy ring -pg_regions { top_power_ring_region } -pattern {{ name: ring} { nets: "VSS VDD" }}
compile_pg -strategies ring

##########################################################################################
# MALLA ESTRUCTURAL MÁS CERRADA (pitch 25 µm y straps más anchos)
##########################################################################################
create_pg_mesh_pattern P_top_two \
-layers { \
  {{horizontal_layer: M7} {width: 0.8} {spacing: interleaving} {pitch: 25} {offset: 0.856} {trim: true}} \
  {{vertical_layer:   M6} {width: 0.8} {spacing: interleaving} {pitch: 25} {offset: 6.08}  {trim: true}} \
}
set_pg_strategy S_default_vddvss -core \
-pattern {{name: P_top_two} {nets:{VSS VDD}}} \
-extension {{stop: design_boundary_and_generate_pin}}
compile_pg -strategies {S_default_vddvss}

##########################################################################################
# MALLA DE ALTA CAPACIDAD ULTRA-ROBUSTA (M8/M9 ancho 3 µm, pitch 20 µm)
##########################################################################################
create_pg_mesh_pattern P_high_cap \
-layers { \
  {{horizontal_layer: M8} {width: 3.0} {spacing: interleaving} {pitch: 20} {offset: 0.0} {trim: true}} \
  {{vertical_layer:   M9} {width: 3.0} {spacing: interleaving} {pitch: 20} {offset: 0.0} {trim: true}} \
}
set_pg_strategy S_high_cap -core \
-pattern {{name: P_high_cap} {nets:{VSS VDD}}}
compile_pg -strategies {S_high_cap}

##########################################################################################
# 18 PADS VIRTUALES (más uniformes)
##########################################################################################
# Esquina y lados
set_virtual_pad -net VDD -coordinate {-10   -10} -layer M6
set_virtual_pad -net VSS -coordinate {410   504} -layer M6
set_virtual_pad -net VDD -coordinate {205  504} -layer M6
set_virtual_pad -net VSS -coordinate {-10   252} -layer M6
set_virtual_pad -net VDD -coordinate {410   252} -layer M6
set_virtual_pad -net VSS -coordinate {205   -10} -layer M6

# Mitad de cada lado
set_virtual_pad -net VDD -coordinate {-10   126} -layer M6
set_virtual_pad -net VSS -coordinate {-10   378} -layer M6
set_virtual_pad -net VDD -coordinate {410   126} -layer M6
set_virtual_pad -net VSS -coordinate {410   378} -layer M6
set_virtual_pad -net VDD -coordinate {100   504} -layer M6
set_virtual_pad -net VSS -coordinate {310   504} -layer M6
set_virtual_pad -net VDD -coordinate {100   -10} -layer M6
set_virtual_pad -net VSS -coordinate {310   -10} -layer M6

# Centro de lados largos
set_virtual_pad -net VDD -coordinate {-10   400} -layer M6
set_virtual_pad -net VSS -coordinate {-10    90} -layer M6
set_virtual_pad -net VDD -coordinate {410   400} -layer M6
set_virtual_pad -net VSS -coordinate {410    90} -layer M6

# El resto del script (std rails, macro conn, analyze) queda igual
