//Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
//Date        : Thu Mar 16 18:56:36 2017
//Host        : QIJUNWEN77B9 running 64-bit major release  (build 9200)
//Command     : generate_target design_1.bd
//Design      : design_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=4,numReposBlks=4,numNonXlnxBlks=1,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,da_board_cnt=3,synth_mode=Global}" *) (* HW_HANDOFF = "design_1.hwdef" *) 
module design_1
   (BTNC,
    LEDR,
    OV7670_D,
    OV7670_HREF,
    OV7670_PCLK,
    OV7670_SIOC,
    OV7670_SIOD,
    OV7670_VSYNC,
    OV7670_XCLK,
    clock_rtl,
    m00_axis_tready,
    pwdn,
    resetI2C,
    reset_rtl);
  input BTNC;
  output [0:0]LEDR;
  input [7:0]OV7670_D;
  input OV7670_HREF;
  input OV7670_PCLK;
  output OV7670_SIOC;
  inout OV7670_SIOD;
  input OV7670_VSYNC;
  output OV7670_XCLK;
  input clock_rtl;
  input m00_axis_tready;
  output pwdn;
  output resetI2C;
  input reset_rtl;

  (* MARK_DEBUG *) wire BTNC_1;
  wire Net;
  (* MARK_DEBUG *) wire [7:0]OV7670_D_1;
  wire OV7670_HREF_1;
  (* MARK_DEBUG *) wire OV7670_PCLK_1;
  (* MARK_DEBUG *) wire OV7670_VSYNC_1;
  wire clk_wiz_0_clk_out1;
  wire clk_wiz_0_clk_out2;
  wire clock_rtl_1;
  (* MARK_DEBUG *) wire [31:0]m00_axis_tdata;
  (* MARK_DEBUG *) wire m00_axis_tlast;
  wire m00_axis_tready_1;
  (* MARK_DEBUG *) wire m00_axis_tuser;
  (* MARK_DEBUG *) wire m00_axis_tvalid;
  wire [0:0]proc_sys_reset_0_interconnect_aresetn;
  wire reset_rtl_1;
  wire [0:0]video_in_ip_0_LEDR;
  wire video_in_ip_0_OV7670_SIOC;
  wire video_in_ip_0_OV7670_XCLK;
  wire video_in_ip_0_pwdn;
  wire video_in_ip_0_resetI2C;

  assign BTNC_1 = BTNC;
  assign LEDR[0] = video_in_ip_0_LEDR;
  assign OV7670_D_1 = OV7670_D[7:0];
  assign OV7670_HREF_1 = OV7670_HREF;
  assign OV7670_PCLK_1 = OV7670_PCLK;
  assign OV7670_SIOC = video_in_ip_0_OV7670_SIOC;
  assign OV7670_VSYNC_1 = OV7670_VSYNC;
  assign OV7670_XCLK = video_in_ip_0_OV7670_XCLK;
  assign clock_rtl_1 = clock_rtl;
  assign m00_axis_tready_1 = m00_axis_tready;
  assign pwdn = video_in_ip_0_pwdn;
  assign resetI2C = video_in_ip_0_resetI2C;
  assign reset_rtl_1 = reset_rtl;
  design_1_axi_vdma_0_0 axi_vdma_0
       (.axi_resetn(proc_sys_reset_0_interconnect_aresetn),
        .m_axi_s2mm_aclk(clk_wiz_0_clk_out1),
        .m_axi_s2mm_awready(1'b0),
        .m_axi_s2mm_bresp({1'b0,1'b0}),
        .m_axi_s2mm_bvalid(1'b0),
        .m_axi_s2mm_wready(1'b0),
        .s2mm_frame_ptr_in({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_lite_aclk(clk_wiz_0_clk_out1),
        .s_axi_lite_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_lite_arvalid(1'b0),
        .s_axi_lite_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_lite_awvalid(1'b0),
        .s_axi_lite_bready(1'b0),
        .s_axi_lite_rready(1'b0),
        .s_axi_lite_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_lite_wvalid(1'b0),
        .s_axis_s2mm_aclk(clk_wiz_0_clk_out1),
        .s_axis_s2mm_tdata(m00_axis_tdata),
        .s_axis_s2mm_tkeep({1'b1,1'b1,1'b1,1'b1}),
        .s_axis_s2mm_tlast(m00_axis_tlast),
        .s_axis_s2mm_tuser(m00_axis_tuser),
        .s_axis_s2mm_tvalid(m00_axis_tvalid));
  design_1_clk_wiz_0_0 clk_wiz_0
       (.clk_in1(clock_rtl_1),
        .clk_out1(clk_wiz_0_clk_out1),
        .clk_out2(clk_wiz_0_clk_out2),
        .resetn(reset_rtl_1));
  design_1_proc_sys_reset_0_0 proc_sys_reset_0
       (.aux_reset_in(1'b1),
        .dcm_locked(1'b1),
        .ext_reset_in(reset_rtl_1),
        .interconnect_aresetn(proc_sys_reset_0_interconnect_aresetn),
        .mb_debug_sys_rst(1'b0),
        .slowest_sync_clk(clk_wiz_0_clk_out1));
  design_1_video_in_ip_0_0 video_in_ip_0
       (.BTNC(BTNC_1),
        .LEDR(video_in_ip_0_LEDR),
        .OV7670_D(OV7670_D_1),
        .OV7670_HREF(OV7670_HREF_1),
        .OV7670_PCLK(OV7670_PCLK_1),
        .OV7670_SIOC(video_in_ip_0_OV7670_SIOC),
        .OV7670_SIOD(OV7670_SIOD),
        .OV7670_VSYNC(OV7670_VSYNC_1),
        .OV7670_XCLK(video_in_ip_0_OV7670_XCLK),
        .config_clk25(clk_wiz_0_clk_out2),
        .m00_axis_aclk(clk_wiz_0_clk_out1),
        .m00_axis_aresetn(proc_sys_reset_0_interconnect_aresetn),
        .m00_axis_tdata(m00_axis_tdata),
        .m00_axis_tlast(m00_axis_tlast),
        .m00_axis_tready(m00_axis_tready_1),
        .m00_axis_tuser(m00_axis_tuser),
        .m00_axis_tvalid(m00_axis_tvalid),
        .pwdn(video_in_ip_0_pwdn),
        .resetI2C(video_in_ip_0_resetI2C));
endmodule
