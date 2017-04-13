module datapath(
	input clk,
    input [31:0] data_in,
    input [31:0] ref_color,
    input [31:0] threshold,
	input reset_x,
	input reset_y,
	input reset_x_sum,	
	input reset_y_sum,
	input reset_count,
	input reset_x_pos,
	input reset_y_pos,
	input enable_x,	
	input enable_y,	
	input enable_x_sum,	
	input enable_y_sum,	
	input enable_x_pos,	
	input enable_y_pos,
	input enable_count,
	input sel,
	output x_eq_640,
	output y_eq_480,
	output count_ne_0,
	output [31:0]x_pos,
	output [31:0]y_pos,
	output reg found
);
	wire [31:0]x_sum, y_sum ,count;
	wire [31:0]x, y;
	
	//input RGB data
    wire [4:0] R,B;
    wire [5:0]G;
    //input refernece color
    wire [4:0] R_ref,B_ref;
    wire [5:0]G_ref;    
    //threshold value
    wire [4:0]R_th,B_th;
    wire [5:0]G_th;
    
    wire [4:0]abs_diff_R,abs_diff_B;
    wire [5:0]abs_diff_G;
    
    wire [31:0]x_pos_din,y_pos_din;
    assign x_pos_din = (!sel)?x_sum/count:32'hffffffff;
    assign y_pos_din = (!sel)?y_sum/count:32'hffffffff;
	
	register #(32)x_sum0(.clk(clk),.reset(reset_x_sum),.enable(enable_x_sum),.din(x_sum + x),.dout(x_sum));
	register #(32)y_sum0(.clk(clk),.reset(reset_y_sum),.enable(enable_y_sum),.din(y_sum + y),.dout(y_sum));
	register #(32)x_pos0(.clk(clk),.reset(reset_x_pos),.enable(enable_x_pos),.din(x_pos_din),.dout(x_pos));
	register #(32)y_pos0(.clk(clk),.reset(reset_y_pos),.enable(enable_y_pos),.din(y_pos_din),.dout(y_pos));
	counter  #(32)x0(.clk(clk),.reset(reset_x),.enable(enable_x),.dout(x));
	counter  #(32)y0(.clk(clk),.reset(reset_y),.enable(enable_y),.dout(y));
	counter  #(32)count0(.clk(clk),.reset(reset_count),.enable(enable_count),.dout(count));
	
	assign x_eq_640 = (x ==640-1)?1'b1:1'b0;
	assign y_eq_480 = (y==480-1)?1'b1:1'b0;
	assign count_ne_0 = (count!=0)?1'b1:1'b0;
	
	assign R = data_in[23:19];
    assign G = data_in[15:10];
    assign B = data_in[7:3];
    
    assign R_th = threshold[20:16];
    assign G_th = threshold[13:8];
    assign B_th = threshold[4:0];

    assign R_ref = ref_color[23:19];
    assign G_ref = ref_color[15:10];
    assign B_ref = ref_color[7:3];    
    //compare the input pixel with the reference color 
    abs #(5)R_diff (R,R_ref,abs_diff_R);
    abs #(6)G_diff (G,G_ref,abs_diff_G);
    abs #(5)B_diff (B,B_ref,abs_diff_B);
    // generate found signal        
    always@(*)begin
        if((abs_diff_R<=R_th)&(abs_diff_G<=G_th)&(abs_diff_B<=B_th))
            found = 1'b1;
        else
            found = 1'b0;
    end
			
endmodule

module register#
	(
		parameter width = 32
	)
	(
		input clk,
		input reset,
		input enable,
		input [width-1:0] din,
		output reg [width-1:0] dout
	);
	always@(posedge clk) begin
		if(reset) dout <= 32'b0;
		else if(enable) dout <= din;
	end
endmodule

module counter#
	(
		parameter width = 32
	)
	(
		input clk,
		input reset,
		input enable,
		output reg [width-1:0]dout		
	);
	always@(posedge clk)begin
		if(reset)dout <= 32'b0;
		else if(enable)dout <= dout + 1;
	end
endmodule