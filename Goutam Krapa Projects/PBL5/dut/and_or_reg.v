module and_or_reg (
input clk,
input rst,
input a , 
input b,
input c,
input d,
output reg f
  //input wire a, b, c, d,    // Inputs a, b, c, d
  //input wire clk,           // Clock signal
  //input wire rst,           // Reset signal
  //output reg f              // Output f (registered output)
);

  // Internal signal to hold the combinational logic result
  //wire e;
// or wire e = (a & b) | (c & d);
wire e = (a & b) | (c & d);
  // Combinational logic: AND and OR gates
  //assign e = (a & b) | (c & d);

  // Sequential logic: Register with asynchronous reset
  //always @(posedge clk or negedge rst) begin
  always @(posedge clk, negedge rst) begin
    if (~rst) begin					// or !rst
      f <= 1'b0;  
		end	  // Asynchronous reset (active-low)
    else begin
      f <= e;     
		end	  // On clock edge, store the value of e
  end

endmodule
