module tracking_fsm(
	input resetn,
	input clk,
	input s,
	input valid,
	input found,
	input x_lt_640,
	input x_eq_640,
	input y_eq_480,
	input count_ne_0,
	output reg reset_x,
	output reg reset_y,
	output reg reset_x_sum,	
	output reg reset_y_sum,
	output reg reset_count,
	output reg done,
	output reg reset_x_pos,
	output reg reset_y_pos,
	output reg enable_x,	
	output reg enable_y,	
	output reg enable_x_sum,	
	output reg enable_y_sum,	
	output reg enable_x_pos,	
	output reg enable_y_pos,
	output reg enable_count,
	output reg sel
);
	
	reg [1:0]ps,ns;
	localparam RESET = 2'b00,
	           NEW = 2'b11,
			   RUNNING = 2'b01,
			   DONE = 2'b10;
	
	always@(posedge clk)begin
		if(!resetn) ps <= RESET;
		else ps <= ns;
	end
	
	always@(*)begin
	    ns = ps;
		reset_x = 0;
		reset_y = 0;
		reset_x_sum = 0;	
		reset_y_sum = 0;
		reset_count = 0;
		done = 0;
		reset_x_pos = 0;
		reset_y_pos = 0;
		enable_x = 0;	
		enable_y = 0;	
		enable_x_sum = 0;	
		enable_y_sum = 0;	
		enable_x_pos = 0;	
		enable_y_pos = 0;
		enable_count = 0;
		sel = 0;
		
		case(ps)
			RESET: begin
				reset_x = 1;
				reset_y = 1;
				reset_x_sum = 1;	
				reset_y_sum = 1;
				reset_count = 1;
				reset_x_pos = 1;
				reset_y_pos = 1;				
				if(s)begin
					ns = NEW;
				end
			end
			
			NEW: begin
				reset_x = 1;
                reset_y = 1;
                reset_x_sum = 1;    
                reset_y_sum = 1;
                reset_count = 1;
				done = 1;
                if(valid)ns = RUNNING;
			end
			
			RUNNING: begin
				if(found)begin
					enable_x_sum = 1;	
					enable_y_sum = 1;
					enable_count = 1;
				end
				if(x_eq_640 & y_eq_480)begin
					ns = DONE;
				end
				else begin
					if(x_eq_640)begin
						reset_x = 1;
						enable_y = 1;
						ns = RUNNING;
					end
					else begin
						enable_x = 1;
						ns = RUNNING;
					end
				end
			end
			
			DONE: begin
				reset_x = 1;
				reset_y = 1;
				done = 1;
				ns = NEW;
				enable_x_pos = 1;
                enable_y_pos = 1;
				if(count_ne_0)begin
					sel = 1'b0;
				end
				else begin
				    sel = 1'b1;
				end
			end
		endcase
	end
endmodule	   