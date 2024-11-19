module tb_basic_ddot();
reg         clk  ;
reg         rst  ;
reg         ready;
reg  [31:0] x0   ;
reg  [31:0] x1   ;
reg  [31:0] x2   ;
reg  [31:0] x3   ;
reg  [31:0] y0   ;
reg  [31:0] y1   ;
reg  [31:0] y2   ;
reg  [31:0] y3   ;
wire  		vld	 ;
wire [31:0] z    ; 

basic_ddot u_basic_ddot(.clk  (clk  ),
						.rst  (rst  ),
						.ready(ready),
						.x0   (x0   ),
						.x1   (x1   ),
						.x2   (x2   ),
						.x3   (x3   ),
						.y0   (y0   ),
						.y1   (y1   ),
						.y2   (y2   ),
						.y3   (y3   ),
						.vld  (vld	),
                        .z    (z    )); 

always #10 clk = ~clk;

integer i;
initial begin
// Reset and clock initialization
        rst   = 1'b1;
        clk   = 1'b0;
		ready=1'b0;
        x0 = 32'h0;
        x1 = 32'h0;
        x2 = 32'h0;
        x3 = 32'h0;
        y0 = 32'h0;
        y1 = 32'h0;
        y2 = 32'h0;
        y3 = 32'h0;

		@(negedge(clk));
        rst = 1'b0;
		@(posedge(clk));
		ready=1'b1;
        x0 = 32'h3f800000;
        x1 = 32'h3f800000;
        x2 = 32'h3f800000;
        x3 = 32'h3f800000;
        y0 = 32'h3f800000;
        y1 = 32'h3f800000;
        y2 = 32'h3f800000;
        y3 = 32'h3f800000;

		@(posedge(clk));
		ready=1'b1;
		x0 = 32'h40000000;
        x1 = 32'h40000000;
        x2 = 32'h40000000;
        x3 = 32'h40000000;
        y0 = 32'h40000000;
        y1 = 32'h40000000;
        y2 = 32'h40000000;
        y3 = 32'h40000000;
		
		@(posedge(clk));
		ready=1'b1;
        x0 = 32'h3f800000;
        x1 = 32'h3f800000;
        x2 = 32'h3f800000;
        x3 = 32'h3f800000;
        y0 = 32'h3f800000;
        y1 = 32'h3f800000;
        y2 = 32'h3f800000;
        y3 = 32'h3f800000;

		@(posedge(clk));
		ready=1'b1;
		x0 = 32'h40000000;
        x1 = 32'h40000000;
        x2 = 32'h40000000;
        x3 = 32'h40000000;
        y0 = 32'h40000000;
        y1 = 32'h40000000;
        y2 = 32'h00000000;
        y3 = 32'h00000000;

		@(posedge(clk));
		ready=1'b0;
		x0 = 32'h0;
        x1 = 32'h0;
        x2 = 32'h0;
        x3 = 32'h0;
        y0 = 32'h0;
        y1 = 32'h0;
        y2 = 32'h0;
        y3 = 32'h0;

end

endmodule

