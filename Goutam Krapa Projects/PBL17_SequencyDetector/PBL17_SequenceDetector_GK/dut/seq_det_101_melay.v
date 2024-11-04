module seq_det_101_mealy (
    input rst,          // Asynchronous reset
    input clk,          // Clock signal
    input x,            // Input signal
    output reg y        // Output signal
);

parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10; // State definitions

reg [1:0] cur_state, nxt_state;

//------------------State Register -----------------
always @(posedge clk or negedge rst) begin
    if (~rst)
        cur_state <= S0;
    else
        cur_state <= nxt_state;
end

//---- Combinational Circuit for the Next State ---
//The missing else in each case statement represents the scenario where the next state stays the same as the current state..

always @(cur_state , x , rst) begin
    if (!rst) begin
        nxt_state <= S0;
        y <= 0;
    end else begin
        case (cur_state)
            S0: begin
                if (x) begin
                    nxt_state <= S1;
                    y <= 0;
                end else begin
                    nxt_state <= S0;
                    y <= 0;
                end
            end
            S1: begin
                if (~x) begin
                    nxt_state <= S2;
                    y <= 0;
                end else begin
                    nxt_state <= S1;
                    y <= 0;
                end
            end
            S2: begin
                if (x) begin
                    nxt_state <= S1;
                    y <= 1;  // Output '1' when "101" sequence is detected
                end else begin
                    nxt_state <= S0;
                    y <= 0;
                end
            end
            default: begin
                nxt_state <= S0;
                y <= 0;
            end
        endcase
    end
end

endmodule
