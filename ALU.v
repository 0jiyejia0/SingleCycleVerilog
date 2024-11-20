module ALU (
    input wire [31:0] a,    // 32-bit input A
    input wire [31:0] b,    // 32-bit input B
    input wire [1:0] op,    // 2-bit operation code
    output reg zero,        // zero flag
    output reg [31:0] out,  // 32-bit output
    output reg of           // overflow flag
);

always @(*) begin
    zero = 0;
    of = 0;
    case(op)
        2'b00: begin // ADD
            out = a + b;
            of = ((a[31] & b[31] & ~out[31]) | (~a[31] & ~b[31] & out[31])); // overflow detection
        end
        2'b01: begin // SUB
            out = a - b;
            of = ((a[31] & ~b[31] & ~out[31]) | (~a[31] & b[31] & out[31])); // overflow detection
        end
        2'b10: begin // AND
            out = a & b;
        end
        2'b11: begin // OR
            out = a | b;
        end
    endcase
    zero = (out == 0); // set zero flag if result is zero
end

endmodule
