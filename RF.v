module RF (
    input wire [4:0] ra,       // 5-bit read address A
    input wire [4:0] rb,       // 5-bit read address B
    input wire [4:0] rw,       // 5-bit write address
    input wire [31:0] data,    // 32-bit data input
    input wire we,             // write enable signal
    input wire clr,            // clear signal
    input wire clk,            // clock signal
    output reg [31:0] qa,      // 32-bit read data A
    output reg [31:0] qb,      // 32-bit read data B
    output wire [31:0] r8,     // 32-bit read data for register 8
    output wire [31:0] r16,    // 32-bit read data for register 16
    output wire [31:0] r17,    // 32-bit read data for register 17
    output wire [31:0] r18     // 32-bit read data for register 18
);

// Register array declaration
reg [31:0] registers [0:31]; // 32 registers, each 32 bits wide

integer i;

always @(posedge clk or posedge clr) begin
    if (clr) begin
        // Clear all registers
        for (i = 0; i < 32; i = i + 1) begin
            registers[i] <= 32'b0;
        end
    end else if (we) begin
        // Write operation
        if (rw != 5'b00000) begin // Register 0 is often hardwired to 0 in many designs
            registers[rw] <= data;
        end
    end
end

always @(*) begin
    // Read operations
    qa = registers[ra];
    qb = registers[rb];
end

// Assign additional outputs
assign r8 = registers[8];
assign r16 = registers[16];
assign r17 = registers[17];
assign r18 = registers[18];

endmodule
