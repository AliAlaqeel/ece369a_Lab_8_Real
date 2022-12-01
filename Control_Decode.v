`timescale 1ns / 1ps

module Control_Decode(instruction, branchOccurance, jumpOccurance, branchType, writeRegChoice);

    input [31:0] instruction;
    input branchOccurance, jumpOccurance;

    output reg [1:0] branchType;
    output reg [1:0] writeRegChoice;
    

    always@(*)begin
        //Check for writeRegChoice (AKA RegDst)
        case(instruction[31:26])
            6'h00,
            6'h1c:  //add, sub, and, or, nor, xor, sll, srl, slt, mul
                writeRegChoice <= 1;

            6'h03:
                writeRegChoice <= 2;

            default:
                writeRegChoice <= 0;
        endcase

        //Check for BranchType
        if(jumpOccurance == 1)  branchType <= 2;    // jumps (j, jal, jr)
        else if (branchOccurance == 1) branchType <= 1;     //Valid branches
        else branchType <= 0;   //Non-branches

        
    end

endmodule