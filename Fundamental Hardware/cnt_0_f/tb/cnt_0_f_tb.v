module cnt_0_f_tb();

reg        rst;
reg        clk;
reg        en ;
wire [3:0] cnt;

cnt_0_f u_cnt_0_f (.rst(rst),
                   .clk(clk),
                   .en (en ),
                   .cnt(cnt));
always #5 clk=~clk;

initial begin
  rst=0;clk=0;en=0;
  repeat(1) @(negedge clk);
  rst=1;
  repeat(1) @(negedge clk);
  en=1;
  repeat(10) @(negedge clk);
  en=0;
  repeat(5)  @(negedge clk);
  en=1;
  repeat(10) @(negedge clk);
  rst=0;
  repeat(5)  @(negedge clk);
  rst=1;
end
//or//in class test bench
/* initial begin
        // Initial state
		rst=1'b0; clk=1'b0; en=1'b0;
        #10 rst=1'b1;
		@(posedge clk) en=1'b1;
		#100 rst=1'b0;//reset within counting
		#30 rst=1'b1;
		repeat(15) @(posedge clk) en=1'b0;
		repeat(10) @(posedge clk) en=1'b1;
		

        // uncomment if you want to Finish the simulation
        //$finish;
    end */

endmodule
