#GENERACION DE CLOCKS
create_clock -period 3 -waveform "0 1.5" [get_ports brd_clk_p] -name BRD_CLK_P

## NO MODIFICAR CLKS DE MODULO ETHERNET
create_clock -period 40 -waveform "0 20" [get_ports mtx_clk_pad_i] -name mtx_clk
create_clock -period 40 -waveform "0 20" [get_ports mrx_clk_pad_i] -name mrx_clk

## NO MODIFICAR ESTOS CLOCKS
create_generated_clock -name sys_clk      -source [get_ports brd_clk_p] -divide_by 1 -master_clock BRD_CLK_P [get_pins u_clocks_resets/sys_clk_buff/Y]
create_generated_clock -name sys_clk_slow -source [get_ports brd_clk_p] -divide_by 4 -master_clock BRD_CLK_P [get_pins u_clocks_resets/sys_clk_slow_buff/Y]

# JITTER
# NO MODIFICAR
set_clock_uncertainty -setup 0.03 [get_clocks sys_clk]
set_clock_uncertainty -hold 0.03 [get_clocks sys_clk]
set_clock_uncertainty -setup 0.1 [get_clocks mtx_clk]
set_clock_uncertainty -hold 0.1 [get_clocks mtx_clk]
set_clock_uncertainty -setup 0.1 [get_clocks mrx_clk]
set_clock_uncertainty -hold 0.1 [get_clocks mrx_clk]

# RETARDOS DE ENTRADA / SALIDA DE PUERTOS
# NO MODIFICAR
set in_ports [remove_from_collection [all_inputs] [get_ports *_clk_*]]

#NO MODIFICAR INPUT DELAYS
set_input_delay -max 0.1 -clock [get_clocks sys_clk] $in_ports
set_input_delay -min 0.1 -clock [get_clocks sys_clk] $in_ports
set_input_delay -max 0.1 -clock [get_clocks mtx_clk] $in_ports
set_input_delay -min 0.1 -clock [get_clocks mtx_clk] $in_ports
set_input_delay -max 0.1 -clock [get_clocks mrx_clk] $in_ports
set_input_delay -min 0.1 -clock [get_clocks mrx_clk] $in_ports

#NO MODIFICAR OUTPUT DELAYS
set_output_delay -max 0.1 -clock sys_clk [all_outputs]
set_output_delay -max 0.1 -clock mtx_clk [all_outputs]
set_output_delay -max 0.1 -clock mrx_clk [all_outputs]


# NO MODIFICAR SLEW DE ENTRADAS
set_input_transition 0.02 [all_inputs]

# NO MODIFICAR CARGA EN SALIDAS
set_load 1.5 [all_outputs]
