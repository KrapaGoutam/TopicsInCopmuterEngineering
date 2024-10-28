module seq_det_101_moore (
    input      rst,     // Asynchronous reset
    input      clk,     // Clock signal
    input      x,       // Input signal
    output reg y        // Output signal
);

parameter SIZE = 2;
parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;

reg [SIZE-1:0] cur_state; // Current state register
reg [SIZE-1:0] nxt_state; // Next state register

//------------------State Register -----------------
always @ (posedge clk or negedge rst) begin
    if (~rst)
        cur_state <= S0;
    else
        cur_state <= nxt_state;
end

//-------Next State Combinational Circuit-----------
always @ (cur_state or x or rst) begin
    if (~rst) begin
        nxt_state <= S0;
    end else begin
        case(cur_state)
            S0: if(x) nxt_state <= S1; else nxt_state <= S0;
            S1: if(~x) nxt_state <= S2; else nxt_state <= S1;
            S2: if(x) nxt_state <= S3; else nxt_state <= S0;
            S3: if(x) nxt_state <= S1; else nxt_state <= S2;
            default: nxt_state <= S0;
        endcase
    end
end

//----------Output Combinational Circuit--------------
always @ (cur_state or rst) begin
    if (~rst) begin
        y <= 0;
    end else begin
        case(cur_state)
            S3: y <= 1; // Output 1 when in state S3 (sequence "101" detected)
            default: y <= 0;
        endcase
    end
end

endmodule
