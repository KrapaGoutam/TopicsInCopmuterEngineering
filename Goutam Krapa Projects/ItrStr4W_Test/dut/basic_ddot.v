
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
wire en;
wire cnt;

wire [31:0] p0, p1, p2, p3; 
wire [31:0] s0, s1, s2, s3;

wire [31:0] p0_op, p1_op, p2_op, p3_op; 
wire [31:0] s0_op, s1_op, s2_op, s3_op;

reg [31:0] p0_reg, p1_reg, p2_reg, p3_reg; 
reg [31:0] s0_reg, s1_reg, s2_reg, s3_reg;

wire [31:0] z_op;

//----------------------------------------------
//   START: Timing control delay register and counter
//----------------------------------------------
reg [55:0] rdy_vld;
always @(posedge clk, negedge rst) begin
	if(rst) begin	
		rdy_vld<=4'b0;
	end else begin
		rdy_vld<={ready, rdy_vld[55:1]};
	end
end

//----------------------------------------------
//   END: Timing control delay register and counter
//----------------------------------------------

// The first stage of multipliers
FP_multiplier_10ccs u0_fp_mul_hp(.clock   (clk  ),
                        .reset   (rst  ),
						.io_in_en(1'b1),
                        .io_in_a (x0   ),
                        .io_in_b (y0   ),
                        .io_out_s(p0_op   ));

FP_multiplier_10ccs u1_fp_mul_hp(.clock   (clk  ),
                        .reset   (rst  ),
						.io_in_en(1'b1),
                        .io_in_a (x1   ),
                        .io_in_b (y1   ),
                        .io_out_s(p1_op   ));

FP_multiplier_10ccs u2_fp_mul_hp(.clock   (clk  ),
                        .reset   (rst  ),
						.io_in_en(1'b1),
                        .io_in_a (x2   ),
                        .io_in_b (y2   ),
                        .io_out_s(p2_op   ));

FP_multiplier_10ccs u3_fp_mul_hp(.clock   (clk  ),
                        .reset   (rst  ),
						.io_in_en(1'b1),
                        .io_in_a (x3   ),
                        .io_in_b (y3   ),
                        .io_out_s(p3_op   ));
						
//---------------------------------
//START: after 10ccs of  multipliers
//-----------------------------	

//delay after 10ccs
always @(posedge clk, negedge rst) begin
    if (rst) begin
        p0_reg <= 32'h0;
		p1_reg <= 32'h0;
		p2_reg <= 32'h0;
		p3_reg <= 32'h0;
    end
    else begin
        p0_reg <= rdy_vld[46] ? p0_op : 32'h0;
		p1_reg <= rdy_vld[46] ? p1_op : 32'h0;
		p2_reg <= rdy_vld[46] ? p2_op : 32'h0;
		p3_reg <= rdy_vld[46] ? p3_op : 32'h0;
    end
end

//---------------------------------
//END: after 10ccs of  multipliers
//-----------------------------						
						

// The second stage of adders
FP_adder_13ccs u0_fp_add_hp(.clock   (clk  ),
                   .reset   (rst  ),
				   .io_in_en(1'b1),
                   .io_in_a (p0_reg   ),
                   .io_in_b (p1_reg   ),
                   .io_out_s(s0_op   ));

FP_adder_13ccs u1_fp_add_hp(.clock   (clk  ),
                   .reset   (rst  ),
				   .io_in_en(1'b1),
                   .io_in_a (p2_reg   ),
                   .io_in_b (p3_reg   ),
                   .io_out_s(s1_op   ));
				   
//---------------------------------
//START: Stage 2 after 13ccs of  adder
//-----------------------------	

//delay after 10ccs
always @(posedge clk, negedge rst) begin
    if (rst) begin
        s0_reg <= 32'h0;
		s1_reg <= 32'h0;
    end
    else begin
        s0_reg <= rdy_vld[32]  	? s0_op : 32'h0;
		s1_reg <= rdy_vld[32] 	? s1_op : 32'h0;
    end
end

//---------------------------------
//END: stage 2 after 13ccs of  adder
//-----------------------------						
						
// The third stage of adders
FP_adder_13ccs u2_fp_add_hp(	.clock   (clk  ),
							   .reset   (rst  ),
							   .io_in_en(1'b1),
							   .io_in_a (s0_reg   ),
							   .io_in_b (s1_reg   ),
							   .io_out_s(s2_op   ));

//---------------------------------
//START: Stage 3 after 13ccs of  adder
//-----------------------------	

//delay after 10ccs
always @(posedge clk, negedge rst) begin
    if (rst) begin
        s2_reg <= 32'h0;
    end
    else begin
        s2_reg <= rdy_vld[18]  ? s2_op : 32'h0;
    end
end

//---------------------------------
//END: stage 3 after 13ccs of  adder
//-----------------------------		

wire s2_d_flag = rdy_vld[17];
wire [31:0] nxt_s2_d = s2_d_flag ? s2_reg : 32'h0;
reg  [31:0] s2_d;

//reg out
always @(posedge clk, posedge rst) begin
  if(rst) begin
    s2_d <= 32'h0   ;
  end else begin
    s2_d <= nxt_s2_d;
  end
end

assign s3 = rdy_vld[16] ? s2_reg : 32'h0;

// The fourth stage of adders
FP_adder_13ccs u3_fp_add_hp(.clock   (clk  ),
                   .reset   (rst  ),
				   .io_in_en(1'b1),
                   .io_in_a (s2_d ),
                   .io_in_b (s3   ),
                   .io_out_s(z_op    ));

//---------------------------------
//START: stage 4 after 13ccs of  adder
//-----------------------------		
	   
assign en = rdy_vld[3];

counter_0_to_9 u_counter_0_to_9(
    .clk(clk),        // clock signal
    .rst(rst),        // reset
    .en(en),         // enable signal which is active when high
    .cnt(cnt)  // 2-bit counter output    
); 

assign vld = rdy_vld[3] & ~ cnt;
assign z = vld ? z_op : 32'h0;

//---------------------------------
//END: stage 4 after 13ccs of  adder
//-----------------------------		

endmodule



//******************************************************************
//START: Counter module to count every 2 cycles = binary counter 0 and 1 
//******************************************************************	

module counter_0_to_9 (
    input  clk,        // clock signal
    input  rst,        // reset
    input  en,         // enable signal which is active when high
    output reg cnt  // 2-bit counter output    
);

	wire nxt_cnt = en ? cnt+4'h1 : cnt;

    // Counter logic with reset
    always @(posedge clk, negedge rst) begin
        if (rst) begin
            cnt <= 4'h0;  // reset counter to 0 when reset is active that is rst=1
        end else begin
            cnt <= nxt_cnt;  // update counter with next value as next counter
        end
    end

endmodule
//******************************************************************
//END: Counter module to count every 2 cycles = binary counter 0 and 1 
//******************************************************************	