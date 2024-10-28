module tb_seq_det_101;

  // Inputs
  reg clk;
  reg rst;
  reg x;

  // Outputs
  wire y_mealy;
  wire y_moore;

  // Instantiate Mealy FSM
  seq_det_101_mealy mealy_fsm (
    .rst(rst),
    .clk(clk),
    .x(x),
    .y(y_mealy)
  );

  // Instantiate Moore FSM
  seq_det_101_moore moore_fsm (
    .rst(rst),
    .clk(clk),
    .x(x),
    .y(y_moore)
  );

  // Clock generation (50 MHz)
  always #5 clk = ~clk;

  initial begin
	rst=1'b0; clk=1'b0;// en=1'b0;
	x = 0;
    #10 rst=1'b1;
	@(posedge clk);// en=1'b1;
    // Initial state


    // Reset both FSMs
    //#5 rst = 1;
    //#10 rst = 0;

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
    $monitor("Time: %0d | x: %b | y_mealy: %b | y_moore: %b | rst: %b", $time, x, y_mealy, y_moore, rst);
  end

endmodule
