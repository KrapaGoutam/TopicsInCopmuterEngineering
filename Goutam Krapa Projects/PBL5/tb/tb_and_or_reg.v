//Test bench module
module tb_and_or_reg();

// Inputs to the circuit
  reg a, b, c, d;  
// Clock and Reset signals  
  reg clk, rst;    
// Output f  
  wire f;                 
  
  // Instantiate the design under test (DUT)
  and_or_reg uut (
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
  initial begin
    // Initialize signals
    clk = 1'b0; rst = 1'b0;
    a = 1'b0; b = 1'b0; c = 1'b0; d = 1'b0;
    // Apply reset
    #10 rst = 1'b1;
    // Apply test cases
    #10; a = 1'b1; b = 1'b1; c = 1'b0; d = 1'b0;  // Test case 1
    #10; a = 1'b0; b = 1'b1; c = 1'b0; d = 1'b1;  // Test case 2
    #10; a = 1'b0; b = 1'b1; c = 1'b1; d = 1'b1;  // Test case 3
    #10; a = 1'b0; b = 1'b1; c = 1'b0; d = 1'b1;  // Test case 4
  end

endmodule
