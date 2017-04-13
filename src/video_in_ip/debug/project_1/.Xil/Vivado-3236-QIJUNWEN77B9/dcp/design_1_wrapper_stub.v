// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module design_1_wrapper(BTNC, LEDR, OV7670_D, OV7670_HREF, OV7670_PCLK, OV7670_SIOC, OV7670_SIOD, OV7670_VSYNC, OV7670_XCLK, clock_rtl, m00_axis_tready, pwdn, resetI2C, reset_rtl);
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
endmodule
