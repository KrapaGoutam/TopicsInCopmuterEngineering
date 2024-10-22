module counter_0_to_9 (
    input wire clk,        // Clock signal (rising edge)
    input wire rst,        // Asynchronous reset (active low)
    input wire en,         // Enable signal (active high)
    output reg [3:0] cnt   // 4-bit counter output
);

    always @(posedge clk , negedge rst) begin // always @(posedge clk or negedge rst) begin
        if (~rst) begin
            cnt <= 4'h0;  // Reset counter to 0 when rst is 0 
        end else if (en) begin
            if (cnt == 4'h9) begin
                cnt <= 4'h0;  // Reset to 0 after reaching 9
            end else begin
                cnt <= cnt + 1;  // Increment counter
            end
        end
    end
endmodule
