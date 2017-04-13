`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2017 04:24:51 PM
// Design Name: 
// Module Name: abs
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


module abs#(
        parameter width = 5
    )
    (
    input [width-1:0] a,
    input [width-1:0] b,
    output reg [width-1:0] abs_diff
    );
    always@(*)begin
        if(a>b)
            abs_diff = a-b;
        else 
            abs_diff = b-a;
    end
endmodule
