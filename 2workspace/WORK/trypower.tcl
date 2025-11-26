source ../scripts/icc/common_setup.tcl
open_block system_lib:system_2_post_floorplan/
link_block
source ../scripts/icc/powerplan.tcl
sh (bot_alert 'POWERPLAN FIN')
exit

