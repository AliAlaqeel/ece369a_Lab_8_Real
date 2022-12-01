`timescale 1ns / 1ps

/*
Branch Resolver, Resolves Branches in the Decode stage

Inputs: 
[32-bits] Register Data 1: Data of Reg 1
[32-bits] Register Data 2: Data of Reg 2
[32-bits] Instruction: Full Instruction
[32-bits] Program Count: Current Program Count

Outputs:
[32-bits] Jump offset
[1-bit] Jump Occurance
[1-bit] Branch Occurance
*/

module BranchResolver(regData1, regData2, instr, progCount, jOffset, branchOccurance, jumpOccurance);
    input signed [31:0] regData1;
    input signed [31:0] regData2;
    input [31:0] instr;
    input [31:0] progCount;
    
    output reg [31:0] jOffset;
    output reg branchOccurance;
    output reg jumpOccurance;

    initial begin
        jOffset <= 0;
        branchOccurance <= 0;
        jumpOccurance <= 0;
    end

    always@(*)begin
        //Checking Jumps
        case(instr[31:26])  //Check for opcode
            6'h02,
            6'h03:begin     //Jump, jal
                jumpOccurance <= 1;
                jOffset <= {progCount[31:28], instr[25:0], 2'b00};
            end
            6'h00: begin    //jr
                if(instr[5:0] == 'h08) begin
                    jumpOccurance <= 1;
                    jOffset <= regData1;
                end
                else begin
                    jumpOccurance <= 0;
                    jOffset <= 0;
                end
            end
            default:begin
                jumpOccurance <= 0;
                jOffset <= 0;
            end
        endcase

        //Checking Branches
        case(instr[31:26])
            6'h04:begin     //beq
                if(regData1 == regData2) branchOccurance <= 1;
                else branchOccurance <= 0;
            end

            6'h05:begin     //bne
                if(regData1 != regData2) branchOccurance <= 1;
                else branchOccurance <= 0;
            end

            6'h06:begin     //blez
                if(regData1 <= 0) branchOccurance <= 1;
                else branchOccurance <= 0;
            end

            6'h07:begin     //bgtz
                if(regData1 > 0) branchOccurance <= 1;
                else branchOccurance <= 0;
            end

            6'h01:begin     //bgez & bltz
                case(instr[20:16])  //check $rt
                    1:begin     //bgez
                        if(regData1 >= 0) branchOccurance <= 1;
                        else branchOccurance <= 0;
                    end

                    0:begin     //bltz
                        if(regData1 < 0) branchOccurance <= 1;
                        else branchOccurance <= 0;
                    end
                endcase
            end

            default:
                branchOccurance <= 0;
        endcase
    end

endmodule