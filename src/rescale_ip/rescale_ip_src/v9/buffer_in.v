module buffer_in(
	// general input
	input wire clock,
	input resetn,
	// external signals from interface
	input [31:0] S_AXIS_TDATA, // stream_in_data
	input S_AXIS_TLAST, // end of a row
	input S_AXIS_TVALID, // valid 32-bit data tranfer
	output wire BUFFER_START_DELAY_O,
	// internal signals to rescale
	input skip,
	input [8:0] row_to_wait,
	input in_stream_ready,
	output wire buffer_done_o,
	input [10:0] neighbor_offset,
	output reg [15:0] neighbor0,
	output reg [15:0] neighbor1,
	output reg [15:0] neighbor2,
	output reg [15:0] neighbor3
);

	// define parameters
	integer i;
	localparam NUMBER_OF_INPUT_WORDS = 640; // two row of pixels
	localparam NO_SKIP_NUMBER_OF_INPUT_WORDS = 320; // one row of pixels

	//define wires
	wire buffer_start_delay_rising1;
	wire buffer_start_delay_rising2;
	wire no_skip_cnt_is_odd;

	//define regs
	reg [9:0] buffer_pointer = 10'b0;
	reg [9:0] skip_row_count = 10'b0;
	reg [9:0] no_skip_cnt = 10'b0;
	reg buffer_start = 1'b0;
	reg buffer_done = 1'b0;
	////////////////////
	reg buffer_start_delay1 = 1'b0;
	reg buffer_start_delay2 = 1'b0;
	reg buffer_start_delay_o = 1'b0;
	reg buffer_done_reset_delay = 1'b0;
	reg skip_smooth = 1'b0;
    ////////////////////
    
    assign BUFFER_START_DELAY_O = !buffer_start & (buffer_start_delay_o | skip_smooth);
    
    // define skip_smooth
    always@ (posedge clock) begin
        if(row_to_wait == 9'b0) begin
            skip_smooth <= 1'b1;
        end else begin
            skip_smooth <= 1'b0;
        end
    end
	
	// define buffer
	reg [15:0] buffer [NUMBER_OF_INPUT_WORDS-1:0]; // two rows of pixels (320x2=640) each with 32 bits
	
	rising_edge_detector rise_dect_inst1(
		.clock(clock),
		.signal_in(buffer_start_delay1),
		.rise(buffer_start_delay_rising1)
	);
	
	rising_edge_detector rise_dect_inst2(
		.clock(clock),
		.signal_in(buffer_start_delay2),
		.rise(buffer_start_delay_rising2)
	);

// comb logics
	assign no_skip_cnt_is_odd = no_skip_cnt[0];
	assign buffer_done_o = buffer_done;

// define buffer_done and buffer_pointer
	always@(posedge clock) begin
		buffer_done <= 1'b0;
		if(skip) begin // skip row (<r2>,<r3>)
			if(!resetn | buffer_start_delay_rising2) begin
				buffer_pointer <= 10'b0;
				buffer_done <= 1'b0;
			end else if (buffer_pointer <= NUMBER_OF_INPUT_WORDS-1 & S_AXIS_TVALID) begin
				if(buffer_start) begin
					buffer_pointer <= buffer_pointer + 1'b1;
					buffer_done <= 1'b0;
				end
				if(buffer_pointer == NUMBER_OF_INPUT_WORDS-2) begin
	              buffer_done <= 1'b1;
	            end	
			end
		end else begin // no skip
			if(no_skip_cnt_is_odd) begin // no_skip_cnt is odd (<r4>, r3)
				if(!resetn | buffer_start_delay_rising2) begin
					buffer_pointer <= 10'b0;
					buffer_done <= 1'b0;
				end else if(buffer_pointer <= NO_SKIP_NUMBER_OF_INPUT_WORDS-1 & S_AXIS_TVALID) begin
					if (buffer_start) begin
						buffer_pointer <= buffer_pointer + 1'b1;
						buffer_done <= 1'b0;
					end
					if (buffer_pointer == NO_SKIP_NUMBER_OF_INPUT_WORDS-2) begin
						buffer_done <= 1'b1;
					end	
				end
			end else begin	// no_skip_cnt is even (r4, <r5>)
				if(!resetn | buffer_start_delay_rising2) begin 
					buffer_pointer <= NO_SKIP_NUMBER_OF_INPUT_WORDS;
					buffer_done <= 1'b0;
				end else if(buffer_pointer <= NUMBER_OF_INPUT_WORDS-1 & S_AXIS_TVALID) begin
					if(buffer_start) begin
						buffer_pointer <= buffer_pointer + 1'b1;
						buffer_done <= 1'b0;
					end
					if(buffer_pointer == NUMBER_OF_INPUT_WORDS-2) begin
						buffer_done <= 1'b1;
					end	
				end
			end
		end		
	end
	
    //define buffer_done_reset_delay
    always@ (posedge clock) begin
        if(buffer_done) begin
            buffer_done_reset_delay <= 1'b1;
        end else if(buffer_done_reset_delay) begin
            buffer_done_reset_delay <= 1'b0;
        end
    end

	
	// define buffer_start, buffer_start_delay, skip_row_count, and no_skip_cnt
	always@ (posedge clock) begin
		if(skip) begin // skip row
			// define skip_row_count
			if(buffer_done) begin
				skip_row_count <= 10'b0; // reset skip_row_count when buffer done
			end else if(S_AXIS_TLAST & in_stream_ready) begin
				skip_row_count <= skip_row_count + 1'b1;
			end
			
			// define buffer_start for skip
			if(buffer_done) begin
				buffer_start <= 1'b0;
				buffer_start_delay1 <= 1'b0;
				buffer_start_delay2 <= 1'b0;
				buffer_start_delay_o <= 1'b0;
			end else if((skip_row_count >= row_to_wait) & in_stream_ready & !buffer_done_reset_delay)begin
				buffer_start_delay1 <= 1'b1;
				buffer_start_delay_o <= 1'b1;
				// define buffer_start_delay2 for no skip
				if(buffer_start_delay1) begin
					buffer_start_delay2 <= 1'b1;
					// define buffer_start for no skip
					if(buffer_start_delay2) begin
					buffer_start <= 1'b1;
					end
				end
			end
			
			// update no_skip_cnt for skip
			if(buffer_start_delay_rising1) begin
				no_skip_cnt <= 10'b0;
			end
			
		end else begin // no skip row
			// define buffer_start for no skip
			if(buffer_done) begin
				buffer_start <= 1'b0;
				buffer_start_delay1 <= 1'b0;
				buffer_start_delay2 <= 1'b0;
				buffer_start_delay_o <= 1'b0;
			end else if(in_stream_ready & !buffer_done_reset_delay) begin
				buffer_start_delay1 <= 1'b1;
				buffer_start_delay_o <= 1'b1;
				// define buffer_start_delay2 for no skip
				if(buffer_start_delay1) begin
					buffer_start_delay2 <= 1'b1;
					// define buffer_start for no skip
					if(buffer_start_delay2) begin
						buffer_start <= 1'b1;
					end
				end
			end
			// update no_skip_cnt for no skip
			if(buffer_start_delay_rising1) begin
				no_skip_cnt <= no_skip_cnt + 10'b1;
			end
		end	
	end
	
	// load buffer
	always@(posedge clock) begin
		if(!resetn) begin
			for (i = 0; i < NUMBER_OF_INPUT_WORDS; i = i + 1) begin
				buffer[i] = 16'b0;
			end
		end else if(buffer_start) begin
			buffer[buffer_pointer] <= {S_AXIS_TDATA[23:19],S_AXIS_TDATA[15:10],S_AXIS_TDATA[7:3]};
		end
	end
	
	// define four neighbor pixels from neighbor_offset
	always@ (*) begin
		if(skip | !no_skip_cnt_is_odd) begin // skip, or no skip but no_skip_cnt is even
			neighbor0 = buffer[neighbor_offset];
			neighbor1 = buffer[neighbor_offset+1];
			neighbor2 = buffer[neighbor_offset+NO_SKIP_NUMBER_OF_INPUT_WORDS];
			neighbor3 = buffer[neighbor_offset+NO_SKIP_NUMBER_OF_INPUT_WORDS+1];
		end else begin // no skip and no_skip_cnt is odd
			neighbor2 = buffer[neighbor_offset];
			neighbor3 = buffer[neighbor_offset+1];
			neighbor0 = buffer[neighbor_offset+NO_SKIP_NUMBER_OF_INPUT_WORDS];
			neighbor1 = buffer[neighbor_offset+NO_SKIP_NUMBER_OF_INPUT_WORDS +1];
		end
	end
	
	endmodule
	




