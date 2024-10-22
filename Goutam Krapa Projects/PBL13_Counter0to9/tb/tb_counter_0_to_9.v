module tb_counter_0_to_9;

    // Inputs
    reg clk;
    reg rst;
    reg en;

    // Outputs
    wire [3:0] cnt;
    wire vld;

    // Instantiate the counter module uut=Unit Under Testing
    counter_0_to_9 uut (
        .clk(clk),
        .rst(rst),
        .en(en),
        .cnt(cnt),
        .vld(vld)
    );


    always #10 clk = ~clk;  


    initial begin
        // Initial state
        clk = 1'b0;      
        rst = 1'b0;      
        en = 1'b0;       

        //#5 rst = 1'b0;
        #30 rst = 1'b1;  

        // at a clock edge
        @(posedge clk);


        en = 1'b1;      


        #300;

        // uncomment if you want to Finish the simulation
        //$finish;
    end

    // monitor signal behavior
    initial begin
        $monitor("Time: %0d ns, clk: %b, rst: %b, en: %b, cnt: %0d, vld: %b", 
                 $time, clk, rst, en, cnt, vld);
    end

endmodule
