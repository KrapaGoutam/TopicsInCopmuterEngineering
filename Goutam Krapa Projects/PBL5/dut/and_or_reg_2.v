module top_and_or_reg (
  input wire a, b, c, d,     // Inputs for AND-OR logic
  input wire clk,            // Clock signal
  input wire rst,            // Reset signal
  output wire f              // Final output (registered value)
);

  // Internal signal to connect combinational logic to the register
  wire e;

  // Instantiate the AND-OR logic module
  and_or u_and_or (
    .a(a),
    .b(b),
    .c(c),
    .d(d),
    .e(e)
  );

  // Instantiate the register module (using a 1-bit register for simplicity)
  register u_register (
    .d({3'b000, e}),         // Only use the LSB of the register for 'e'
    .clk(clk),
    .rst(rst),
    .q(f)
  );

endmodule
