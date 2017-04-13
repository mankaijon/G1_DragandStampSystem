`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2017 08:19:06 PM
// Design Name: 
// Module Name: tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb();
        reg config_clk25;
        reg OV7670_VSYNC;
        reg OV7670_HREF;
        reg OV7670_PCLK;
        reg [7 : 0] OV7670_D;
        wire OV7670_XCLK;//output
        wire OV7670_SIOC;//output
        wire OV7670_SIOD;//output
        wire pwdn;//output
        wire resetI2C;//output
        wire [0 : 0] LEDR;//output
        reg BTNC;

        wire [31:0]m00_axis_tdata;//output
        wire m00_axis_tlast;//output
        wire m00_axis_tvalid;//output
        reg m00_axis_tready;
        wire m00_axis_tuser;//output
        reg m00_axis_aclk;
        reg m00_axis_aresetn;
      
      initial begin
        config_clk25 = 0;
        OV7670_VSYNC = 1;
        OV7670_HREF = 0;
        OV7670_PCLK = 0;
        OV7670_D = 8'b0;
        BTNC = 1;
        m00_axis_tready = 1;
        m00_axis_aclk = 0;
        m00_axis_aresetn = 1;
        #50 m00_axis_aresetn = 0;
        #50 m00_axis_aresetn = 1;
        
      end
      always begin
              #5 m00_axis_aclk = !m00_axis_aclk;
      end
      always begin
              #20 config_clk25 = !config_clk25;
      end
      always begin
              #20 OV7670_PCLK = !OV7670_PCLK;
      end      
      always begin
              #200 OV7670_VSYNC = 0;
              #18000 OV7670_VSYNC = 1;
     
      end
      always begin
              #1000 OV7670_HREF = 1;
              #5000 OV7670_HREF = 0;
      end
      
      always begin
              #40 OV7670_D = OV7670_D + 1;
      end
  video_in_ip_0 DUT(
        config_clk25,
        OV7670_VSYNC,
        OV7670_HREF,
        OV7670_PCLK,
        OV7670_D,
        OV7670_XCLK,
        OV7670_SIOC,
        OV7670_SIOD,
        pwdn,
        resetI2C,
        LEDR,
        BTNC,
        m00_axis_tdata,
        m00_axis_tlast,
        m00_axis_tvalid,
        m00_axis_tready,
        m00_axis_tuser,
        m00_axis_aclk,
        m00_axis_aresetn
      );
endmodule
