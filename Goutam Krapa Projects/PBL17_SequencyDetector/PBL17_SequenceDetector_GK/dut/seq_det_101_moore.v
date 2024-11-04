module seq_det_101_moore (
    input rst,          // Asynchronous reset
    input clk,          // Clock signal
    input x,            // Input signal
    output reg y        // Output signal
);

parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011; // State definitions

reg [2:0] cur_state, nxt_state;

// State register
always @(posedge clk or negedge rst) begin
    if (!rst)
        cur_state <= S0;
    else
        cur_state <= nxt_state;
end

// Next state logic
always @(cur_state or x or rst) begin
    if (!rst) begin
        nxt_state <= S0;
    end else begin
        case (cur_state)
            S0: nxt_state <= (x) ? S1 : S0;
            S1: nxt_state <= (~x) ? S2 : S1;
            S2: nxt_state <= (x) ? S3 : S0;
            S3: nxt_state <= (~x) ? S2 : S1;
            default: nxt_state <= S0;
        endcase
    end
end

// Output logic (depends only on state)
always @(cur_state) begin
    case (cur_state)
        S3: y = 1;  // Output '1' when "101" sequence is completed in Moore FSM
        default: y = 0;
    endcase
end

endmodule
