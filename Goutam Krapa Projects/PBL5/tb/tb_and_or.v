module tb_and_or();
reg  aa ;
reg  bb ;
reg  cc ;
reg  dd ;
wire ee ;

and_or u_and_or	 (.a (aa ),
				 .b (bb ),
				 .c (cc ),
				 .d (dd ),
				 .e (ee ));
						 

//bus function model 
integer i;

initial begin

  for (i=0;i<16;i=i+1) begin
    {aa,bb,cc,dd}=i[3:0];
	//because i:0-15 and leading to 0-2^32-1
    #10;
  end
end
endmodule
