####################################################################################
# CTS
####################################################################################

create_routing_rule CLK_SPACING \
  -widths {M3 0.2 M4 0.2 } \
  -spacings {M3 0.42 M4 0.63 }

set_clock_routing_rules -rules CLK_SPACING -min_routing_layer M2 -max_routing_layer M4
set_clock_tree_options -target_latency 0.000 -target_skew 0.000 

clock_opt

write_verilog "${RESULTS_DIR}/${DESIGN}.cts.gate.v"

report_qor > "${RESULTS_DIR}/${DESIGN}.clock_qor.rpt"

report_clock_timing  -type skew > "${RESULTS_DIR}/${DESIGN}.clock_skew.rpt"
