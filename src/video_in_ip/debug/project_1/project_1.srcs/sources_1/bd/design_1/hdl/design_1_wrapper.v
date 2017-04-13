//Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
//Date        : Thu Mar 16 18:56:36 2017
//Host        : QIJUNWEN77B9 running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
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

  wire BTNC;
  wire [0:0]LEDR;
  wire [7:0]OV7670_D;
  wire OV7670_HREF;
  wire OV7670_PCLK;
  wire OV7670_SIOC;
  wire OV7670_SIOD;
  wire OV7670_VSYNC;
  wire OV7670_XCLK;
  wire clock_rtl;
  wire m00_axis_tready;
  wire pwdn;
  wire resetI2C;
  wire reset_rtl;

  design_1 design_1_i
       (.BTNC(BTNC),
        .LEDR(LEDR),
        .OV7670_D(OV7670_D),
        .OV7670_HREF(OV7670_HREF),
        .OV7670_PCLK(OV7670_PCLK),
        .OV7670_SIOC(OV7670_SIOC),
        .OV7670_SIOD(OV7670_SIOD),
        .OV7670_VSYNC(OV7670_VSYNC),
        .OV7670_XCLK(OV7670_XCLK),
        .clock_rtl(clock_rtl),
        .m00_axis_tready(m00_axis_tready),
        .pwdn(pwdn),
        .resetI2C(resetI2C),
        .reset_rtl(reset_rtl));
endmodule
