module rescale(
// for debug
output wire [4:0] C_STATE,

// global ports
input CLOCK,
// to S_AXI ports
input RESETN,
input GO,
input [9:0] X_IN, // resacle new x size
input [9:0] Y_IN, // resacle new y size
output DONE,
output ERROR,
// to S_IN_AXIS ports (internal)
output skip,
output wire [8:0] row_to_wait,
output in_stream_ready,
input buffer_done,
output [10:0] neighbor_offset,
input [15:0] neighbor0,
input [15:0] neighbor1,
input [15:0] neighbor2,
input [15:0] neighbor3,
// to M_OUT_AXIS ports	 (internal)	
output out_stream_ready,
output wire out_stream_done,                                            
input [bit_num-1:0] read_pointer,
output [31:0] out_pixel_data
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

// connecting wires
wire reset, reset_c_j_cnt, reset_r_j_cnt, reset_store_pointer,
sel_done, sel_in_stream_ready, //sel_out_stream_ready,
ld_done, ld_c_j, ld_r_j, ld_ratio_c, ld_ratio_r,
ld_c_j_cnt, ld_r_j_cnt, ld_c_rescaled, ld_r_rescaled,
ld_neighbor0, ld_neighbor1, ld_neighbor2, ld_neighbor3,
ld_red, ld_green, ld_blue, ld_row_to_wait,
ld_in_stream_ready, ld_neighbor_offset,
ld_out_stream_ready, ld_store_row,
ld_store_pointer, start_div1, start_div2, done_div,
ld_r_rescaled_fl_prev, ld_r_rescaled_fl_now, ld_skip_reg;

wire [9:0] c_j_unsigned_o, r_j_unsigned_o,
c_j_cnt_unsigned_o, r_j_cnt_unsigned_o; 

////////////////////////////////////////////////////////////////

rescale_datapath rescale_dp(
// gloabal clock
.clock(CLOCK),
// external input
.x_in(X_IN),
.y_in(Y_IN),
// top-level input
.neighbor0(neighbor0),
.neighbor1(neighbor1),
.neighbor2(neighbor2),
.neighbor3(neighbor3),
.read_pointer(read_pointer),
// reset input (internal)
.reset(reset),
.reset_c_j_cnt(reset_c_j_cnt),
.reset_r_j_cnt(reset_r_j_cnt),
.reset_store_pointer(reset_store_pointer),
// select input (internal)
.sel_done(sel_done),
.sel_in_stream_ready(sel_in_stream_ready),
// load input (internal)
.ld_done(ld_done),
.ld_c_j(ld_c_j),
.ld_r_j(ld_r_j),
.ld_ratio_c(ld_ratio_c),
.ld_ratio_r(ld_ratio_r),
.ld_c_j_cnt(ld_c_j_cnt),
.ld_r_j_cnt(ld_r_j_cnt),
.ld_c_rescaled(ld_c_rescaled),
.ld_r_rescaled(ld_r_rescaled),
.ld_neighbor0(ld_neighbor0), 
.ld_neighbor1(ld_neighbor1), 
.ld_neighbor2(ld_neighbor2), 
.ld_neighbor3(ld_neighbor3),
.ld_red(ld_red),
.ld_green(ld_green),
.ld_blue(ld_blue),
.ld_row_to_wait(ld_row_to_wait),
.ld_in_stream_ready(ld_in_stream_ready),
.ld_neighbor_offset(ld_neighbor_offset),
.ld_out_stream_ready(ld_out_stream_ready),  
.ld_store_row(ld_store_row),
.ld_store_pointer(ld_store_pointer),
.ld_r_rescaled_fl_prev(ld_r_rescaled_fl_prev),
.ld_r_rescaled_fl_now(ld_r_rescaled_fl_now),
// start signal input (internal)
.start_div1(start_div1),
.start_div2(start_div2),
// counting signal output  (internal)
.c_j_unsigned_o(c_j_unsigned_o),
.r_j_unsigned_o(r_j_unsigned_o),
.c_j_cnt_unsigned_o(c_j_cnt_unsigned_o),
.r_j_cnt_unsigned_o(r_j_cnt_unsigned_o),
.ld_skip_reg(ld_skip_reg),
// done signal output (internal)
.done_div(done_div),
.out_stream_done_o(out_stream_done),
// top-level output
.row_to_wait_o(row_to_wait),
.in_stream_ready_o(in_stream_ready),
.neighbor_offset_o(neighbor_offset),
.out_stream_ready_o(out_stream_ready),
.out_pixel_data(out_pixel_data),
.skip(skip),
// external output
.DONE(DONE),
.error(ERROR)
);

////////////////////////////////////////////////////////////////

rescale_controlpath rescale_cp(
// for debug
.C_STATE(C_STATE),

// gloabal clock
.clock(CLOCK),
// external input
.RESETN(RESETN), // positive top-level reset
.GO(GO), // starts the algorithm
// top-level input
.buffer_done(buffer_done),
// counting signal input (internal)
.c_j_unsigned_o(c_j_unsigned_o),
.r_j_unsigned_o(r_j_unsigned_o),
.c_j_cnt_unsigned_o(c_j_cnt_unsigned_o),
.r_j_cnt_unsigned_o(r_j_cnt_unsigned_o),
// done signal input (internal)
.done_div(done_div),
.out_stream_done(out_stream_done),
// reset output (internal)
.reset(reset),
.reset_c_j_cnt(reset_c_j_cnt),
.reset_r_j_cnt(reset_r_j_cnt),
.reset_store_pointer(reset_store_pointer),
// select output (internal)
.sel_done(sel_done),
.sel_in_stream_ready(sel_in_stream_ready),
// load output (internal)
.ld_done(ld_done),
.ld_c_j(ld_c_j),
.ld_r_j(ld_r_j),
.ld_ratio_c(ld_ratio_c),
.ld_ratio_r(ld_ratio_r),
.ld_c_j_cnt(ld_c_j_cnt),
.ld_r_j_cnt(ld_r_j_cnt),
.ld_c_rescaled(ld_c_rescaled),
.ld_r_rescaled(ld_r_rescaled),
.ld_neighbor0(ld_neighbor0),
.ld_neighbor1(ld_neighbor1),
.ld_neighbor2(ld_neighbor2),
.ld_neighbor3(ld_neighbor3),
.ld_red(ld_red),
.ld_green(ld_green),
.ld_blue(ld_blue),
.ld_row_to_wait(ld_row_to_wait),
.ld_in_stream_ready(ld_in_stream_ready),
.ld_neighbor_offset(ld_neighbor_offset),
.ld_out_stream_ready(ld_out_stream_ready),  
.ld_store_row(ld_store_row),
.ld_store_pointer(ld_store_pointer),
.ld_r_rescaled_fl_prev(ld_r_rescaled_fl_prev),
.ld_r_rescaled_fl_now(ld_r_rescaled_fl_now),
.ld_skip_reg(ld_skip_reg),
// start signal output (internal)
.start_div1(start_div1),
.start_div2(start_div2)
);

endmodule
