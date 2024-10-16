module and_or(input  a ,
			  input  b ,
			  input  c ,
			  input  d ,

			  output e );
			  
assign e=(a&b)|(c&d);
//wire e;
//wire e = (a&b) | (c&d);
//assign f = en ? e : 1'bz;
//assign f = en ? (a&b)|(c&d) : 1'bz;

//always @(en,a,b,c,d) begin
//  f = en ? (a&b)|(c&d) : 1'bz;
//end
endmodule
