module rising_edge_detector(
input clock,
input signal_in,
output rise
);

reg signal_reg;

always@(posedge clock) begin
signal_reg <= signal_in;
end

assign rise = !signal_reg & signal_in;

endmodule
