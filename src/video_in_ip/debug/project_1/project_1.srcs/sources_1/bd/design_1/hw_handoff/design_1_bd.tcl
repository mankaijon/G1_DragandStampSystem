
################################################################
# This is a generated script based on design: design_1
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2016.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source design_1_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7a100tcsg324-1
}


# CHANGE DESIGN NAME HERE
set design_name design_1

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports
  set BTNC [ create_bd_port -dir I BTNC ]
  set LEDR [ create_bd_port -dir O -from 0 -to 0 LEDR ]
  set OV7670_D [ create_bd_port -dir I -from 7 -to 0 OV7670_D ]
  set OV7670_HREF [ create_bd_port -dir I OV7670_HREF ]
  set OV7670_PCLK [ create_bd_port -dir I OV7670_PCLK ]
  set OV7670_SIOC [ create_bd_port -dir O OV7670_SIOC ]
  set OV7670_SIOD [ create_bd_port -dir IO OV7670_SIOD ]
  set OV7670_VSYNC [ create_bd_port -dir I OV7670_VSYNC ]
  set OV7670_XCLK [ create_bd_port -dir O OV7670_XCLK ]
  set clock_rtl [ create_bd_port -dir I -type clk clock_rtl ]
  set_property -dict [ list \
CONFIG.FREQ_HZ {100000000} \
CONFIG.PHASE {0.000} \
 ] $clock_rtl
  set m00_axis_tready [ create_bd_port -dir I m00_axis_tready ]
  set pwdn [ create_bd_port -dir O pwdn ]
  set resetI2C [ create_bd_port -dir O resetI2C ]
  set reset_rtl [ create_bd_port -dir I -type rst reset_rtl ]
  set_property -dict [ list \
CONFIG.POLARITY {ACTIVE_LOW} \
 ] $reset_rtl

  # Create instance: axi_vdma_0, and set properties
  set axi_vdma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vdma:6.2 axi_vdma_0 ]
  set_property -dict [ list \
CONFIG.c_include_mm2s {0} \
CONFIG.c_include_s2mm {1} \
CONFIG.c_mm2s_genlock_mode {0} \
 ] $axi_vdma_0

  # Create instance: clk_wiz_0, and set properties
  set clk_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:5.3 clk_wiz_0 ]
  set_property -dict [ list \
CONFIG.CLKOUT1_JITTER {130.958} \
CONFIG.CLKOUT1_PHASE_ERROR {98.575} \
CONFIG.CLKOUT2_JITTER {175.402} \
CONFIG.CLKOUT2_PHASE_ERROR {98.575} \
CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {25} \
CONFIG.CLKOUT2_USED {true} \
CONFIG.MMCM_CLKFBOUT_MULT_F {10.000} \
CONFIG.MMCM_CLKIN1_PERIOD {10.0} \
CONFIG.MMCM_CLKIN2_PERIOD {10.0} \
CONFIG.MMCM_CLKOUT0_DIVIDE_F {10.000} \
CONFIG.MMCM_CLKOUT1_DIVIDE {40} \
CONFIG.MMCM_COMPENSATION {ZHOLD} \
CONFIG.MMCM_DIVCLK_DIVIDE {1} \
CONFIG.NUM_OUT_CLKS {2} \
CONFIG.RESET_PORT {resetn} \
CONFIG.RESET_TYPE {ACTIVE_LOW} \
 ] $clk_wiz_0

  # Need to retain value_src of defaults
  set_property -dict [ list \
CONFIG.CLKOUT1_JITTER.VALUE_SRC {DEFAULT} \
CONFIG.CLKOUT1_PHASE_ERROR.VALUE_SRC {DEFAULT} \
CONFIG.MMCM_CLKFBOUT_MULT_F.VALUE_SRC {DEFAULT} \
CONFIG.MMCM_CLKIN1_PERIOD.VALUE_SRC {DEFAULT} \
CONFIG.MMCM_CLKIN2_PERIOD.VALUE_SRC {DEFAULT} \
CONFIG.MMCM_CLKOUT0_DIVIDE_F.VALUE_SRC {DEFAULT} \
CONFIG.MMCM_COMPENSATION.VALUE_SRC {DEFAULT} \
 ] $clk_wiz_0

  # Create instance: proc_sys_reset_0, and set properties
  set proc_sys_reset_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_0 ]

  # Create instance: video_in_ip_0, and set properties
  set video_in_ip_0 [ create_bd_cell -type ip -vlnv user:user:video_in_ip:1.0 video_in_ip_0 ]

  # Create port connections
  connect_bd_net -net BTNC_1 [get_bd_ports BTNC] [get_bd_pins video_in_ip_0/BTNC]
  set_property -dict [ list \
HDL_ATTRIBUTE.MARK_DEBUG {true} \
 ] [get_bd_nets BTNC_1]
  connect_bd_net -net Net [get_bd_ports OV7670_SIOD] [get_bd_pins video_in_ip_0/OV7670_SIOD]
  connect_bd_net -net OV7670_D_1 [get_bd_ports OV7670_D] [get_bd_pins video_in_ip_0/OV7670_D]
  set_property -dict [ list \
HDL_ATTRIBUTE.MARK_DEBUG {true} \
 ] [get_bd_nets OV7670_D_1]
  connect_bd_net -net OV7670_HREF_1 [get_bd_ports OV7670_HREF] [get_bd_pins video_in_ip_0/OV7670_HREF]
  connect_bd_net -net OV7670_PCLK_1 [get_bd_ports OV7670_PCLK] [get_bd_pins video_in_ip_0/OV7670_PCLK]
  set_property -dict [ list \
HDL_ATTRIBUTE.MARK_DEBUG {true} \
 ] [get_bd_nets OV7670_PCLK_1]
  connect_bd_net -net OV7670_VSYNC_1 [get_bd_ports OV7670_VSYNC] [get_bd_pins video_in_ip_0/OV7670_VSYNC]
  set_property -dict [ list \
HDL_ATTRIBUTE.MARK_DEBUG {true} \
 ] [get_bd_nets OV7670_VSYNC_1]
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_pins axi_vdma_0/m_axi_s2mm_aclk] [get_bd_pins axi_vdma_0/s_axi_lite_aclk] [get_bd_pins axi_vdma_0/s_axis_s2mm_aclk] [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins proc_sys_reset_0/slowest_sync_clk] [get_bd_pins video_in_ip_0/m00_axis_aclk]
  connect_bd_net -net clk_wiz_0_clk_out2 [get_bd_pins clk_wiz_0/clk_out2] [get_bd_pins video_in_ip_0/config_clk25]
  connect_bd_net -net clock_rtl_1 [get_bd_ports clock_rtl] [get_bd_pins clk_wiz_0/clk_in1]
  connect_bd_net -net m00_axis_tdata [get_bd_pins axi_vdma_0/s_axis_s2mm_tdata] [get_bd_pins video_in_ip_0/m00_axis_tdata]
  set_property -dict [ list \
HDL_ATTRIBUTE.MARK_DEBUG {true} \
 ] [get_bd_nets m00_axis_tdata]
  connect_bd_net -net m00_axis_tlast [get_bd_pins axi_vdma_0/s_axis_s2mm_tlast] [get_bd_pins video_in_ip_0/m00_axis_tlast]
  set_property -dict [ list \
HDL_ATTRIBUTE.MARK_DEBUG {true} \
 ] [get_bd_nets m00_axis_tlast]
  connect_bd_net -net m00_axis_tready_1 [get_bd_ports m00_axis_tready] [get_bd_pins video_in_ip_0/m00_axis_tready]
  connect_bd_net -net m00_axis_tuser [get_bd_pins axi_vdma_0/s_axis_s2mm_tuser] [get_bd_pins video_in_ip_0/m00_axis_tuser]
  set_property -dict [ list \
HDL_ATTRIBUTE.MARK_DEBUG {true} \
 ] [get_bd_nets m00_axis_tuser]
  connect_bd_net -net m00_axis_tvalid [get_bd_pins axi_vdma_0/s_axis_s2mm_tvalid] [get_bd_pins video_in_ip_0/m00_axis_tvalid]
  set_property -dict [ list \
HDL_ATTRIBUTE.MARK_DEBUG {true} \
 ] [get_bd_nets m00_axis_tvalid]
  connect_bd_net -net proc_sys_reset_0_interconnect_aresetn [get_bd_pins axi_vdma_0/axi_resetn] [get_bd_pins proc_sys_reset_0/interconnect_aresetn] [get_bd_pins video_in_ip_0/m00_axis_aresetn]
  connect_bd_net -net reset_rtl_1 [get_bd_ports reset_rtl] [get_bd_pins clk_wiz_0/resetn] [get_bd_pins proc_sys_reset_0/ext_reset_in]
  connect_bd_net -net video_in_ip_0_LEDR [get_bd_ports LEDR] [get_bd_pins video_in_ip_0/LEDR]
  connect_bd_net -net video_in_ip_0_OV7670_SIOC [get_bd_ports OV7670_SIOC] [get_bd_pins video_in_ip_0/OV7670_SIOC]
  connect_bd_net -net video_in_ip_0_OV7670_XCLK [get_bd_ports OV7670_XCLK] [get_bd_pins video_in_ip_0/OV7670_XCLK]
  connect_bd_net -net video_in_ip_0_pwdn [get_bd_ports pwdn] [get_bd_pins video_in_ip_0/pwdn]
  connect_bd_net -net video_in_ip_0_resetI2C [get_bd_ports resetI2C] [get_bd_pins video_in_ip_0/resetI2C]

  # Create address segments

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   guistr: "# # String gsaved with Nlview 6.5.12  2016-01-29 bk=1.3547 VDI=39 GEI=35 GUI=JA:1.6
#  -string -flagsOSRD
preplace port pwdn -pg 1 -y 380 -defaultsOSRD
preplace port m00_axis_tready -pg 1 -y 150 -defaultsOSRD
preplace port OV7670_XCLK -pg 1 -y 320 -defaultsOSRD
preplace port OV7670_VSYNC -pg 1 -y 250 -defaultsOSRD
preplace port OV7670_HREF -pg 1 -y 270 -defaultsOSRD
preplace port reset_rtl -pg 1 -y 380 -defaultsOSRD
preplace port OV7670_SIOC -pg 1 -y 340 -defaultsOSRD
preplace port OV7670_SIOD -pg 1 -y 360 -defaultsOSRD
preplace port resetI2C -pg 1 -y 400 -defaultsOSRD
preplace port OV7670_PCLK -pg 1 -y 300 -defaultsOSRD
preplace port BTNC -pg 1 -y 360 -defaultsOSRD
preplace port clock_rtl -pg 1 -y 430 -defaultsOSRD
preplace portBus OV7670_D -pg 1 -y 330 -defaultsOSRD
preplace portBus LEDR -pg 1 -y 420 -defaultsOSRD
preplace inst axi_vdma_0 -pg 1 -lvl 4 -y 160 -defaultsOSRD
preplace inst proc_sys_reset_0 -pg 1 -lvl 2 -y 460 -defaultsOSRD
preplace inst clk_wiz_0 -pg 1 -lvl 1 -y 420 -defaultsOSRD
preplace inst video_in_ip_0 -pg 1 -lvl 3 -y 310 -defaultsOSRD
preplace netloc OV7670_HREF_1 1 0 3 NJ 270 NJ 270 NJ
preplace netloc m00_axis_tdata 1 3 1 910
preplace netloc video_in_ip_0_resetI2C 1 3 2 NJ 400 NJ
preplace netloc OV7670_D_1 1 0 3 NJ 320 NJ 320 NJ
preplace netloc video_in_ip_0_OV7670_SIOC 1 3 2 NJ 340 NJ
preplace netloc OV7670_PCLK_1 1 0 3 NJ 300 NJ 300 NJ
preplace netloc m00_axis_tvalid 1 3 1 960
preplace netloc proc_sys_reset_0_interconnect_aresetn 1 2 2 560 120 940
preplace netloc m00_axis_tlast 1 3 1 950
preplace netloc m00_axis_tready_1 1 0 4 NJ 150 NJ 150 NJ 150 900
preplace netloc video_in_ip_0_OV7670_XCLK 1 3 2 NJ 320 NJ
preplace netloc clk_wiz_0_clk_out1 1 1 3 220 360 580 140 920
preplace netloc clk_wiz_0_clk_out2 1 1 2 NJ 240 N
preplace netloc m00_axis_tuser 1 3 1 930
preplace netloc OV7670_VSYNC_1 1 0 3 NJ 250 NJ 250 NJ
preplace netloc Net 1 3 2 NJ 360 NJ
preplace netloc clock_rtl_1 1 0 1 NJ
preplace netloc video_in_ip_0_pwdn 1 3 2 NJ 380 NJ
preplace netloc BTNC_1 1 0 3 NJ 340 NJ 340 NJ
preplace netloc video_in_ip_0_LEDR 1 3 2 NJ 420 NJ
preplace netloc reset_rtl_1 1 0 2 40 490 210
levelinfo -pg 1 0 130 390 740 1160 1370 -top 0 -bot 550
",
}

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


