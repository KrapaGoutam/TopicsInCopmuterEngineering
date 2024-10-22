module tb_and_mux();
reg  a ;
reg  b ;
reg  c ;
reg  d ;
reg  sel ;
wire e ;

and_mux u_and_mux	 (.a (a),
				 .b (b),
				 .c (c),
				 .d (d),
				 .sel(sel),
				 .e (e));
						 

//bus function model 
initial begin
sel = 1 'b0; a = 1'b0; b = 1'b0; c = 1'b0; d = 1'b0;
#10; 
sel = 1 'b0; a = 1 'b1; b = 1 'b1; c = 1 'b0; d = 1 'b1;
#10; 
sel = 1 'b1; a = 1 'b1; b = 1 'b1; c = 1 'b0; d = 1 'b1;
#10; 
sel = 1 'b0; a = 1 'b0; b = 1 'b1; c = 1 'b1; d = 1 'b1;
#10; 
 sel = 1 'b1; a = 1 'b0; b = 1 'b1; c = 1 'b1; d = 1 'b1;

end
endmodule
