module calculate_pixel #(parameter n=0, start=0)( // bits of the color, starting bit
input [15:0] n0, // neighbor0
input [15:0] n1, // neighbor1
input [15:0] n2, // neighbor2
input [15:0] n3, // neighbor3
input [15:0] m3, // (1-delta_r)*(1-delta_c)
input [15:0] m4, // (delta_r)*(1-delta_c)
input [15:0] m5, // (1-delta_r)*(delta_c)
input [15:0] m6, // (delta_r)*(delta_c)
output [n-1:0] pixel_color, // weighted color
output err
);

wire [15:0] a0, a1, a2, a3, a01, a23, asum; // addition terms
wire [15:0] fpn0, fpn1, fpn2, fpn3; 

// n0~n3 convert to fixed-point
assign fpn0 = {1'b0,{(10-n){1'b0}},n0[start+n-1:start],5'b0};
assign fpn1 = {1'b0,{(10-n){1'b0}},n1[start+n-1:start],5'b0};
assign fpn2 = {1'b0,{(10-n){1'b0}},n2[start+n-1:start],5'b0};
assign fpn3 = {1'b0,{(10-n){1'b0}},n3[start+n-1:start],5'b0};

// multiplier a~d (wires)
wire overflow_flag_multa;
wire overflow_flag_multb;
wire overflow_flag_multc;
wire overflow_flag_multd;

qmult #(5,16) multa( // multiplier a for (a0 = fpn0 * m3)
.i_multiplicand(fpn0),
.i_multiplier(m3),
.o_result(a0),
.ovr(overflow_flag_multa)
);

qmult #(5,16) multb( // multiplier b for (a1 = fpn1 * m4)
.i_multiplicand(fpn1),
.i_multiplier(m4),
.o_result(a1),
.ovr(overflow_flag_multb)
);

qmult #(5,16) multc( // multiplier c for (a2 = fpn2 * m5)
.i_multiplicand(fpn2),
.i_multiplier(m5),
.o_result(a2),
.ovr(overflow_flag_multc)
);

qmult #(5,16) multd( // multiplier d for (a3 = fpn3 * m6)
.i_multiplicand(fpn3),
.i_multiplier(m6),
.o_result(a3),
.ovr(overflow_flag_multd)
);

qadd #(5,16) adda( // adder a for (a01 = a0 + a1)
.a(a0),
.b(a1),
.c(a01)
);

qadd #(5,16) addb( // adder b for (a23 = a2 + a3)
.a(a2),
.b(a3),
.c(a23)
);

qadd #(5,16) addc( // adder c for (asum = a01 + a23)
.a(a01),
.b(a23),
.c(asum)
);

assign pixel_color = asum[n+4:5]; // use only the n integer values
assign err = overflow_flag_multa & overflow_flag_multb
 & overflow_flag_multc & overflow_flag_multd; // overflow_flag checking

endmodule