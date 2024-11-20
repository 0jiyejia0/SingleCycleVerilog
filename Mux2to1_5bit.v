module Mux2to1_5bit (
    input wire [4:0] in0,    // 5-bit input 0
    input wire [4:0] in1,    // 5-bit input 1
    input wire sel,          // select signal
    output wire [4:0] out    // 5-bit output
);

assign out = sel ? in1 : in0;

endmodule