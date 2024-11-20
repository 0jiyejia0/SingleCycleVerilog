module CPU (
    input wire clk,         // clock signal
    input wire clr,         // clear signal
    output wire [31:0] r8,  // 32-bit output for register 8
    output wire [31:0] r16, // 32-bit output for register 16
    output wire [31:0] r17, // 32-bit output for register 17
    output wire [31:0] r18, // 32-bit output for register 18
    output wire [31:0] pc   // 32-bit output for program counter
);

// Wires and registers for interconnecting the components
wire [31:0] npc, instruction, alu_result, mem_data, write_data, alu_b;
wire [31:0] qa, qb, sign_ext_imm;
wire [4:0] rs, rt, rd, shamt, rw;
wire [5:0] op, func;
wire [15:0] imm;
wire [25:0] adr;
wire [1:0] aluctr, npcctr;
wire alusrc, regdst, memwrite, memtoreg, regwrite, zero, of;

// Program Counter (PC)
PC pc_reg (
    .addr(npc),
    .clk(clk),
    .clr(clr),
    .data(pc)
);

// Instruction Memory (IM)
IM instruction_memory (
    .addr(pc[7:0]),
    .out(instruction)
);

// Decode instruction
assign op = instruction[31:26];
assign rs = instruction[25:21];
assign rt = instruction[20:16];
assign rd = instruction[15:11];
assign shamt = instruction[10:6];
assign func = instruction[5:0];
assign imm = instruction[15:0];
assign adr = instruction[25:0];

// Register File (RF)
RF register_file (
    .ra(rs),
    .rb(rt),
    .rw(rw),
    .data(write_data),
    .we(regwrite),
    .clr(clr),
    .clk(clk),
    .qa(qa),
    .qb(qb),
    .r8(r8),
    .r16(r16),
    .r17(r17),
    .r18(r18)
);

// ALU
ALU alu (
    .a(qa),
    .b(alu_b),
    .op(aluctr),
    .zero(zero),
    .out(alu_result),
    .of(of)
);

// Data Memory (DM)
DM data_memory (
    .clk(clk),
    .we(memwrite),
    .addr(alu_result[7:0]),
    .din(qb),
    .dout(mem_data)
);

// Sign-extend the immediate value
SignExtend sign_extend (
    .imm(imm),
    .imm_ext(sign_ext_imm)
);

// Next PC logic (NPC)
NPC next_pc (
    .npcctr(npcctr),
    .pc(pc),
    .addr(adr),
    .offset(imm),
    .npc(npc)
);

// Control Unit (CU)
CU control_unit (
    .func(func),
    .op(op),
    .zero(zero),
    .regwrite(regwrite),
    .aluctr(aluctr),
    .alusrc(alusrc),
    .regdst(regdst),
    .memwrite(memwrite),
    .memtoreg(memtoreg),
    .npcctr(npcctr)
);

// Mux for register write address
Mux2to1_5bit reg_dst_mux (
    .in0(rt),
    .in1(rd),
    .sel(regdst),
    .out(rw)
);

// Mux for ALU input source
Mux2to1_32bit alu_src_mux (
    .in0(qb),
    .in1(sign_ext_imm),
    .sel(alusrc),
    .out(alu_b)
);

// Mux for write data to register file
Mux2to1_32bit mem_to_reg_mux (
    .in0(alu_result),
    .in1(mem_data),
    .sel(memtoreg),
    .out(write_data)
);

endmodule