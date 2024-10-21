module counter_with_vld (
    input wire clk,        // Clock signal (rising edge)
    input wire rst,        // Asynchronous reset (active high)
    input wire en,      // Enable signal (active high)
    output reg [3:0] cnt,  // 4-bit counter output
    output reg vld         // Validation signal (mirrors cnt)
);

    // MUX logic for next counter value
    wire [3:0] nxt_cnt = (cnt == 4'h9) ? 4'h0 :  // Reset counter to 0 if cnt is 9
                         (en ? cnt + 4'h1 : cnt);  // Increment if en, else hold current value

    // Counter logic with reset
    always @(posedge clk , posedge rst) begin
        if (~rst) begin
            cnt <= 4'h0;  // Reset counter to 0 when reset is active
        end else begin
            cnt <= nxt_cnt;  // Update counter with next value
        end
    end

    // Validation signal logic
    wire nxt_vld = cnt;  // vld mirrors the value of cnt

    always @(posedge clk , posedge rst) begin
        if (~rst) begin
            vld <= 1'b0;  // Reset validation signal when reset is active
        end else begin
            vld <= nxt_vld;  // Update validation signal with next value
        end
    end

endmodule
