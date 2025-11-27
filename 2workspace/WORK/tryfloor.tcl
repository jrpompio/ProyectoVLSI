puts "################################################################"
puts "       FLOORPLAN BASE (504x504) - SIN ROTACIÓN"
puts "################################################################"

set_host_options -max_cores 16

# TAMAÑO FIJO
set x 900
set y 900

if {[catch {
    
    catch { close_block -force }

    # 1. CARGAR DISEÑO LIMPIO
    open_block system_lib:system_1_imported
    link_block
    
    # Usamos un nombre nuevo para este experimento
    copy_block -to system_simple_504 -force
    current_block system_simple_504

    # 2. INICIALIZAR
    puts "--> Creando Floorplan de $x x $y..."
    initialize_floorplan \
        -flip_first_row true \
        -boundary "{0 0} {$x $y}" \
        -core_offset {15 15 15 15}
    # 3. RESETEAR MACROS (Verticales y Libres)
    # Nos aseguramos que nada esté fijo ni rotado
    set all_macros [get_cells -hierarchical -filter "is_hard_macro==true"]
    if {[sizeof_collection $all_macros] > 0} {
        puts "--> Liberando [sizeof_collection $all_macros] macros para posicionamiento automático..."
        set_attribute -objects $all_macros -name is_fixed -value false
        set_attribute -objects $all_macros -name is_placed -value false
        set_attribute -objects $all_macros -name orientation -value R0
    }

    # 4. PLACEMENT RÁPIDO
    place_pins -ports [get_ports *]
    
    puts "--> Ejecutando Placement..."
    create_placement -floorplan -timing_driven
    
    # 5. FINALIZAR
    puts "\n************************************************"
    puts " EXITO: Floorplan Base 504x504 generado."
    puts "************************************************"
    report_utilization
    
    save_block -as system_2_simple_504
    puts "Bloque guardado: system_2_simple_504"
    
    catch { sh (bot_alert 'Floorplan 504 LISTO') }
    
    puts "Abriendo GUI. Por favor toma la captura..."
    start_gui

} error_msg]} {
    puts "\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    puts " FALLO: $error_msg"
    puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    catch { sh (bot_alert 'Floorplan FALLO') }
    catch { close_block -force }
}
