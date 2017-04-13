`timescale 1ns/100ps

module v7_tb; // rescale 8x8 to 5x5

	/////////////////////////////////////////////
	// Parameters of Axi Slave Bus Interface S_IN_AXIS
	parameter integer C_S_IN_AXIS_TDATA_WIDTH	= 32;

	// Parameters of Axi Master Bus Interface M_OUT_AXIS
	parameter integer C_M_OUT_AXIS_TDATA_WIDTH	= 32;
	parameter integer C_M_OUT_AXIS_START_COUNT	= 32;
	integer i;
	
	// auxiliary signals
	reg [6:0] in_data_count = 0;
	reg [6:0] out_data_count = 0;
	
	// general input
	reg clock;
	reg RESETN;
	reg GO;
	reg [9:0] X_IN;
	reg [9:0] Y_IN;
	wire DONE;
	wire ERROR;
	
	// Ports of Axi Slave Bus Interface S_IN_AXIS
	wire  s_in_axis_tready;
	wire [C_S_IN_AXIS_TDATA_WIDTH-1 : 0] s_in_axis_tdata;
	reg [(C_S_IN_AXIS_TDATA_WIDTH/8)-1 : 0] s_in_axis_tstrb = 0;
	reg s_in_axis_tlast;
	wire  s_in_axis_tvalid;

	// Ports of Axi Master Bus Interface M_OUT_AXIS
	wire  m_out_axis_tvalid;
	wire [C_M_OUT_AXIS_TDATA_WIDTH-1 : 0] m_out_axis_tdata;
	wire [(C_M_OUT_AXIS_TDATA_WIDTH/8)-1 : 0] m_out_axis_tstrb ;
	wire  m_out_axis_tlast;
	reg  m_out_axis_tready;
	
	// for debug
	wire [4:0] C_STATE;
	// wires between rescale_inst and buffer_in
	wire skip;
	wire [8:0] row_to_wait;
	wire in_stream_ready;
	wire buffer_done;
	wire [10:0] neighbor_offset;
	wire [15:0] neighbor0;
	wire [15:0] neighbor1;
	wire [15:0] neighbor2;
	wire [15:0] neighbor3;
	// wires between S_IN_AXIS and rescale_inst, also buffer_in
	wire BUFFER_START_DELAY_O;
	// wires between M_OUT_AXIS and rescale_inst
	wire M_AXIS_S2MM_TUSER;
	wire out_stream_ready;
	wire [12:0] read_pointer;
	wire [31:0] out_pixel_data;
	/////////////////////////////////////////////
	
	// original stamp input
	reg [31:0] in_memory [63:0];
	initial begin
		for (i=0; i < 64; i = i + 1)
			in_memory[i] = 31'hFFFFFFFF;
	end
	// storage for rescaled stamp
	reg [31:0] out_memory [63:0];
	initial begin
		for (i=0; i < 64; i = i + 1)
			out_memory[i] = 32'b0;
	end
	
	
	// fake VDMA M_AXIS interface (output)
	// define s_in_axis_tvalid = 1 
	assign s_in_axis_tvalid = 1'b1; // VDMA master is always ready

	// define in_data_count and s_in_axis_tlast
	always@(posedge clock) begin
		if(in_data_count==7|in_data_count==15|in_data_count==23|in_data_count==31|
			in_data_count==39|in_data_count==47|in_data_count==55|in_data_count==63) begin
			s_in_axis_tlast <= 1'b1; // a row has 8 pixels, each 32 bits
		end else begin
			s_in_axis_tlast <= 1'b0;
		end
		
		if(in_data_count==63) begin
			in_data_count <= 0;
		end else if(s_in_axis_tvalid) begin
			in_data_count <= in_data_count + 1;
		end
	end
	// define s_in_axis_tdata
	assign s_in_axis_tdata = in_memory[in_data_count];
	
	
	// fake VDMA S_AXIS interface (input)
	// define m_out_axis_tready
	always@ (*) begin
		if (GO) begin
			assign m_out_axis_tready = 1;
		end
	end
	// define out_memory
	always@ (posedge clock) begin
		if(out_data_count==63) begin
			out_data_count <= 0;
		end else if(m_out_axis_tvalid) begin
			out_memory[out_data_count] <= m_out_axis_tdata;
			out_data_count <= out_data_count + 1;
		end
	end
	
	/////////////////////////////////////////////
	// Instantiation of Axi Bus Interface S_IN_AXIS
	rescale_v2_0_S_IN_AXIS # ( 
		.C_S_AXIS_TDATA_WIDTH(C_S_IN_AXIS_TDATA_WIDTH)
	) rescale_v2_0_S_IN_AXIS_inst (
		// user added ports start
		.in_stream_ready(in_stream_ready),
		.BUFFER_START_DELAY_O(BUFFER_START_DELAY_O),
		// user added ports end
		.S_AXIS_ACLK(clock),
		.S_AXIS_ARESETN(RESETN),
		.S_AXIS_TREADY(s_in_axis_tready), // output
		.S_AXIS_TDATA(s_in_axis_tdata), // input
		.S_AXIS_TSTRB(s_in_axis_tstrb),
		.S_AXIS_TLAST(s_in_axis_tlast), // input
		.S_AXIS_TVALID(s_in_axis_tvalid) // input
	);

	// Instantiation of Axi Bus Interface M_OUT_AXIS
	rescale_v2_0_M_OUT_AXIS # (
		.C_M_AXIS_TDATA_WIDTH(C_M_OUT_AXIS_TDATA_WIDTH),
		.C_M_START_COUNT(C_M_OUT_AXIS_START_COUNT)
	) rescale_v2_0_M_OUT_AXIS_inst (	
		// user added ports start
		.M_AXIS_S2MM_TUSER(M_AXIS_S2MM_TUSER),
		.out_stream_ready(out_stream_ready),
		.out_stream_done(out_stream_done),		
		.read_pointer(read_pointer),
		.out_pixel_data(out_pixel_data),
		// user added ports end
		.M_AXIS_ACLK(clock),
		.M_AXIS_ARESETN(RESETN),
		.M_AXIS_TVALID(m_out_axis_tvalid), //output
		.M_AXIS_TDATA(m_out_axis_tdata), // output
		.M_AXIS_TSTRB(m_out_axis_tstrb),  
		.M_AXIS_TLAST(m_out_axis_tlast), // output
		.M_AXIS_TREADY(m_out_axis_tready) // input
	);
	
	// Instantiation of rescale
	rescale rescale_inst(
	// for debug
	.C_STATE(C_STATE),
	// global ports
	.CLOCK(clock),
	// from S_AXI ports (external)
	.RESETN(RESETN),
	.GO(GO),
	.X_IN(X_IN), // resacle new x size 10'bits
	.Y_IN(Y_IN), // resacle new y size 10'bits
	.DONE(DONE),
	.ERROR(ERROR),
	// to buffer_in (internal)
	.skip(skip),
	.row_to_wait(row_to_wait),
	.in_stream_ready(in_stream_ready), // also to S_IN_AXIS ports
	.buffer_done(buffer_done),
	.neighbor_offset(neighbor_offset),
	.neighbor0(neighbor0),
	.neighbor1(neighbor1),
	.neighbor2(neighbor2),
	.neighbor3(neighbor3),
	// to M_OUT_AXIS ports (internal)	
	.out_stream_ready(out_stream_ready),
	.out_stream_done(out_stream_done),	
	.read_pointer(read_pointer),
	.out_pixel_data(out_pixel_data)
	);
	
	// Instantiation of buffer_in
	buffer_in buffer_inst(
	// global ports
	.clock(clock),
	.resetn(RESETN),
	// from interface (external)
	.S_AXIS_TDATA(s_in_axis_tdata), // stream_in_data from slave
	.S_AXIS_TLAST(s_in_axis_tlast), // eor from slave_AXIS
	.S_AXIS_TVALID(s_in_axis_tvalid), // valid trans (32'b) from master_AXIS
	.BUFFER_START_DELAY_O(BUFFER_START_DELAY_O),
	// to rescale (internal)
	.skip(skip),
	.row_to_wait(row_to_wait),
	.in_stream_ready(in_stream_ready),
	.buffer_done_o(buffer_done),
	.neighbor_offset(neighbor_offset),
	.neighbor0(neighbor0),
	.neighbor1(neighbor1),
	.neighbor2(neighbor2),
	.neighbor3(neighbor3)
	);
	/////////////////////////////////////////////
	
	
	// simulation
	initial begin
	// intialziation
		clock = 0;
		RESETN = 0;
		GO = 0;
		X_IN = 10'd5;
		Y_IN = 10'd5;
		#5
		RESETN = 1;
	// start rescale
		#10; 
		GO = 1; 
	end

	// generate clock
	always #1 clock = !clock;
	
endmodule