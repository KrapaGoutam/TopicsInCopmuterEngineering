module top_and_or_reg_tb;

  reg a, b, c, d;         // Inputs to the circuit
  reg clk, rst;           // Clock and Reset signals
  wire f;                 // Output f

  // Instantiate the top-level module (DUT)
  top_and_or_reg dut (
    .a(a),
    .b(b),
    .c(c),
    .d(d),
    .clk(clk),
    .rst(rst),
    .f(f)
  );

  // Clock generation: toggle every 5 time units
  always #5 clk = ~clk;

  // Testbench logic
  integer i;
  initial begin
    // Initialize signals
    clk = 1'b0;
    rst = 1'b0;
    a = 1'b0;
    b = 1'b0;
    c = 1'b0;
    d = 1'b0;
    
    // Apply reset
    #15 rst = 1'b1;
    
    // Apply test cases using loop
    for (i = 0; i < 16; i = i + 1) begin
      {a, b, c, d} = i;          // Set inputs
      @(posedge clk);            // Wait for clock edge
    end
    
    // Reset inputs
    {a, b, c, d} = 4'b0000;
  end

  // Testcase check and verification
  integer j;
  initial begin
    j = 0;
    wait(rst);                     // Wait for reset to be de-asserted
    repeat(2) @(negedge clk);      // Wait for a few clock cycles
    repeat(16) begin
      if (f == ((a & b) | (c & d))) begin
        $display("Test case %d pass at %d ns", j, $time);
      end else begin
        $display("Test case %d FAIL at %d ns, expected: %d, got: %d", j, $time, (a & b) | (c & d), f);
      end
      @(negedge clk);
      j = j + 1;
    end
  end

endmodule
