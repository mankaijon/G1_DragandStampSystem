
`timescale 1 ns / 1 ps

	module rescale_v2_0 #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface S_IN_AXIS
		parameter integer C_S_IN_AXIS_TDATA_WIDTH	= 32,

		// Parameters of Axi Master Bus Interface M_OUT_AXIS
		parameter integer C_M_OUT_AXIS_TDATA_WIDTH	= 32,
		parameter integer C_M_OUT_AXIS_START_COUNT	= 32,

		// Parameters of Axi Slave Bus Interface S_AXI
		parameter integer C_S_AXI_DATA_WIDTH	= 32,
		parameter integer C_S_AXI_ADDR_WIDTH	= 5
	)
	(
		// Users to add ports here
		
		input wire CLOCK,
		
		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface S_IN_AXIS
		input wire  s_in_axis_aclk,
		input wire  s_in_axis_aresetn,
		output wire  s_in_axis_tready,
		input wire [C_S_IN_AXIS_TDATA_WIDTH-1 : 0] s_in_axis_tdata,
		input wire [(C_S_IN_AXIS_TDATA_WIDTH/8)-1 : 0] s_in_axis_tstrb,
		input wire  s_in_axis_tlast,
		input wire  s_in_axis_tvalid,

		// Ports of Axi Master Bus Interface M_OUT_AXIS
		input wire  m_out_axis_aclk,
		input wire  m_out_axis_aresetn,
		output wire  m_out_axis_tvalid,
		output wire [C_M_OUT_AXIS_TDATA_WIDTH-1 : 0] m_out_axis_tdata,
		output wire [(C_M_OUT_AXIS_TDATA_WIDTH/8)-1 : 0] m_out_axis_tstrb,
		output wire  m_out_axis_tlast,
		input wire  m_out_axis_tready,

		// Ports of Axi Slave Bus Interface S_AXI
		input wire  s_axi_aclk,
		input wire  s_axi_aresetn,
		input wire [C_S_AXI_ADDR_WIDTH-1 : 0] s_axi_awaddr,
		input wire [2 : 0] s_axi_awprot,
		input wire  s_axi_awvalid,
		output wire  s_axi_awready,
		input wire [C_S_AXI_DATA_WIDTH-1 : 0] s_axi_wdata,
		input wire [(C_S_AXI_DATA_WIDTH/8)-1 : 0] s_axi_wstrb,
		input wire  s_axi_wvalid,
		output wire  s_axi_wready,
		output wire [1 : 0] s_axi_bresp,
		output wire  s_axi_bvalid,
		input wire  s_axi_bready,
		input wire [C_S_AXI_ADDR_WIDTH-1 : 0] s_axi_araddr,
		input wire [2 : 0] s_axi_arprot,
		input wire  s_axi_arvalid,
		output wire  s_axi_arready,
		output wire [C_S_AXI_DATA_WIDTH-1 : 0] s_axi_rdata,
		output wire [1 : 0] s_axi_rresp,
		output wire  s_axi_rvalid,
		input wire  s_axi_rready
	);
	
	//user add  wires start
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
		wire BUFFER_START;
		// wires between M_OUT_AXIS and rescale_inst
		wire out_stream_ready;
		wire [bit_num-1:0] read_pointer;
		wire [31:0] out_pixel_data;
		// wires between S_AXI and rescale_inst
		wire RESETN;
		wire GO;
		wire [9:0] X_IN;
		wire [9:0] Y_IN;
		wire DONE;
		wire ERROR;
	//user add wires start
	
// Instantiation of Axi Bus Interface S_IN_AXIS
	rescale_v2_0_S_IN_AXIS # ( 
		.C_S_AXIS_TDATA_WIDTH(C_S_IN_AXIS_TDATA_WIDTH)
	) rescale_v2_0_S_IN_AXIS_inst (
		// user added ports start
		.BUFFER_START(BUFFER_START),
		// user added ports end
		.S_AXIS_ACLK(s_in_axis_aclk),
		.S_AXIS_ARESETN(s_in_axis_aresetn),
		.S_AXIS_TREADY(s_in_axis_tready),
		.S_AXIS_TDATA(s_in_axis_tdata),
		.S_AXIS_TSTRB(s_in_axis_tstrb),
		.S_AXIS_TLAST(s_in_axis_tlast),
		.S_AXIS_TVALID(s_in_axis_tvalid)
	);

// Instantiation of Axi Bus Interface M_OUT_AXIS
	rescale_v2_0_M_OUT_AXIS # (
		.C_M_AXIS_TDATA_WIDTH(C_M_OUT_AXIS_TDATA_WIDTH),
		.C_M_START_COUNT(C_M_OUT_AXIS_START_COUNT)
	) rescale_v2_0_M_OUT_AXIS_inst (	
		// user added ports start
		.out_stream_ready(out_stream_ready),                                                 
		.read_pointer(read_pointer),
		.out_pixel_data(out_pixel_data),
		// user added ports end
		.M_AXIS_ACLK(m_out_axis_aclk),
		.M_AXIS_ARESETN(m_out_axis_aresetn),
		.M_AXIS_TVALID(m_out_axis_tvalid),
		.M_AXIS_TDATA(m_out_axis_tdata),	//
		.M_AXIS_TSTRB(m_out_axis_tstrb),  
		.M_AXIS_TLAST(m_out_axis_tlast), //end of row
		.M_AXIS_TREADY(m_out_axis_tready)
	);

// Instantiation of Axi Bus Interface S_AXI
	rescale_v2_0_S_AXI # ( 
		.C_S_AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S_AXI_ADDR_WIDTH)
	) rescale_v2_0_S_AXI_inst (
		// Users to add ports here
		// for debug
		.C_STATE(C_STATE),
		.RESETN(RESETN),
		.GO(GO),
		.X_IN(X_IN),
		.Y_IN(Y_IN),
		.DONE(DONE),
		.ERROR(ERROR),
		// User ports ends
		.S_AXI_ACLK(s_axi_aclk),
		.S_AXI_ARESETN(s_axi_aresetn),
		.S_AXI_AWADDR(s_axi_awaddr),
		.S_AXI_AWPROT(s_axi_awprot),
		.S_AXI_AWVALID(s_axi_awvalid),
		.S_AXI_AWREADY(s_axi_awready),
		.S_AXI_WDATA(s_axi_wdata),
		.S_AXI_WSTRB(s_axi_wstrb),
		.S_AXI_WVALID(s_axi_wvalid),
		.S_AXI_WREADY(s_axi_wready),
		.S_AXI_BRESP(s_axi_bresp),
		.S_AXI_BVALID(s_axi_bvalid),
		.S_AXI_BREADY(s_axi_bready),
		.S_AXI_ARADDR(s_axi_araddr),
		.S_AXI_ARPROT(s_axi_arprot),
		.S_AXI_ARVALID(s_axi_arvalid),
		.S_AXI_ARREADY(s_axi_arready),
		.S_AXI_RDATA(s_axi_rdata),
		.S_AXI_RRESP(s_axi_rresp),
		.S_AXI_RVALID(s_axi_rvalid),
		.S_AXI_RREADY(s_axi_rready)
	);

	// Add user logic here
	
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
	
	rescale rescale_inst(
	// for debug
	.C_STATE(C_STATE),
	// global ports
	.CLOCK(CLOCK),
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
	
	
	buffer_in buffer_inst(
	// global ports
	.clock(CLOCK),
	.resetn(RESETN),
	// from interface (external)
	.S_AXIS_TDATA(s_in_axis_tdata), // stream_in_data from slave
	.S_AXIS_TLAST(s_in_axis_tlast), // eor from slave_AXIS
	.S_AXIS_TVALID(s_in_axis_tvalid) // valid trans (32'b) from master_AXIS
	.BUFFER_START(BUFFER_START),
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

endmodule
