# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
set_msg_config -id {Common 17-41} -limit 10000000
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir C:/Users/jon/ECE532/video_in_ip/debug/project_1/project_1.cache/wt [current_project]
set_property parent.project_path C:/Users/jon/ECE532/video_in_ip/debug/project_1/project_1.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_repo_paths c:/Users/jon/ECE532/video_in_ip/ip_repo [current_project]
add_files C:/Users/jon/ECE532/video_in_ip/debug/project_1/project_1.srcs/sources_1/bd/design_1/design_1.bd
set_property used_in_implementation false [get_files -all c:/Users/jon/ECE532/video_in_ip/debug/project_1/project_1.srcs/sources_1/bd/design_1/ip/edit_video_in_ip_v1_0.srcs/sources_1/ip/v_vid_in_axi4s_0/v_vid_in_axi4s_0_clocks.xdc]
set_property used_in_implementation false [get_files -all c:/Users/jon/ECE532/video_in_ip/debug/project_1/project_1.srcs/sources_1/bd/design_1/ip/design_1_clk_wiz_0_0/design_1_clk_wiz_0_0_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/jon/ECE532/video_in_ip/debug/project_1/project_1.srcs/sources_1/bd/design_1/ip/design_1_clk_wiz_0_0/design_1_clk_wiz_0_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/jon/ECE532/video_in_ip/debug/project_1/project_1.srcs/sources_1/bd/design_1/ip/design_1_clk_wiz_0_0/design_1_clk_wiz_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/jon/ECE532/video_in_ip/debug/project_1/project_1.srcs/sources_1/bd/design_1/ip/design_1_proc_sys_reset_0_0/design_1_proc_sys_reset_0_0_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/jon/ECE532/video_in_ip/debug/project_1/project_1.srcs/sources_1/bd/design_1/ip/design_1_proc_sys_reset_0_0/design_1_proc_sys_reset_0_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/jon/ECE532/video_in_ip/debug/project_1/project_1.srcs/sources_1/bd/design_1/ip/design_1_proc_sys_reset_0_0/design_1_proc_sys_reset_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/jon/ECE532/video_in_ip/debug/project_1/project_1.srcs/sources_1/bd/design_1/ip/design_1_axi_vdma_0_0/design_1_axi_vdma_0_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/jon/ECE532/video_in_ip/debug/project_1/project_1.srcs/sources_1/bd/design_1/ip/design_1_axi_vdma_0_0/design_1_axi_vdma_0_0_clocks.xdc]
set_property used_in_implementation false [get_files -all c:/Users/jon/ECE532/video_in_ip/debug/project_1/project_1.srcs/sources_1/bd/design_1/ip/design_1_axi_vdma_0_0/design_1_axi_vdma_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all C:/Users/jon/ECE532/video_in_ip/debug/project_1/project_1.srcs/sources_1/bd/design_1/design_1_ooc.xdc]
set_property is_locked true [get_files C:/Users/jon/ECE532/video_in_ip/debug/project_1/project_1.srcs/sources_1/bd/design_1/design_1.bd]

read_verilog -library xil_defaultlib C:/Users/jon/ECE532/video_in_ip/debug/project_1/project_1.srcs/sources_1/bd/design_1/hdl/design_1_wrapper.v
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/jon/ECE532/video_in_ip/debug/project_1/project_1.srcs/constrs_1/new/constrain.xdc
set_property used_in_implementation false [get_files C:/Users/jon/ECE532/video_in_ip/debug/project_1/project_1.srcs/constrs_1/new/constrain.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]

synth_design -top design_1_wrapper -part xc7a100tcsg324-1


write_checkpoint -force -noxdef design_1_wrapper.dcp

catch { report_utilization -file design_1_wrapper_utilization_synth.rpt -pb design_1_wrapper_utilization_synth.pb }