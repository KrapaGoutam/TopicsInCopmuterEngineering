module FP_subtractor_13ccs(
  input         clock,
  input         reset,
  input         io_in_en,
  input  [31:0] io_in_a,
  input  [31:0] io_in_b,
  output [31:0] io_out_s
);
  wire  FP_adder_clock; // @[FloatingPointDesigns.scala 1654:26]
  wire  FP_adder_reset; // @[FloatingPointDesigns.scala 1654:26]
  wire  FP_adder_io_in_en; // @[FloatingPointDesigns.scala 1654:26]
  wire [31:0] FP_adder_io_in_a; // @[FloatingPointDesigns.scala 1654:26]
  wire [31:0] FP_adder_io_in_b; // @[FloatingPointDesigns.scala 1654:26]
  wire [31:0] FP_adder_io_out_s; // @[FloatingPointDesigns.scala 1654:26]
  wire  _adjusted_in_b_T_1 = ~io_in_b[31]; // @[FloatingPointDesigns.scala 1657:23]
  FP_adder_13ccs FP_adder ( // @[FloatingPointDesigns.scala 1654:26]
    .clock(FP_adder_clock),
    .reset(FP_adder_reset),
    .io_in_en(FP_adder_io_in_en),
    .io_in_a(FP_adder_io_in_a),
    .io_in_b(FP_adder_io_in_b),
    .io_out_s(FP_adder_io_out_s)
  );
  assign io_out_s = FP_adder_io_out_s; // @[FloatingPointDesigns.scala 1661:14]
  assign FP_adder_clock = clock;
  assign FP_adder_reset = reset;
  assign FP_adder_io_in_en = io_in_en; // @[FloatingPointDesigns.scala 1658:23]
  assign FP_adder_io_in_a = io_in_a; // @[FloatingPointDesigns.scala 1659:22]
  assign FP_adder_io_in_b = {_adjusted_in_b_T_1,io_in_b[30:0]}; // @[FloatingPointDesigns.scala 1657:41]
endmodule

