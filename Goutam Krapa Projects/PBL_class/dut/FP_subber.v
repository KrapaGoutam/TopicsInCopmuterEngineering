module FP_subber(
  input         clock,
  input         reset,
  input  [31:0] io_in_a,
  input  [31:0] io_in_b,
  output [31:0] io_out_s
);
  wire  FP_adder_clock; // @[FloatingPointDesigns.scala 219:26]
  wire  FP_adder_reset; // @[FloatingPointDesigns.scala 219:26]
  wire [31:0] FP_adder_io_in_a; // @[FloatingPointDesigns.scala 219:26]
  wire [31:0] FP_adder_io_in_b; // @[FloatingPointDesigns.scala 219:26]
  wire [31:0] FP_adder_io_out_s; // @[FloatingPointDesigns.scala 219:26]
  wire  _adjusted_in_b_T_1 = ~io_in_b[31]; // @[FloatingPointDesigns.scala 222:23]
  FP_adder FP_adder ( // @[FloatingPointDesigns.scala 219:26]
    .clock(FP_adder_clock),
    .reset(FP_adder_reset),
    .io_in_a(FP_adder_io_in_a),
    .io_in_b(FP_adder_io_in_b),
    .io_out_s(FP_adder_io_out_s)
  );
  assign io_out_s = FP_adder_io_out_s; // @[FloatingPointDesigns.scala 225:14]
  assign FP_adder_clock = clock;
  assign FP_adder_reset = reset;
  assign FP_adder_io_in_a = io_in_a; // @[FloatingPointDesigns.scala 223:22]
  assign FP_adder_io_in_b = {_adjusted_in_b_T_1,io_in_b[30:0]}; // @[FloatingPointDesigns.scala 222:39]
endmodule

