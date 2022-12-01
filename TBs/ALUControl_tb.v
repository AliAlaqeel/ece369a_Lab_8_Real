`timescale 1ns / 1ps

/*
Test bench to test run the ALU Control
*/

module ALUControl_tb();

    reg [5:0] Opcode;
    reg [5:0] Funct;
    reg [4:0] rtReg;

    wire [4:0] ALU_op;

    // ALUControl u0(
    //     .Opcode(Opcode),
    //     .Funct(Funct),
    //     .rtReg(rtReg),
    //     .ALU_op(ALU_op)
    // );
    ALUControl instanceName(Opcode, Funct, rtReg, ALU_op);

    initial begin
        rtReg <= 0;
        Opcode <= 0;
        Funct <= 6'h27;
        #20

        Opcode <= 6'h1c;
        Funct <= 6'h02;
    end

endmodule