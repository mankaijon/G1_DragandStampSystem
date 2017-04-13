# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir C:/Users/jon/ECE532/video_in_ip/ip_repo/edit_video_in_ip_v1_0.cache/wt [current_project]
set_property parent.project_path C:/Users/jon/ECE532/video_in_ip/ip_repo/edit_video_in_ip_v1_0.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part_repo_paths C:/Users/jon/ECE532/ddr/board_files [current_project]
set_property board_part digilentinc.com:nexys4_ddr:part0:1.1 [current_project]
set_property ip_repo_paths c:/Users/jon/ECE532/video_in_ip/ip_repo/video_in_ip_1.0 [current_project]
read_ip -quiet C:/Users/jon/ECE532/video_in_ip/ip_repo/edit_video_in_ip_v1_0.srcs/sources_1/ip/v_vid_in_axi4s_0/v_vid_in_axi4s_0.xci
set_property used_in_implementation false [get_files -all c:/Users/jon/ECE532/video_in_ip/ip_repo/edit_video_in_ip_v1_0.srcs/sources_1/ip/v_vid_in_axi4s_0/v_vid_in_axi4s_0_clocks.xdc]
set_property is_locked true [get_files C:/Users/jon/ECE532/video_in_ip/ip_repo/edit_video_in_ip_v1_0.srcs/sources_1/ip/v_vid_in_axi4s_0/v_vid_in_axi4s_0.xci]

read_verilog -library xil_defaultlib {
  C:/Users/jon/ECE532/video_in_ip/ip_repo/video_in_ip_1.0/src/I2C_Controller.v
  C:/Users/jon/ECE532/video_in_ip/ip_repo/video_in_ip_1.0/src/I2C_OV7670_RGB565_VGA_Config.v
  C:/Users/jon/ECE532/video_in_ip/ip_repo/video_in_ip_1.0/src/debounce.v
  C:/Users/jon/ECE532/video_in_ip/ip_repo/video_in_ip_1.0/src/I2C_AV_Config.v
  C:/Users/jon/ECE532/video_in_ip/ip_repo/video_in_ip_1.0/src/capture.v
  C:/Users/jon/ECE532/video_in_ip/ip_repo/video_in_ip_1.0/src/ov7670_top.v
  C:/Users/jon/ECE532/video_in_ip/ip_repo/video_in_ip_1.0/hdl/video_in_ip_v1_0.v
}
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]

synth_design -top video_in_ip_v1_0 -part xc7a100tcsg324-1


write_checkpoint -force -noxdef video_in_ip_v1_0.dcp

catch { report_utilization -file video_in_ip_v1_0_utilization_synth.rpt -pb video_in_ip_v1_0_utilization_synth.pb }
