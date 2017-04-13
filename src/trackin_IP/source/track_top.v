module track(
    input clk,
    input resetn,
    input s,
    input [31:0] data_in,
    input valid,
    input [31:0] ref_color,
    input [31:0] threshold,
    output  done,
    output [31:0] x_pos,
    output [31:0] y_pos
    );
	//fsm to datapath
	wire reset_x;
	wire reset_y;
	wire reset_x_sum;	
	wire reset_y_sum;
	wire reset_count;
	wire reset_x_pos;
	wire reset_y_pos;
	wire enable_x;
	wire enable_y;	
	wire enable_x_sum;	
	wire enable_y_sum;	
	wire enable_x_pos;	
	wire enable_y_pos;
	wire enable_count;
	wire sel;
	
	//datapath to fsm
	wire x_lt_640;
	wire x_eq_640;
	wire y_eq_480;
	wire found;
	wire count_ne_0;
		
	tracking_fsm fsm(
		resetn,
		clk,
		s,
		valid,
		found,
		x_lt_640,
		x_eq_640,
		y_eq_480,
		count_ne_0,
		reset_x,
		reset_y,
		reset_x_sum,	
		reset_y_sum,
		reset_count,
		done,
		reset_x_pos,
		reset_y_pos,
		enable_x,	
		enable_y,	
		enable_x_sum,	
		enable_y_sum,	
		enable_x_pos,	
		enable_y_pos,
		enable_count,
		sel
	);
	
	datapath datapath(
		clk,
		data_in,
		ref_color,
		threshold,
		reset_x,
		reset_y,
		reset_x_sum,	
		reset_y_sum,
		reset_count,
		reset_x_pos,
		reset_y_pos,
		enable_x,	
		enable_y,	
		enable_x_sum,	
		enable_y_sum,	
		enable_x_pos,	
		enable_y_pos,
		enable_count,
		sel,
		x_lt_640,
		x_eq_640,
		y_eq_480,
		count_ne_0,
		x_pos,
		y_pos,
		found
);
endmodule