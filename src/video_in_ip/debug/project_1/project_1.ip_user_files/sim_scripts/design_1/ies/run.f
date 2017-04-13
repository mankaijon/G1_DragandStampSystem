-makelib ies/xil_defaultlib -sv \
  "C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_base.sv" \
  "C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_dpdistram.sv" \
  "C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_dprom.sv" \
  "C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_sdpram.sv" \
  "C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_spram.sv" \
  "C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_sprom.sv" \
  "C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_tdpram.sv" \
-endlib
-makelib ies/xpm \
  "C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies/fifo_generator_v13_0_3 \
  "../../../../project_1.srcs/sources_1/bd/design_1/ip/edit_video_in_ip_v1_0.srcs/sources_1/ip/v_vid_in_axi4s_0/fifo_generator_v13_0_3/simulation/fifo_generator_vhdl_beh.vhd" \
  "../../../../project_1.srcs/sources_1/bd/design_1/ip/edit_video_in_ip_v1_0.srcs/sources_1/ip/v_vid_in_axi4s_0/fifo_generator_v13_0_3/hdl/fifo_generator_v13_0_rfs.vhd" \
-endlib
-makelib ies/v_vid_in_axi4s_v4_0_3 \
  "../../../../project_1.srcs/sources_1/bd/design_1/ip/edit_video_in_ip_v1_0.srcs/sources_1/ip/v_vid_in_axi4s_0/v_vid_in_axi4s_v4_0_3/hdl/verilog/v_vid_in_axi4s_v4_0_coupler.v" \
  "../../../../project_1.srcs/sources_1/bd/design_1/ip/edit_video_in_ip_v1_0.srcs/sources_1/ip/v_vid_in_axi4s_0/v_vid_in_axi4s_v4_0_3/hdl/verilog/v_vid_in_axi4s_v4_0_formatter.v" \
  "../../../../project_1.srcs/sources_1/bd/design_1/ip/edit_video_in_ip_v1_0.srcs/sources_1/ip/v_vid_in_axi4s_0/v_vid_in_axi4s_v4_0_3/hdl/verilog/v_vid_in_axi4s_v4_0.v" \
  "../../../bd/design_1/ip/edit_video_in_ip_v1_0.srcs/sources_1/ip/v_vid_in_axi4s_0/sim/v_vid_in_axi4s_0.v" \
-endlib
-makelib ies/xil_defaultlib \
  "../../../bd/design_1/ipshared/user/video_in_ip_v1_0/src/I2C_Controller.v" \
  "../../../bd/design_1/ipshared/user/video_in_ip_v1_0/src/I2C_OV7670_RGB565_VGA_Config.v" \
  "../../../bd/design_1/ipshared/user/video_in_ip_v1_0/src/debounce.v" \
  "../../../bd/design_1/ipshared/user/video_in_ip_v1_0/src/I2C_AV_Config.v" \
  "../../../bd/design_1/ipshared/user/video_in_ip_v1_0/src/capture.v" \
  "../../../bd/design_1/ipshared/user/video_in_ip_v1_0/src/ov7670_top.v" \
  "../../../bd/design_1/ipshared/user/video_in_ip_v1_0/hdl/video_in_ip_v1_0.v" \
  "../../../bd/design_1/ip/design_1_video_in_ip_0_0/sim/design_1_video_in_ip_0_0.v" \
  "../../../bd/design_1/ip/design_1_clk_wiz_0_0/design_1_clk_wiz_0_0_clk_wiz.v" \
  "../../../bd/design_1/ip/design_1_clk_wiz_0_0/design_1_clk_wiz_0_0.v" \
-endlib
-makelib ies/lib_cdc_v1_0_2 \
  "../../../ipstatic/lib_cdc_v1_0/hdl/src/vhdl/cdc_sync.vhd" \
-endlib
-makelib ies/proc_sys_reset_v5_0_9 \
  "../../../ipstatic/proc_sys_reset_v5_0/hdl/src/vhdl/upcnt_n.vhd" \
  "../../../ipstatic/proc_sys_reset_v5_0/hdl/src/vhdl/sequence_psr.vhd" \
  "../../../ipstatic/proc_sys_reset_v5_0/hdl/src/vhdl/lpf.vhd" \
  "../../../ipstatic/proc_sys_reset_v5_0/hdl/src/vhdl/proc_sys_reset.vhd" \
-endlib
-makelib ies/xil_defaultlib \
  "../../../bd/design_1/ip/design_1_proc_sys_reset_0_0/sim/design_1_proc_sys_reset_0_0.vhd" \
-endlib
-makelib ies/xil_defaultlib \
  "../../../bd/design_1/hdl/design_1.v" \
-endlib
-makelib ies/lib_pkg_v1_0_2 \
  "../../../ipstatic/lib_pkg_v1_0/hdl/src/vhdl/lib_pkg.vhd" \
-endlib
-makelib ies/fifo_generator_v13_1_1 \
  "../../../ipstatic/fifo_generator_v13_1/simulation/fifo_generator_vlog_beh.v" \
-endlib
-makelib ies/fifo_generator_v13_1_1 \
  "../../../ipstatic/fifo_generator_v13_1/hdl/fifo_generator_v13_1_rfs.vhd" \
-endlib
-makelib ies/fifo_generator_v13_1_1 \
  "../../../ipstatic/fifo_generator_v13_1/hdl/fifo_generator_v13_1_rfs.v" \
-endlib
-makelib ies/lib_fifo_v1_0_5 \
  "../../../ipstatic/lib_fifo_v1_0/hdl/src/vhdl/async_fifo_fg.vhd" \
  "../../../ipstatic/lib_fifo_v1_0/hdl/src/vhdl/sync_fifo_fg.vhd" \
-endlib
-makelib ies/blk_mem_gen_v8_3_3 \
  "../../../ipstatic/blk_mem_gen_v8_3/simulation/blk_mem_gen_v8_3.v" \
-endlib
-makelib ies/lib_bmg_v1_0_5 \
  "../../../ipstatic/lib_bmg_v1_0/hdl/src/vhdl/blk_mem_gen_wrapper.vhd" \
-endlib
-makelib ies/lib_srl_fifo_v1_0_2 \
  "../../../ipstatic/lib_srl_fifo_v1_0/hdl/src/vhdl/cntr_incr_decr_addn_f.vhd" \
  "../../../ipstatic/lib_srl_fifo_v1_0/hdl/src/vhdl/dynshreg_f.vhd" \
  "../../../ipstatic/lib_srl_fifo_v1_0/hdl/src/vhdl/srl_fifo_rbu_f.vhd" \
  "../../../ipstatic/lib_srl_fifo_v1_0/hdl/src/vhdl/srl_fifo_f.vhd" \
-endlib
-makelib ies/axi_datamover_v5_1_11 \
  "../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_reset.vhd" \
  "../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_afifo_autord.vhd" \
  "../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_sfifo_autord.vhd" \
  "../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_fifo.vhd" \
  "../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_cmd_status.vhd" \
  "../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_scc.vhd" \
  "../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_strb_gen2.vhd" \
  "../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_pcc.vhd" \
  "../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_addr_cntl.vhd" \
  "../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_rdmux.vhd" \
  "../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_rddata_cntl.vhd" \
  "../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_rd_status_cntl.vhd" \
  "../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_wr_demux.vhd" \
  "../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_wrdata_cntl.vhd" \
  "../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_wr_status_cntl.vhd" \
  "../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_skid2mm_buf.vhd" \
  "../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_skid_buf.vhd" \
  "../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_rd_sf.vhd" \
  "../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_wr_sf.vhd" \
  "../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_stbs_set.vhd" \
  "../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_stbs_set_nodre.vhd" \
  "../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_ibttcc.vhd" \
  "../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_indet_btt.vhd" \
  "../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_dre_mux2_1_x_n.vhd" \
  "../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_dre_mux4_1_x_n.vhd" \
  "../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_dre_mux8_1_x_n.vhd" \
  "../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_mm2s_dre.vhd" \
  "../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_s2mm_dre.vhd" \
  "../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_ms_strb_set.vhd" \
  "../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_mssai_skid_buf.vhd" \
  "../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_slice.vhd" \
  "../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_s2mm_scatter.vhd" \
  "../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_s2mm_realign.vhd" \
  "../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_s2mm_basic_wrap.vhd" \
  "../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_s2mm_omit_wrap.vhd" \
  "../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_s2mm_full_wrap.vhd" \
  "../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_mm2s_basic_wrap.vhd" \
  "../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_mm2s_omit_wrap.vhd" \
  "../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_mm2s_full_wrap.vhd" \
  "../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover.vhd" \
-endlib
-makelib ies/axi_vdma_v6_2_8 \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/verilog/axi_vdma_v6_2_axis_infrastructure_v1_0_util_axis2vector.v" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/verilog/axi_vdma_v6_2_axis_infrastructure_v1_0_util_vector2axis.v" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/verilog/axi_vdma_v6_2_axis_register_slice_v1_0_axisc_register_slice.v" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/verilog/axi_vdma_v6_2_axis_register_slice_v1_0_axis_register_slice.v" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/verilog/axi_vdma_v6_2_axis_dwidth_converter_v1_0_axisc_upsizer.v" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/verilog/axi_vdma_v6_2_axis_dwidth_converter_v1_0_axisc_downsizer.v" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/verilog/axi_vdma_v6_2_axis_dwidth_converter_v1_0_axis_dwidth_converter.v" \
-endlib
-makelib ies/axi_vdma_v6_2_8 \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_sg_pkg.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_sg_ftch_sm.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_sg_ftch_pntr.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_sg_ftch_cmdsts_if.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_sg_ftch_mngr.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_sg_afifo_autord.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_sg_ftch_queue.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_sg_ftch_noqueue.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_sg_ftch_q_mngr.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_sg_updt_cmdsts_if.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_sg_updt_sm.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_sg_updt_mngr.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_sg_updt_queue.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_sg_updt_noqueue.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_sg_updt_q_mngr.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_sg_intrpt.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_sg.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma_pkg.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma_cdc.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma_vid_cdc.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma_sg_cdc.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma_reset.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma_rst_module.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma_lite_if.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma_register.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma_regdirect.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma_reg_mux.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma_reg_module.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma_reg_if.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma_intrpt.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma_sof_gen.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma_skid_buf.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma_sfifo.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma_sfifo_autord.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma_afifo_builtin.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma_afifo.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma_afifo_autord.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma_mm2s_linebuf.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma_s2mm_linebuf.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma_blkmem.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma_fsync_gen.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma_vregister.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma_vregister_64.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma_sgregister.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma_vaddrreg_mux.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma_vaddrreg_mux_64.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma_vidreg_module.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma_vidreg_module_64.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma_genlock_mux.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma_greycoder.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma_genlock_mngr.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma_sg_if.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma_sm.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma_cmdsts_if.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma_sts_mngr.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma_mngr.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma_mngr_64.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma_mm2s_axis_dwidth_converter.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma_s2mm_axis_dwidth_converter.vhd" \
  "../../../ipstatic/axi_vdma_v6_2/hdl/src/vhdl/axi_vdma.vhd" \
-endlib
-makelib ies/xil_defaultlib \
  "../../../bd/design_1/ip/design_1_axi_vdma_0_0/sim/design_1_axi_vdma_0_0.vhd" \
-endlib
-makelib ies/xil_defaultlib \
  glbl.v
-endlib

