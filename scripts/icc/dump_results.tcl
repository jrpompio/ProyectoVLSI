#-------------------------------------------------------------------------------------------------------#
#                                         Dump Out Results                                              #
#-------------------------------------------------------------------------------------------------------#

# Write files
set ICC_FILE_DUMPS ${WORK_DIR}/results
write_verilog $ICC_FILE_DUMPS/system.v
write_sdf $ICC_FILE_DUMPS/system.sdf
write_sdc -output $ICC_FILE_DUMPS/system.sdc
write_def -all_routing_blockages -routed_nets $ICC_FILE_DUMPS/system.def
 
write_parasitics -format SPEF -output $ICC_FILE_DUMPS/system.spef

# Reports

set REPORTS_DIR_PLACE_OPT ${WORK_DIR}/reports
set ICC_PLACE_OPT_CEL system
redirect -file $REPORTS_DIR_PLACE_OPT/$ICC_PLACE_OPT_CEL.max.tim {report_timing -capacitance -transition_time -input_pins -nets -delay max -nosplit}
redirect -file $REPORTS_DIR_PLACE_OPT/$ICC_PLACE_OPT_CEL.min.tim {report_timing -capacitance -transition_time -input_pins -nets -delay min -nosplit}
redirect -file $REPORTS_DIR_PLACE_OPT/$ICC_PLACE_OPT_CEL.placement_utilization.rpt {report_utilization -verbose}
redirect -file $REPORTS_DIR_PLACE_OPT/$ICC_PLACE_OPT_CEL.qor.rpt {report_qor}
redirect -file $REPORTS_DIR_PLACE_OPT/$ICC_PLACE_OPT_CEL.con {report_constraints}
redirect -file $REPORTS_DIR_PLACE_OPT/$ICC_PLACE_OPT_CEL.irdrop {analyze_power_plan -nets {VDD VSS} -power_budget 75}
