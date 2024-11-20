module PC (
    input wire [31:0] addr,    // 32-bit address input
    input wire clk,            // clock signal
    input wire clr,            // clear signal
    output reg [31:0] data     // 32-bit data output
);

always @(posedge clk or posedge clr) begin
    if (clr) begin
        data <= 32'b0;          // Clear the data to 0 if clr is high
    end else begin
        data <= addr;           // Otherwise, update the data with the input address
    end
end

endmodule