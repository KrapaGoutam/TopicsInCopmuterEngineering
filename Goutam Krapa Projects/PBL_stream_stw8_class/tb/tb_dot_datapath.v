module tb_dot_datapath();

    reg         clk  ;
    reg         rst  ;
    reg  [31:0] x0   ;
    reg  [31:0] x1   ;
    reg  [31:0] x2   ;
    reg  [31:0] x3   ;
    reg  [31:0] x4   ;
    reg  [31:0] x5   ;
    reg  [31:0] x6   ;
    reg  [31:0] x7   ;
    reg  [31:0] y0   ;
    reg  [31:0] y1   ;
    reg  [31:0] y2   ;
    reg  [31:0] y3   ;
    reg  [31:0] y4   ;
    reg  [31:0] y5   ;
    reg  [31:0] y6   ;
    reg  [31:0] y7   ;
    wire [31:0] z    ; 

    dot_datapath u_dot_datapath(
        .clk  (clk  ),
        .rst  (rst  ),
        .x0   (x0   ),
        .x1   (x1   ),
        .x2   (x2   ),
        .x3   (x3   ),
        .x4   (x4   ),
        .x5   (x5   ),
        .x6   (x6   ),
        .x7   (x7   ),
        .y0   (y0   ),
        .y1   (y1   ),
        .y2   (y2   ),
        .y3   (y3   ),
        .y4   (y4   ),
        .y5   (y5   ),
        .y6   (y6   ),
        .y7   (y7   ),
        .z    (z    )
    ); 

    // Clock generation
    always #10 clk = ~clk;

    initial begin
        // Reset and clock initialization
        rst   = 1'b1;
        clk   = 1'b0;
        x0 = 32'h0;
        x1 = 32'h0;
        x2 = 32'h0;
        x3 = 32'h0;
        x4 = 32'h0;
        x5 = 32'h0;
        x6 = 32'h0;
        x7 = 32'h0;
        y0 = 32'h0;
        y1 = 32'h0;
        y2 = 32'h0;
        y3 = 32'h0;
        y4 = 32'h0;
        y5 = 32'h0;
        y6 = 32'h0;
        y7 = 32'h0;
        #16;
        rst = 1'b0;

        // Set inputs to a specific value
        x0 = 32'h3f800000;
        x1 = 32'h3f800000;
        x2 = 32'h3f800000;
        x3 = 32'h3f800000;
        x4 = 32'h3f800000;
        x5 = 32'h3f800000;
        x6 = 32'h3f800000;
        x7 = 32'h3f800000;
        y0 = 32'h3f800000;
        y1 = 32'h3f800000;
        y2 = 32'h3f800000;
        y3 = 32'h3f800000;
        y4 = 32'h3f800000;
        y5 = 32'h3f800000;
        y6 = 32'h3f800000;
        y7 = 32'h3f800000;

        #20; // Optional delay for simulation purposes
    end
endmodule
