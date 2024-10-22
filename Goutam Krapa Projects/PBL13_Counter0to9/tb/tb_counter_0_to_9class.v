module tb_counter_0_to_9();
    // Inputs
    reg clk;
    reg rst;
    reg en;
    // Outputs
    wire [3:0] cnt;


    // Instantiate the counter module uut=Unit Under Testing
    counter_0_to_9 u_counter_0_to_9 (
        .clk(clk),
        .rst(rst),
        .en(en),
        .cnt(cnt)
    );

//Bus Function model
	//clock process 100 MHz
    always #5 clk = ~clk;  


    initial begin
        // Initial state
		rst=1'b0; clk=1'b0; en=1'b0;
        #10 rst=1'b1;
		@(posedge clk) en=1'b1;
		#100 rst=1'b0;//reset within counting
		#30 rst=1'b1;
		repeat(15) @(posedge clk) en=1'b0;
		repeat(10) @(posedge clk) en=1'b1;
		

        // uncomment if you want to Finish the simulation
        //$finish;
    end

    // monitor signal behavior
    initial begin
        $monitor("Time: %0d ns, clk: %b, rst: %b, en: %b, cnt: %0d", 
                 $time, clk, rst, en, cnt);
    end

endmodule
