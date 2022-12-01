`timescale 1ns / 1ps
/*
ALU Control

INPUTS:
Opcode - 6 bits
Funct - 6 bits
rt register - 5 bits

OUTPUTS:
ALUOperation - 5 bits
*/
module ALUControl(Opcode, Funct, ALU_op);

    input [5:0] Opcode;
    input [5:0] Funct;

    output reg [3:0] ALU_op;

    always@(*)begin
        case(Opcode)
            6'h00:begin     //Intructions whose opcode is 0x00
                case(Funct)
                    6'h20: ALU_op <= 0;     //Add
                    6'h22: ALU_op <= 1;     //Sub
                    6'h24: ALU_op <= 3;     //And
                    6'h25: ALU_op <= 4;     //or
                    6'h27: ALU_op <= 5;     //nor
                    6'h26: ALU_op <= 8;     //xor
                    6'h00: ALU_op <= 6;     //sll
                    6'h02: ALU_op <= 7;     //srl
                    6'h2A: ALU_op <= 9;     //slt
                endcase
            end

            6'h08: ALU_op <= 0;          //Addi

            6'h1C:begin
                case(Funct)
                    6'h02: ALU_op <= 2; //Mul, this is how we do it i guess
                endcase
            end

            6'h23: ALU_op <= 0;     //lw

            6'h2B: ALU_op <= 0;     //sw

            6'h28: ALU_op <= 0;     //sb

            6'h21: ALU_op <= 0;     //lh

            6'h20: ALU_op <= 0;     //lb

            6'h29: ALU_op <= 0;     //sh 

            6'h0C: ALU_op <= 3; //andi

            6'h0D: ALU_op <= 4; //ori

            6'h0E: ALU_op <= 8; //xori

            6'h0A: ALU_op <= 9; //slti
        endcase
    end

endmodule