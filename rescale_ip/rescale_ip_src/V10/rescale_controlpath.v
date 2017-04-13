module rescale_controlpath(
// for debug
output wire [4:0] C_STATE,

// gloabal clock
input clock,

// external input
input RESETN, // negative top-level reset
input GO, // starts the algorithm

// top-level input
input buffer_done,

// counting signal input (internal)
input [9:0] c_j_unsigned_o,
input [9:0] r_j_unsigned_o,
input [9:0] c_j_cnt_unsigned_o,
input [9:0] r_j_cnt_unsigned_o,

// done signal input (internal)
input done_div,
input store_pixel_done,

// reset output (internal)
output reg reset,
output reg reset_c_j_cnt,
output reg reset_r_j_cnt,

// select output (internal)
output reg sel_done,
output reg sel_in_stream_ready,
//output reg sel_out_stream_ready,

// load output (internal)
output reg ld_done,
output reg ld_c_j,
output reg ld_r_j,
output reg ld_ratio_c,
output reg ld_ratio_r,
output reg ld_c_j_cnt,
output reg ld_r_j_cnt,
output reg ld_c_rescaled,
output reg ld_r_rescaled,
output reg ld_neighbor0,
output reg ld_neighbor1,
output reg ld_neighbor2,
output reg ld_neighbor3,
output reg ld_red,
output reg ld_green,
output reg ld_blue,
output reg ld_row_to_wait,
output reg ld_in_stream_ready,
output reg ld_neighbor_offset,
output reg ld_out_stream_ready,  
output reg ld_store_pixel,
output reg ld_r_rescaled_fl_prev,
output reg ld_r_rescaled_fl_now,
output reg ld_skip_reg,

// start signal output (internal)
output reg start_div1,
output reg start_div2
);

// current state, next state
reg [4:0] c_state, n_state; 
// for debug
assign C_STATE = c_state;

// define state vairables
parameter Reset = 5'd0, Load_J = 5'd1, Start = 5'd2, 
Wait_Div = 5'd3, Load_Ratio = 5'd4, Rescale_Row_J = 5'd5, 
Update_Re_Row_J_PrevNow = 5'd6, Updata_Skip = 5'd7,
Load_Buffer_Wait = 5'd8, Start_Buffer = 5'd9, Rescale_Column_J = 5'd10,
Load_Neighbor_Offset = 5'd11, Get_Neighbor = 5'd12, Calculate_Pixel = 5'd13,
Store_Pixel = 5'd14, Out_Stream_Ready = 5'd15, Wait_Store_Pixel = 5'd16,
Next_J_Column = 5'd17, Next_J_Row = 5'd18, Done = 5'd19,
Dummy0 = 5'd20, Dummy1 = 5'd21, Dummy2 = 5'd22;

//next state combinational circuit
always @(*) begin
  case(c_state)
	Reset: 				if(GO) n_state = Load_J;
						else n_state = Reset;
						
	Load_J:				n_state = Start;
	
	Start: 				n_state = Wait_Div;
	
	Wait_Div:			if(done_div) n_state = Load_Ratio;
						else n_state = Wait_Div;
						
	Load_Ratio:			n_state = Rescale_Row_J;			
	
	Rescale_Row_J: 		n_state = Update_Re_Row_J_PrevNow;
	
Update_Re_Row_J_PrevNow: n_state = Updata_Skip;
	
	Updata_Skip:			n_state = Load_Buffer_Wait;
	
	Load_Buffer_Wait:	n_state = Start_Buffer;
	
	Start_Buffer:	    if(buffer_done) n_state = Rescale_Column_J;
						else n_state = Start_Buffer;
	
	Rescale_Column_J:   n_state = Load_Neighbor_Offset;
	
  Load_Neighbor_Offset: n_state = Dummy0;
  
	Dummy0:				n_state = Get_Neighbor;
	
	Get_Neighbor:		n_state = Dummy1;
	
	Dummy1:				n_state = Calculate_Pixel;
	
	Calculate_Pixel: 	n_state = Dummy2;
	
	Dummy2:				n_state = Store_Pixel;
	
	Store_Pixel:		n_state = Out_Stream_Ready;
	
	Out_Stream_Ready:	n_state = Wait_Store_Pixel;
	
	Wait_Store_Pixel: 	if(!store_pixel_done) 
						  n_state = Wait_Store_Pixel;
						else if(c_j_cnt_unsigned_o < c_j_unsigned_o)
						  n_state = Next_J_Column;
						else if(r_j_cnt_unsigned_o < r_j_unsigned_o)
						  n_state = Next_J_Row;
						else 
						  n_state = Done;
						  
	Next_J_Column:	  	n_state = Rescale_Column_J;
	
	Next_J_Row:		 	n_state = Rescale_Row_J;
	
	Done:				if(GO) n_state = Done;
						else n_state = Reset;
						 				  
	default: n_state = 5'bx;
  endcase
end

// state transitions
always @(posedge clock or negedge RESETN) begin
  if(!RESETN) c_state <= Reset; // top-level input asynchronous negative reset
  else c_state <= n_state;
end

// state output
always @(*) begin
// set default values
// reset output (internal)
reset = 1'b0;
reset_c_j_cnt = 1'b0;
reset_r_j_cnt = 1'b0;
// select output (internal)
sel_done = 1'b0;
sel_in_stream_ready = 1'b0;
//sel_out_stream_ready = 1'b0;
// load output (internal)
ld_done = 1'b0;
ld_c_j = 1'b0;
ld_r_j = 1'b0;
ld_ratio_c = 1'b0;
ld_ratio_r = 1'b0;
ld_c_j_cnt = 1'b0;
ld_r_j_cnt = 1'b0;
ld_c_rescaled = 1'b0;
ld_r_rescaled = 1'b0;
ld_neighbor0 = 1'b0;
ld_neighbor1 = 1'b0;
ld_neighbor2 = 1'b0;
ld_neighbor3 = 1'b0;
ld_red = 1'b0;
ld_green = 1'b0;
ld_blue = 1'b0;
ld_row_to_wait = 1'b0;
ld_in_stream_ready = 1'b0;
ld_neighbor_offset = 1'b0;
ld_out_stream_ready = 1'b0;  
ld_store_pixel = 1'b0;
ld_r_rescaled_fl_prev = 1'b0;
ld_r_rescaled_fl_now = 1'b0;
ld_skip_reg = 1'b0;
// start signal output (internal)
start_div1 = 1'b0;
start_div2 = 1'b0;
  
  case(c_state)
    Reset: 				begin
						reset = 1; // pass to datapath with asynchronous positive reset
						ld_done = 1'b1; sel_done = 1'b1;
						end
	Load_J:             begin
						ld_c_j = 1'b1;
						ld_r_j = 1'b1;
						end
	Start: 				begin
						ld_done = 1'b1; sel_done = 1'b0;
						start_div1 = 1'b1; 
						start_div2 = 1'b1;
						ld_c_j_cnt = 1'b1; reset_c_j_cnt = 1'b1;
						ld_r_j_cnt = 1'b1; reset_r_j_cnt = 1'b1;
						end
	Wait_Div:			;
	Load_Ratio:			begin
						ld_ratio_c = 1'b1; 
						ld_ratio_r = 1'b1;
						end
	Rescale_Row_J: 		begin 
						ld_r_rescaled = 1'b1; 
						end
Update_Re_Row_J_PrevNow: begin 
						ld_r_rescaled_fl_prev = 1'b1;
						ld_r_rescaled_fl_now = 1'b1;
						end	
	Updata_Skip:		begin
						ld_skip_reg = 1'b1;
						end
	Load_Buffer_Wait:	begin
						ld_row_to_wait = 1'b1;
						end
	Start_Buffer:		begin
						ld_in_stream_ready = 1'b1; sel_in_stream_ready = 1'b1;
						end
	Rescale_Column_J: 	begin
						ld_c_rescaled = 1'b1;
						ld_in_stream_ready = 1'b1; sel_in_stream_ready = 1'b0;
						end
  Load_Neighbor_Offset: begin
						ld_neighbor_offset = 1'b1;
						end
	Dummy0:				;
	Get_Neighbor:		begin
						ld_neighbor0 = 1'b1;
						ld_neighbor1 = 1'b1;
						ld_neighbor2 = 1'b1;
						ld_neighbor3 = 1'b1;
						end
	Dummy1:				;
	Calculate_Pixel:	begin
						ld_red = 1'b1;
						ld_green = 1'b1;
						ld_blue = 1'b1;
						end
	Dummy2:				;
	Store_Pixel:		begin 
						ld_store_pixel = 1'b1;
						end	
	Out_Stream_Ready:  	begin
						ld_out_stream_ready = 1'b1;
						end
	Wait_Store_Pixel:	;
	Next_J_Column:		begin 
						ld_c_j_cnt = 1'b1; 
						end
	Next_J_Row:			begin 
						ld_r_j_cnt = 1'b1; 
						ld_c_j_cnt = 1'b1; reset_c_j_cnt = 1'b1;
						end
    Done:               begin
                        ld_done = 1'b1; sel_done = 1'b1;
                        end
    endcase
  end
  
endmodule