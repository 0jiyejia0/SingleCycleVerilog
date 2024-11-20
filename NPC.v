module NPC (
    input wire [1:0] npcctr,       // 2-bit next PC control signal
    input wire [31:0] pc,          // 32-bit current PC
    input wire [25:0] addr,        // 26-bit address (for jump)
    input wire [15:0] offset,      // 16-bit offset (for branch)
    output reg [31:0] npc          // 32-bit next PC
);

always @(*) begin
    case(npcctr)
        2'b00: npc = pc + 4;                                     // Sequential execution
        2'b01: npc = pc + 4 + {{14{offset[15]}}, offset, 2'b00};  // Branch (sign-extended and shifted)
        2'b10: npc = {pc[31:28], addr, 2'b00};                    // Jump
        default: npc = pc + 4;                                    // Default to sequential execution
    endcase
end

endmodule
