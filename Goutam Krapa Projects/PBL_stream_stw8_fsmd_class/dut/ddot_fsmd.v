module ddot_fsmd (	input         clk  ,
					input         rst  ,
					input         ready,
					input  [31:0] x0,
					input  [31:0] x1,
					input  [31:0] x2,
					input  [31:0] x3,
					input  [31:0] x4,
					input  [31:0] x5,
					input  [31:0] x6,
					input  [31:0] x7,
					input  [31:0] y0,
					input  [31:0] y1,
					input  [31:0] y2,
					input  [31:0] y3,
					input  [31:0] y4,
					input  [31:0] y5,
					input  [31:0] y6,
					input  [31:0] y7,
					output 		  valid,
					output [31:0] z    );

wire [31:0] p0, p1, p2, p3, p4, p5, p6, p7; 
wire [31:0] s0, s1, s2, s3, s4, s5; 

reg [3:0] rdy_vld;
always @(posedge clk, negedge rst) begin
	if(rst) begin	
		rdy_vld<=4'b0;
	end else begin
		rdy_vld<={ready, rdy_vld[3:1]};
	end
end

assign vld = rdy_vld[0];

// The first stage of multipliers
FP_multiplier u0_FP_multiplier(.clock   (clk  ),
                        .reset   (rst  ),
                        .io_in_a (x0   ),
                        .io_in_b (y0   ),
                        .io_out_s(p0   ));

FP_multiplier u1_FP_multiplier(.clock   (clk  ),
                        .reset   (rst  ),
                        .io_in_a (x1   ),
                        .io_in_b (y1   ),
                        .io_out_s(p1   ));

FP_multiplier u2_FP_multiplier(.clock   (clk  ),
                        .reset   (rst  ),
                        .io_in_a (x2   ),
                        .io_in_b (y2   ),
                        .io_out_s(p2   ));

FP_multiplier u3_FP_multiplier(.clock   (clk  ),
                        .reset   (rst  ),
                        .io_in_a (x3   ),
                        .io_in_b (y3   ),
                        .io_out_s(p3   ));

FP_multiplier u4_FP_multiplier(.clock   (clk  ),
                        .reset   (rst  ),
                        .io_in_a (x4   ),
                        .io_in_b (y4   ),
                        .io_out_s(p4   ));

FP_multiplier u5_FP_multiplier(.clock   (clk  ),
                        .reset   (rst  ),
                        .io_in_a (x5   ),
                        .io_in_b (y5   ),
                        .io_out_s(p5   ));

FP_multiplier u6_FP_multiplier(.clock   (clk  ),
                        .reset   (rst  ),
                        .io_in_a (x6   ),
                        .io_in_b (y6   ),
                        .io_out_s(p6   ));

FP_multiplier u7_FP_multiplier(.clock   (clk  ),
                        .reset   (rst  ),
                        .io_in_a (x7   ),
                        .io_in_b (y7   ),
                        .io_out_s(p7   ));

// The second stage of adders
FP_adder u0_FP_adder(.clock   (clk  ),
                   .reset   (rst  ),
                   .io_in_a (p0   ),
                   .io_in_b (p1   ),
                   .io_out_s(s0   ));

FP_adder u1_FP_adder(.clock   (clk  ),
                   .reset   (rst  ),
                   .io_in_a (p2   ),
                   .io_in_b (p3   ),
                   .io_out_s(s1   ));

FP_adder u2_FP_adder(.clock   (clk  ),
                   .reset   (rst  ),
                   .io_in_a (p4   ),
                   .io_in_b (p5   ),
                   .io_out_s(s2   ));

FP_adder u3_FP_adder(.clock   (clk  ),
                   .reset   (rst  ),
                   .io_in_a (p6   ),
                   .io_in_b (p7   ),
                   .io_out_s(s3   ));

// The third stage of adders
FP_adder u4_FP_adder(.clock   (clk  ),
                   .reset   (rst  ),
                   .io_in_a (s0   ),
                   .io_in_b (s1   ),
                   .io_out_s(s4   ));

FP_adder u5_FP_adder(.clock   (clk  ),
                   .reset   (rst  ),
                   .io_in_a (s2   ),
                   .io_in_b (s3   ),
                   .io_out_s(s5   ));

// The fourth stage of adders
FP_adder u6_FP_adder(.clock   (clk  ),
                   .reset   (rst  ),
                   .io_in_a (s4   ),
                   .io_in_b (s5   ),
                   .io_out_s(z    ));
endmodule
