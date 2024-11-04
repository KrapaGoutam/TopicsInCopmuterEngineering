module tb_seq_det_101();

  reg clk;
  reg rst;
  reg x;
  wire y;
  
	//dut instantitation
	`ifdef MEALY
	 seq_det_101_mealy u_seq_det_101_mealy
	`elsif MOORE
	 seq_det_101_moore u_seq_det_101_moore
	`endif
											(.rst(rst),
											 .clk(clk),
											 .x(x),
											 .y(y)      );

	//bus function
	reg [14:0] digit_seq;
	integer i;

	// Clock generation (50 MHz)
	always #5 clk = ~clk;

  initial begin
	rst=1'b0; clk=1'b0; x=1'b0;
	digit_seq = 15'b011_1010_0101_0100;
	#100 rst=1'b1;
	@(posedge clk);
	for (i=0; i<20;i=i+1) begin
		@(posedge clk);
		x=digit_seq[14];
		digit_seq=digit_seq<<1;
	end
	
  end
  
   // Monitoring statement to display signal values
  initial begin
    // Monitor relevant signals: clk, rst, x, cur_state, nxt_state, and y
    `ifdef MEALY
      $monitor("Time: %0t | x: %b | Mealy_y: %b | cur_state: %b | nxt_state: %b | ",
               $time, x, y, u_seq_det_101_mealy.cur_state, u_seq_det_101_mealy.nxt_state);
    `elsif MOORE
      $monitor("Time: %0t | x: %b | Moore_y: %b | cur_state: %b | nxt_state: %b | ",
               $time, x, y, u_seq_det_101_moore.cur_state, u_seq_det_101_moore.nxt_state);
    `endif
  end
  
  
  
  
endmodule
