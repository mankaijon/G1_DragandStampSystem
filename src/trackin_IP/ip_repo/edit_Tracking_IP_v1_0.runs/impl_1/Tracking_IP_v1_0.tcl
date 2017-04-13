proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
  set_property webtalk.parent_dir C:/Users/jon/ECE532/tracking/trackin_IP/ip_repo/edit_Tracking_IP_v1_0.cache/wt [current_project]
  set_property parent.project_path C:/Users/jon/ECE532/tracking/trackin_IP/ip_repo/edit_Tracking_IP_v1_0.xpr [current_project]
  set_property ip_repo_paths {
  c:/Users/jon/ECE532/tracking/trackin_IP/ip_repo/edit_Tracking_IP_v1_0.cache/ip
  C:/Users/jon/ECE532/tracking/trackin_IP/ip_repo/Tracking_IP_1.0
} [current_project]
  set_property ip_output_repo c:/Users/jon/ECE532/tracking/trackin_IP/ip_repo/edit_Tracking_IP_v1_0.cache/ip [current_project]
  add_files -quiet C:/Users/jon/ECE532/tracking/trackin_IP/ip_repo/edit_Tracking_IP_v1_0.runs/synth_1/Tracking_IP_v1_0.dcp
  link_design -top Tracking_IP_v1_0 -part xc7a100tcsg324-1
  write_hwdef -file Tracking_IP_v1_0.hwdef
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  opt_design 
  write_checkpoint -force Tracking_IP_v1_0_opt.dcp
  report_drc -file Tracking_IP_v1_0_drc_opted.rpt
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  implement_debug_core 
  place_design 
  write_checkpoint -force Tracking_IP_v1_0_placed.dcp
  report_io -file Tracking_IP_v1_0_io_placed.rpt
  report_utilization -file Tracking_IP_v1_0_utilization_placed.rpt -pb Tracking_IP_v1_0_utilization_placed.pb
  report_control_sets -verbose -file Tracking_IP_v1_0_control_sets_placed.rpt
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force Tracking_IP_v1_0_routed.dcp
  report_drc -file Tracking_IP_v1_0_drc_routed.rpt -pb Tracking_IP_v1_0_drc_routed.pb
  report_timing_summary -warn_on_violation -max_paths 10 -file Tracking_IP_v1_0_timing_summary_routed.rpt -rpx Tracking_IP_v1_0_timing_summary_routed.rpx
  report_power -file Tracking_IP_v1_0_power_routed.rpt -pb Tracking_IP_v1_0_power_summary_routed.pb -rpx Tracking_IP_v1_0_power_routed.rpx
  report_route_status -file Tracking_IP_v1_0_route_status.rpt -pb Tracking_IP_v1_0_route_status.pb
  report_clock_utilization -file Tracking_IP_v1_0_clock_utilization_routed.rpt
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

