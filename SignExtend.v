module SignExtend (
    input wire [15:0] imm,   // 16-bit immediate input
    output wire [31:0] imm_ext  // 32-bit sign-extended output
);

assign imm_ext = {{16{imm[15]}}, imm};

endmodule
