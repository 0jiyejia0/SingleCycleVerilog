module Mux2to1_32bit (
    input wire [31:0] in0,   // 32-bit input 0
    input wire [31:0] in1,   // 32-bit input 1
    input wire sel,          // select signal
    output wire [31:0] out   // 32-bit output
);

assign out = sel ? in1 : in0;

endmodule
