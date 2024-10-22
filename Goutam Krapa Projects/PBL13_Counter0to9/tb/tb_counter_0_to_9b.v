module tb_counter_0_to_9;

    reg clk;
    reg rst;
    reg en;
    wire [3:0] cnt;

    // Instantiate the counter
    counter_0_to_9 uut (
        .clk(clk),
        .rst(rst),
        .en(en),
        .cnt(cnt)
    );

    // Clock generation
    always #5 clk = ~clk;  // Clock period = 10 time units

    initial begin
        // Initialize inputs
        clk = 0;
        //rst = 0;
        //en = 0;

        // Apply reset
        #10 rst = 1;  // Release reset
        #10 en = 1;   // Enable counter

        // Observe counting
        #100 en = 0;  // Disable counter after 100 time units

        // End simulation
        #20 $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time: %0d, Count: %0d", $time, cnt);
    end

endmodule
