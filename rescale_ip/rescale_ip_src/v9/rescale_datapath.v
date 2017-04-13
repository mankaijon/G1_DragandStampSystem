module rescale_datapath(
// gloabal clock
input clock,

// external input
input [9:0] x_in,
input [9:0] y_in,

// top-level input
input [15:0] neighbor0,
input [15:0] neighbor1,
input [15:0] neighbor2,
input [15:0] neighbor3,
input [bit_num-1:0] read_pointer, // 320x240 = 76800 output words, so need 13 bits to address

// reset input (internal)
input reset,
input reset_c_j_cnt,
input reset_r_j_cnt,
input reset_store_pointer,

// select input (internal)
input sel_done,
input sel_in_stream_ready,
//input sel_out_stream_ready,

// load input (internal)
input ld_done,
input ld_c_j,
input ld_r_j,
input ld_ratio_c,
input ld_ratio_r,
input ld_c_j_cnt,
input ld_r_j_cnt,
input ld_c_rescaled,
input ld_r_rescaled,
input ld_neighbor0, 
input ld_neighbor1, 
input ld_neighbor2, 
input ld_neighbor3,
input ld_red,
input ld_green,
input ld_blue,
input ld_row_to_wait,
input ld_in_stream_ready,
input ld_neighbor_offset,
input ld_out_stream_ready,  
input ld_store_row,
input ld_store_pointer,
input ld_r_rescaled_fl_prev,
input ld_r_rescaled_fl_now,
input ld_skip_reg,

// start signal input (internal)
input start_div1,
input start_div2,

// counting signal output  (internal)
output [9:0] c_j_unsigned_o,
output [9:0] r_j_unsigned_o,
output [9:0] c_j_cnt_unsigned_o,
output [9:0] r_j_cnt_unsigned_o,

// done signal output (internal)
output done_div,
output wire out_stream_done_o,

// top-level output
output [8:0] row_to_wait_o,
output in_stream_ready_o,
output [10:0] neighbor_offset_o,
output out_stream_ready_o,
output wire [31:0] out_pixel_data,
output wire skip,

// external output
output DONE,
output error
);

	//////copied from rescale_v1_0_M_OUT_AXIS module//////
	function integer clogb2 (input integer bit_depth);
	  begin
	    for(clogb2=0; bit_depth>0; clogb2=clogb2+1)
	      bit_depth = bit_depth >> 1;
	  end
	endfunction
	
	localparam NUMBER_OF_OUTPUT_WORDS = 76800;
	localparam bit_num  = clogb2(NUMBER_OF_OUTPUT_WORDS-1);
	//////copied from rescale_v1_0_M_OUT_AXIS module//////

// define the  size of original stamp in floating format
wire [15:0] c_i_fp, r_i_fp;
assign c_i_fp = {1'b0, 10'd320, 5'd0}; // c_i = 320;
assign r_i_fp = {1'b0, 10'd240, 5'd0}; // r_i = 240;

// define variable types
wire [15:0] c_j;
wire [15:0] r_j;
wire [15:0] c_j_cnt;
wire [15:0] r_j_cnt;
wire [9:0] r_rescaled_fl;
//wire [9:0] c_rescaled_fl; // for simulation purpose
wire [9:0] r_rescaled_fl_diff;
wire [8:0] local_read_pointer;
wire [15:0] store_row_wire;

reg done;
reg [9:0] c_j_unsigned;
reg [9:0] r_j_unsigned;
reg [15:0] ratio_c;
reg [15:0] ratio_r;
reg [9:0] c_j_cnt_unsigned;
reg [9:0] r_j_cnt_unsigned;
reg [15:0] c_rescaled;
reg [15:0] r_rescaled;
reg [15:0] neighbor0_unpad;
reg [15:0] neighbor1_unpad;
reg [15:0] neighbor2_unpad;
reg [15:0] neighbor3_unpad;
reg [4:0] red;
reg [5:0] green;
reg [4:0] blue;
reg [8:0] row_to_wait;
reg in_stream_ready;
reg [10:0] neighbor_offset;
reg out_stream_ready;
reg [15:0] store_row [319:0]; // storage buffer for a row, each pointer with 32 bits
reg [8:0] store_pointer;
reg skip_reg;
reg [9:0] r_rescaled_fl_prev;
reg [9:0] r_rescaled_fl_now;
reg [8:0] store_interation;
reg out_stream_done;


// initialize store_row
integer i;
initial begin
	for (i = 0; i < 320; i = i + 1) begin
		store_row[i] = 32'b0;
	end
end

// div1 (wires)
wire done_div1;
wire overflow_flag_div1;
wire [15:0] result_div1;

// div2 (wires)
wire done_div2;
wire overflow_flag_div2;
wire [15:0] result_div2;

// add1 (wires)
wire [15:0] one = {1'b0,9'b0,1'b1,5'b0};
wire [15:0] minus_delta_c = {1'b1,10'b0,c_rescaled[4:0]}; // minus delta column
wire [15:0] one_minus_delta_c;  // one minus delta column

// add2 (wires)
wire [15:0] minus_delta_r = {1'b1,10'b0,r_rescaled[4:0]}; // minus delta row
wire [15:0] one_minus_delta_r; // one minus delta row

// mult1 (wires)
wire overflow_flag_mult1;
wire [15:0] result_mult1;

// mult2 (wires)
wire overflow_flag_mult2;
wire [15:0] result_mult2;

// mult3 ~ 6 (wires)
wire [15:0] delta_c = {1'b0,10'b0,c_rescaled[4:0]}; // delta column
wire [15:0] delta_r = {1'b0,10'b0,r_rescaled[4:0]}; // delta row
wire overflow_flag_mult3;
wire [15:0] result_mult3;
wire overflow_flag_mult4;
wire [15:0] result_mult4;
wire overflow_flag_mult5;
wire [15:0] result_mult5;
wire overflow_flag_mult6;
wire [15:0] result_mult6;

// calculate_pixel (wires)
wire [4:0] red_in;
wire [5:0] green_in;
wire [4:0] blue_in;
wire err_r;
wire err_g;
wire err_b;

// fixed-point arithmetic
qdiv #(5,16) divider1( // divider 1 for ratio_c
.i_dividend(c_i_fp),
.i_divisor(c_j),
.i_start(start_div1),
.i_clk(clock),
.o_quotient_out(result_div1),
.o_complete(done_div1),
.o_overflow(overflow_flag_div1)
);

qdiv #(5,16) divider2( // divider 2 for ratio_r
.i_dividend(r_i_fp),
.i_divisor(r_j),
.i_start(start_div2),
.i_clk(clock),
.o_quotient_out(result_div2),
.o_complete(done_div2),
.o_overflow(overflow_flag_div2)
);

qadd #(5,16) adder1( // adder 1 for (1 - delta_c)
.a(one),
.b(minus_delta_c),
.c(one_minus_delta_c)
);

qadd #(5,16) adder2( // adder 2 for (1 - delta_r)
.a(one),
.b(minus_delta_r),
.c(one_minus_delta_r)
);

qmult #(5,16) multiplier1( // multiplier 1 for c_rescaled
.i_multiplicand(c_j_cnt),
.i_multiplier(ratio_c),
.o_result(result_mult1),
.ovr(overflow_flag_mult1)
);

qmult #(5,16) multiplier2( // multiplier 2 for r_rescaled
.i_multiplicand(r_j_cnt),
.i_multiplier(ratio_r),
.o_result(result_mult2),
.ovr(overflow_flag_mult2)
);

qmult #(5,16) multiplier3( // multiplier 3 for (1-delta_r)*(1-delta_c)
.i_multiplicand(one_minus_delta_r),
.i_multiplier(one_minus_delta_c),
.o_result(result_mult3),
.ovr(overflow_flag_mult3)
);

qmult #(5,16) multiplier4( // multiplier 4 for (delta_r)*(1-delta_c)
.i_multiplicand(delta_r),
.i_multiplier(one_minus_delta_c),
.o_result(result_mult4),
.ovr(overflow_flag_mult4)
);

qmult #(5,16) multiplier5( // multiplier 5 for (1-delta_r)*(delta_c)
.i_multiplicand(one_minus_delta_r),
.i_multiplier(delta_c),
.o_result(result_mult5),
.ovr(overflow_flag_mult5)
);

qmult #(5,16) multiplier6( // multiplier 6 for (delta_r)*(delta_c)
.i_multiplicand(delta_r),
.i_multiplier(delta_c),
.o_result(result_mult6),
.ovr(overflow_flag_mult6)
);

// calculate_pixel
calculate_pixel #(5, 11) pixel_red( // calculate red color of the new pixel
.n0(neighbor0_unpad),
.n1(neighbor1_unpad),
.n2(neighbor2_unpad),
.n3(neighbor3_unpad), 
.m3(result_mult3),
.m4(result_mult4),
.m5(result_mult5), 
.m6(result_mult6),
.pixel_color(red_in),
.err(err_r)
);

calculate_pixel #(6, 5) pixel_green( // calculate green color of the new pixel
.n0(neighbor0_unpad), 
.n1(neighbor1_unpad), 
.n2(neighbor2_unpad), 
.n3(neighbor3_unpad), 
.m3(result_mult3), 
.m4(result_mult4), 
.m5(result_mult5), 
.m6(result_mult6), 
.pixel_color(green_in),
.err(err_g)
);

calculate_pixel #(5, 0) pixel_blue( // calculate blue color of the new pixel
.n0(neighbor0_unpad), 
.n1(neighbor1_unpad),
.n2(neighbor2_unpad), 
.n3(neighbor3_unpad), 
.m3(result_mult3),
.m4(result_mult4),
.m5(result_mult5), 
.m6(result_mult6), 
.pixel_color(blue_in),
.err(err_b) 
);

// define registers
always @(posedge clock or posedge reset) begin
    if (reset) begin // asynchronous positive reset
		done <= 1'b1;
		c_j_unsigned <= 10'b0;
		r_j_unsigned <= 10'b0;
		ratio_c <= 16'b0;
		ratio_r <= 16'b0;
		c_j_cnt_unsigned <= 10'b0;
		r_j_cnt_unsigned <= 10'b0;
		c_rescaled <= 16'b0;
		r_rescaled <= 16'b0;
		neighbor0_unpad <= 16'b0;
		neighbor1_unpad <= 16'b0;
		neighbor2_unpad <= 16'b0;
		neighbor3_unpad <= 16'b0;
		red <= 5'b0;
		green <= 6'b0;
		blue <= 5'b0;
		row_to_wait <= 9'b0;
		in_stream_ready <= 1'b0;
		neighbor_offset <= 11'b0;
		store_pointer <= 9'b0;
		r_rescaled_fl_prev <= -10'd4; // initialize r_rescaled_fl_prev to -4
		r_rescaled_fl_now  <= -10'd2; // initialize r_rescaled_fl_now to -2
		skip_reg <= 1'b0;
    end else begin
		if(ld_done) begin // done register 
		  case(sel_done)
			1'b0: done <= 1'b0;
			1'b1: done <= 1'b1;
		  endcase
		end
		if(ld_c_j) begin // c_j register
		  c_j_unsigned <= x_in;  
		end
	    if(ld_r_j) begin // r_j register
		  r_j_unsigned <= y_in; 
		end
		if(ld_ratio_c) begin // ratio_c register
		  ratio_c <= result_div1;
		end
		if(ld_ratio_r) begin // ratio_r register
		  ratio_r <= result_div2;
		end
		if(ld_c_j_cnt) begin //c_j_cnt up-counter with positive reset
		  if(reset_c_j_cnt) begin c_j_cnt_unsigned <= 1'b1; end
		  else begin c_j_cnt_unsigned <= c_j_cnt_unsigned + 1'b1; end
		end
		if(ld_r_j_cnt) begin //r_j_cnt up-counter with positive reset
		  if(reset_r_j_cnt) begin r_j_cnt_unsigned <= 1'b1; end
		  else begin r_j_cnt_unsigned <= r_j_cnt_unsigned + 1'b1; end
		end
		if(ld_c_rescaled) begin //c_rescaled register
		  c_rescaled <= result_mult1;
		end
		if(ld_r_rescaled) begin //r_rescaled register
		  r_rescaled <= result_mult2;
		end
		if(ld_neighbor0) begin // neighbor0_unpad register
		  neighbor0_unpad <= neighbor0;
		end
		if(ld_neighbor1) begin // neighbor1_unpad register
		  neighbor1_unpad <= neighbor1;
		end
		if(ld_neighbor2) begin // neighbor2_unpad register
		  neighbor2_unpad <= neighbor2;
		end
		if(ld_neighbor3) begin // neighbor3_unpad register
		  neighbor3_unpad <= neighbor3;
		end
		if(ld_red) begin // red register
		  red <= red_in;
		end
		if(ld_green) begin // green register
		  green <= green_in;
		end
		if(ld_blue) begin // blue register
		  blue <= blue_in;
		end
		if(ld_row_to_wait) begin // row_to_wait register
			if(skip) row_to_wait <= r_rescaled_fl_diff - 2;  // row position in a stamp
			else row_to_wait <= 9'b0;
		end
		if(ld_in_stream_ready) begin // in_stream_ready register
		  case(sel_in_stream_ready)
		    1'b0: in_stream_ready <= 1'b0;
			1'b1: in_stream_ready <= 1'b1;
		  endcase
		end
		if(ld_neighbor_offset) begin // neighbor_offset register
		  neighbor_offset <= (c_rescaled[14:5] - 1'b1); // pixel position in a row
		end
		if(ld_store_row) begin // store_row registers
		  store_row[store_pointer] <= {red[4:0],green[5:0],blue[4:0]}; // encode padding {R,G,B}
		end
		if(ld_store_pointer) begin // store_pointer up-counter with positive reset
		  if(reset_store_pointer) begin store_pointer <= 1'b0; end
		  else begin store_pointer <= store_pointer + 1'b1; end
		end
		if(ld_r_rescaled_fl_prev) begin // r_rescaled_fl_prev register
		r_rescaled_fl_prev <= r_rescaled_fl_now;
		end
		if(ld_r_rescaled_fl_now) begin // r_rescaled_fl_now register
		r_rescaled_fl_now  <= r_rescaled_fl;
		end
		if(ld_skip_reg) begin // kip_reg register
		skip_reg <= !(r_rescaled_fl_diff == 10'b1);
		end
    end
end


// combination circuits
assign c_j = {1'b0,c_j_unsigned[9:0],5'b0}; // convert c_j_unsigned to fixed-point c_j
assign r_j = {1'b0,r_j_unsigned[9:0],5'b0}; // convert r_j_unsigned to fixed-point r_j
assign c_j_cnt = {1'b0,c_j_cnt_unsigned[9:0],5'b0}; // convert c_j_cnt_unsigned to fixed-point c_j_cnt
assign r_j_cnt = {1'b0,r_j_cnt_unsigned[9:0],5'b0}; // convert r_j_cnt_unsigned to fixed-point r_j_cnt
		// define output
assign c_j_unsigned_o = c_j_unsigned;
assign r_j_unsigned_o = r_j_unsigned;
assign c_j_cnt_unsigned_o = c_j_cnt_unsigned;
assign r_j_cnt_unsigned_o = r_j_cnt_unsigned;
assign DONE = done;
assign error = overflow_flag_div1 & overflow_flag_div2 
			   & overflow_flag_mult1 & overflow_flag_mult2
			   & overflow_flag_mult3 & overflow_flag_mult4
			   & overflow_flag_mult5 & overflow_flag_mult6
			   & err_r & err_g & err_b;	
			   
assign done_div = done_div1 & done_div2;
assign row_to_wait_o = row_to_wait;
assign in_stream_ready_o = in_stream_ready;
assign neighbor_offset_o = neighbor_offset;
assign r_rescaled_fl = r_rescaled[14:5];
//assign c_rescaled_fl = c_rescaled[14:5];  // for simulation purpose
assign r_rescaled_fl_diff = r_rescaled_fl_now - r_rescaled_fl_prev;
assign skip = skip_reg;

// output one row to vdma
// define store_interation, store_start, and out_stream_done
always@(posedge clock) begin
	if(reset) begin
		store_interation <= 9'b0;
		out_stream_ready <= 1'b0;
		out_stream_done <= 1'b0;
	end else begin
		if(ld_out_stream_ready) begin
			out_stream_ready <= 1'b1;
		end
		if(local_read_pointer >= (c_j_unsigned - 2)) begin
			out_stream_ready <= 1'b0;
		end
		if(local_read_pointer >= (c_j_unsigned - 1)) begin
			out_stream_done  <= 1'b1;
			store_interation <= store_interation + 1;
		end
		if(out_stream_done) begin
			out_stream_done <= 1'b0;
		end
	end
end

// define local_read_pointer
assign local_read_pointer =  read_pointer - c_j_unsigned * store_interation;
// define store_row_wire and out_pixel_data
assign store_row_wire = store_row[local_read_pointer];
assign out_pixel_data = {8'b0,store_row_wire[15:11],3'b0,store_row_wire[10:5],2'b0,store_row_wire[4:0],3'b0};
// deefine out_stream_done_o and out_stream_ready_o
assign out_stream_done_o = out_stream_done; // to rescale_controlpath
assign out_stream_ready_o = out_stream_ready; // to M_OUT_AXIS interface


endmodule
 