module DM (
    input clk,               // clock signal
    input we,                // write enable signal
    input [7:0] addr,        // 8-bit address input
    input [31:0] din,        // 32-bit data input
    output [31:0] dout       // 32-bit data output
);

reg [31:0] ram[255:0]; // 32-bit wide memory with 8-bit address space

always @(posedge clk) begin
    if (we) begin
        ram[addr] <= din;   // Write operation
    end
end

assign dout = ram[addr];    // Read operation

endmodule
