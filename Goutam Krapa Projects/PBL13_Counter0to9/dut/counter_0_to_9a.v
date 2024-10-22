module counter_0_to_9 (
    input wire clk,        // clock signal
    input wire rst,        // reset
    input wire en,         // enable signal which is active when high
    output reg [3:0] cnt,  // 4-bit counter output
    output reg vld         
);

    // MUX logic for next counter value
    wire [3:0] nxt_cnt = (cnt == 4'h9) ? 4'h0 :  // reset counter to 4'h0 if cnt is 4'h9
                         (en ? cnt + 4'h1 : cnt);  // secondary MUX to increment if en, else hold current value

    // Counter logic with reset
    always @(posedge clk or negedge rst) begin
        if (~rst) begin
            cnt <= 4'h0;  // reset counter to 0 when reset is active that is rst=1
        end else begin
            cnt <= nxt_cnt;  // update counter with next value as next counter
        end
    end

    // Validation signal logic
    always @(posedge clk or negedge rst) begin
        if (~rst) begin
            vld <= 1'b0;  // Reset validation signal when reset is active
        end else begin
            vld <= cnt;  // vld mirrors the value of cnt
        end
    end

endmodule
