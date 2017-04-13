`include "global.vh"

`include "utils.sv"
`include "tasks.sv"


module tb();
    integer i, ifh, ofh, dfh;

    // Frame buffer
    reg [`CHANNEL_SIZE - 1:0] mem[0:`MEM_SIZE];

    // Bitmap metadata
    integer width;
    integer height;
    integer size_of_data;
    integer offset_to_data;
    integer count;
    integer padding;
    integer bytes_per_pixel;

    // Inputs to DUT
    reg clk;
    reg reset_n;
    reg en;
    reg [`PIXEL_SIZE - 1:0] data;
	
	reg [31:0] count1;
    // Outputs from DUT
    wire [`PIXEL_SIZE - 1:0] out;

	reg valid;
	wire [31:0] data_in;
	reg [31:0] ref_color;
	reg [31:0] threshold;
	wire [31:0]x_pos, y_pos,y_pos_d;
	wire done;
	reg s;
	
	assign data_in = {8'b0,data};
    // Instantiate the Device Under Test (DUT)
     track DUT(
		 clk,
		 reset_n,
		 s,
		 data_in,
		 valid,
		 ref_color,
		 threshold,
		 done,
		 x_pos,
		 y_pos_d
    );
	assign y_pos = 480-y_pos_d;
    // -----------------------
    // Initialization sequence
    // -----------------------
    initial begin
        // Initialize inputs
        clk = 0;
        reset_n = 0;
		s = 0;
        count = 0;
        en = 0;
		ref_color = 32'h001f0000; // red color
		threshold = 32'h00050a0a; // threshold R = 5 , G =10 , B = 10 
		valid = 1;

        // Take out of reset
        #20
        reset_n = 1;
        en = 1;
        data = 0;
		
		#10 s = 1;

        // Open files
        ifh = open_file(`IFILE, "rb");
        ofh = open_file(`OFILE, "wb");

        // Read bitmap
        read_bmp_head(
            .ifh(ifh),
            .width(width),
            .height(height),
            .size_of_data(size_of_data),
            .offset_to_data(offset_to_data),
            .padding(padding),
            .bytes_per_pixel(bytes_per_pixel)
        );

        read_bmp_data(
            .ifh(ifh),
            .bytes_per_row(width * bytes_per_pixel),
            .rows(height),
            .padding(padding),
            .mem(mem)
        );
    end

    // --------------------
    // Termination sequence
    // --------------------
    initial begin
        #`SIM_TIME

        // Write bitmap
        write_bmp_head(ifh, ofh);

        write_bmp_data(
            .ofh(ofh),
            .bytes_per_row(width * bytes_per_pixel),
            .rows(height),
            .padding(padding),
            .mem(mem)
        );

        // Close files
        $fclose(ifh);
        $fclose(ofh);
		
		$display("postion of the red object is:\n x=%d\n y=%d\n",x_pos,y_pos);

        // Exit
        $finish;
    end

    // ----------------
    // Clock generation
    // ----------------
    always begin
        #10 clk  = ~clk ;

	end


    //-----------
    // Test logic
    //-----------
    always @ (posedge clk) begin
       /***** Input stimulus *****/
        data = {mem[count + 2], mem[count + 1], mem[count + 0]};
		

    //    /***** Output verification *****/
        mem[count + 0] = data[7:0];
        mem[count + 1] = data[15:8];
        mem[count + 2] = data[23:16];

        /***** Test bench logic *****/
        count += 3;
    end

endmodule
