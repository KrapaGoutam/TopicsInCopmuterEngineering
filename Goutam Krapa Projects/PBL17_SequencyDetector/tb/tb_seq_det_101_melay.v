module tb_seq_det_101_melay;

  reg clk;
  reg rst;
  reg x;
  wire y;

  // Instantiate Mealy FSM
  seq_det_101_mealy mealy_fsm (
    .rst(rst),
    .clk(clk),
    .x(x),
    .y(y)
  );

  // Clock generation (50 MHz)
  always #5 clk = ~clk;

  initial begin
    rst = 1'b0; clk = 1'b0;
    x = 0;
    #10 rst = 1'b1;

    // Input sequence to test "101" detection
    #10 x = 0;
    #10 x = 1;
    #10 x = 1;
    #10 x = 1;
    #10 x = 0;
    #10 x = 1; // First "101" detected
    #10 x = 0;
    #10 x = 0;
    #10 x = 1; // Second "101" detected (overlapping)
    #10 x = 0;
    #10 x = 1;
    #10 x = 0;
    #10 x = 1; // Additional transitions to check FSM behavior
    #10 x = 0;
    #10 x = 0;

    #200;
  end

  // Display signals
  initial begin
    $monitor("Time: %0d | x: %b | y_mealy: %b | rst: %b", 
             $time, x, y, rst);
  end

endmodule
