module seq_det_101_mealy  (
    input      rst,     // Asynchronous reset
    input      clk,     // Clock signal
    input      x,       // Input signal
    output reg y        // Output signal
);

parameter SIZE = 2;
parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;

reg [SIZE-1:0] cur_state; // Current state register
reg [SIZE-1:0] nxt_state; // Next state register

//------------------State Register -----------------
always @ (posedge clk , negedge rst) begin
    if (~rst)
        cur_state <= S0;
    else
        cur_state <= nxt_state;
end

//-------Next State Combinational Circuit-----------
always @ (cur_state , x , rst) begin
    if (~rst) begin
        nxt_state <= S0;
    end else begin
        case(cur_state)
            S0: if(x) nxt_state <= S1; else nxt_state <= S0;
            S1: if(~x) nxt_state <= S2; else nxt_state <= S1;
            S2: if(x) nxt_state <= S1; else nxt_state <= S0;
            default: nxt_state <= S0;
        endcase
    end
end

//----------Output Combinational Circuit--------------

assign y = (cur_state==S2) & x;

//or

/* always @ (cur_state or x or rst) begin
    if (~rst) begin
        y <= 0;
    end else begin
        case(cur_state)
            S2: y <= x; // Output 1 when transitioning from S2 to S1 with x=1 (101 detected)
            default: y <= 1'b0;
        endcase
    end
end */

//or

/* always @ (cur_state , x , rst) begin
    if (~rst) begin
        y <= 0;
    end else begin
        case(cur_state)
			S0: if(x) y <= 1'b0; else y<= 1'b0;
			S1: if(x) y <= 1'b0; else y<= 1'b0;
            S2: if(x) y <= 1'b1; else y<= 1'b0;
            default: y <= 1'b0;
        endcase
    end
end */

endmodule
