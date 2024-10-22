module counter_0_to_9 (
    input wire clk,        // Clock signal (rising edge)
    input wire rst,        // Asynchronous reset (active low)
    input wire en,         // Enable signal (active high)
    output reg [3:0] cnt,  // 4-bit counter output
    output reg vld         // Validation signal (mirrors cnt)
);

    // MUX logic for next counter value
    wire [3:0] nxt_cnt = (cnt == 4'h9) ? 4'h0 :  // Reset counter to 0 if cnt is 9
                         (en ? cnt + 4'h1 : cnt);  // Increment if en, else hold current value

    // Counter logic with reset
    always @(posedge clk or negedge rst) begin
        if (~rst) begin
            cnt <= 4'h0;  // Reset counter to 0 when reset is active (active low)
        end else begin
            cnt <= nxt_cnt;  // Update counter with next value
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
