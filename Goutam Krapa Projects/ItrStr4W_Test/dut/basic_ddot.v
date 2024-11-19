
module basic_ddot (	input         clk  ,
					input         rst  ,
					input         ready,
					input  [31:0] x0,
					input  [31:0] x1,
					input  [31:0] x2,
					input  [31:0] x3,
					input  [31:0] y0,
					input  [31:0] y1,
					input  [31:0] y2,
					input  [31:0] y3,
					output 		  vld,
					output [31:0] z    );

wire [31:0] p0, p1, p2, p3; 
wire [31:0] s0, s1, s2, s3; 

// The first stage of multipliers
FP_multiplier u0_fp_mul(.clock   (clk  ),
                        .reset   (rst  ),
                        .io_in_a (x0   ),
                        .io_in_b (y0   ),
                        .io_out_s(p0   ));

FP_multiplier u1_fp_mul(.clock   (clk  ),
                        .reset   (rst  ),
                        .io_in_a (x1   ),
                        .io_in_b (y1   ),
                        .io_out_s(p1   ));

FP_multiplier u2_fp_mul(.clock   (clk  ),
                        .reset   (rst  ),
                        .io_in_a (x2   ),
                        .io_in_b (y2   ),
                        .io_out_s(p2   ));

FP_multiplier u3_fp_mul(.clock   (clk  ),
                        .reset   (rst  ),
                        .io_in_a (x3   ),
                        .io_in_b (y3   ),
                        .io_out_s(p3   ));

// The second stage of adders
FP_adder u0_fp_add(.clock   (clk  ),
                   .reset   (rst  ),
                   .io_in_a (p0   ),
                   .io_in_b (p1   ),
                   .io_out_s(s0   ));

FP_adder u1_fp_add(.clock   (clk  ),
                   .reset   (rst  ),
                   .io_in_a (p2   ),
                   .io_in_b (p3   ),
                   .io_out_s(s1   ));

// The third stage of adders
FP_adder u2_fp_add(.clock   (clk  ),
                   .reset   (rst  ),
                   .io_in_a (s0   ),
                   .io_in_b (s1   ),
                   .io_out_s(s2   ));

reg [6:0] rdy_vld;
always @(posedge clk, negedge rst) begin
	if(rst) begin	
		rdy_vld<=4'b0;
	end else begin
		rdy_vld<={ready, rdy_vld[6:1]};
	end
end

assign vld = rdy_vld[2];

wire s2_d_flag = rdy_vld[4];
wire [31:0] nxt_s2_d = s2_d_flag ? s2 : 32'h0;
reg  [31:0] s2_d;

//reg out
always @(posedge clk, posedge rst) begin
  if(rst) begin
    s2_d <= 32'h0   ;
  end else begin
    s2_d <= nxt_s2_d;
  end
end

assign s3 = rdy_vld[3] ? s2 : 32'h0;

// The fourth stage of adders
FP_adder u3_fp_add(.clock   (clk  ),
                   .reset   (rst  ),
                   .io_in_a (s2_d ),
                   .io_in_b (s3   ),
                   .io_out_s(z    ));
	
endmodule