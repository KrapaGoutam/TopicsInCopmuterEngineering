module and_or_reg (
input clk,
input rst,
input a , 
input b,
input c,
input d,
output reg f
//if wire or reg not mentioned its default as wire 
);

// Internal signal to hold the combinational logic result
// Combinational logic: AND and OR gates
wire e = (a & b) | (c & d);
//OR
//wire e;
//wire e = (a & b) | (c & d);
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
