module CU (
    input wire [5:0] func,      // 6-bit function code
    input wire [5:0] op,        // 6-bit opcode
    input wire zero,            // zero flag
    output reg regwrite,        // register write signal
    output reg [1:0] aluctr,    // ALU control signal
    output reg alusrc,          // ALU source signal
    output reg regdst,          // register destination signal
    output reg memwrite,        // memory write signal
    output reg memtoreg,        // memory to register signal
    output reg [1:0] npcctr     // next PC control signal
);

always @(*) begin
    // Default values
    regwrite = 0;
    aluctr = 2'b00;
    alusrc = 0;
    regdst = 0;
    memwrite = 0;
    memtoreg = 0;
    npcctr = 2'b00;

    case(op)
        6'b000000: begin // R-type
            regwrite = 1;
            regdst = 1;
            case(func)
                6'b100000: aluctr = 2'b00; // add
                6'b100010: aluctr = 2'b01; // sub
                6'b100100: aluctr = 2'b10; // and
                6'b100101: aluctr = 2'b11; // or
                // Add more R-type instructions as needed
            endcase
        end
        6'b001101: begin // ori
            regwrite = 1;
            alusrc = 1;
            aluctr = 2'b11;
        end
        6'b100011: begin // lw
            regwrite = 1;
            alusrc = 1;
            memtoreg = 1;
            aluctr = 2'b10;
        end
        6'b101011: begin // sw
            alusrc = 1;
            memwrite = 1;
            aluctr = 2'b10;
        end
        6'b000100: begin // beq
            aluctr = 2'b01;
            npcctr = zero ? 2'b01 : 2'b00;
        end
        6'b000010: begin // jump
            npcctr = 2'b10;
        end
        6'b001000: begin // addi
            regwrite = 1;
            alusrc = 1;
            aluctr = 2'b00;
        end
        // Add more instructions as needed
    endcase
end

endmodule
