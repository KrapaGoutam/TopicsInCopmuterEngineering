module tb_counter_with_vld;

    // Inputs
    reg clk;
    reg rst;
    reg en;

    // Outputs
    wire [3:0] cnt;
    wire vld;

    // Instantiate the counter module
    counter_with_vld uut (
        .clk(clk),
        .rst(rst),
        .en(en),
        .cnt(cnt),
        .vld(vld)
    );

    // Clock generation (50 MHz -> 20 ns period)
    always #10 clk = ~clk;  // Clock period = 20 ns (for 50 MHz)

    // Testbench sequence
    initial begin
        // Initial state
        clk = 1'b0;      // Initial clock state
        rst = 1'b1;      // Apply reset
        en = 1'b0;    // Initially, en signal is low
        
        // Wait for 10 ns (half a clock period) to allow reset to propagate
        #10;
        
        // Deassert reset
        rst = 1'b0;      // Release reset after 10 ns

        // Wait for a clock edge
        @(posedge clk);
        
        // Enable counting
        en = 1'b1;    // Set en signal to enable counting

        // Let the counter run for some time (e.g., 200 ns)
        #200;

        // Disable counting
        en = 1'b0;    // Disable counting after 200 ns

        // Wait for a few more clock cycles to observe behavior when en is low
        #40;

        // Re-enable counting
        en = 1'b1;    // Re-enable counting

        // Let the simulation run for a bit more to observe the full cycle
        #100;

        // Finish the simulation
        $finish;
    end

    // Monitor signals to observe the behavior
    initial begin
        $monitor("Time: %0d ns, clk: %b, rst: %b, en: %b, cnt: %0d, vld: %b", 
                 $time, clk, rst, en, cnt, vld);
    end

endmodule
