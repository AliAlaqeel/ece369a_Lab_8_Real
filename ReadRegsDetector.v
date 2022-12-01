`timescale 1ns / 1ps
/*
Inputs:
[32 bits] Instruction

Outputs:
[5 bits] Register To Read 1
[5 bits] Register To Read 2

Functionality:
Takes in Instruction, then gives what registers will be read per instruction ($rs for most instructions, and $rt for some), otherwise sets them to zero
*/
module ReadRegsDetector(instruction, regToRead1, regToRead2);
    input [31:0] instruction;
    output reg [4:0] regToRead1;
    output reg [4:0] regToRead2;

    initial begin
        regToRead1 <= 0;
        regToRead2 <= 0;
    end

    always@(*)begin
        if(instruction == 0)begin   //edge case for nop
            regToRead1 <= 0;
            regToRead2 <= 0;
        end

        else begin
            //Checking for the $rs field (Reg to Read 1)
            case(instruction[31:26])
                6'h02,  //j
                6'h03:  //jal
                    regToRead1 <= 0;
                default:        //Justification: Most instructions read the $rs field, except j & jal
                    regToRead1 <= instruction[25:21];
            endcase

            //Checking for the $rt field (Reg to Read 2)
            case(instruction[31:26])
                6'h00:begin
                    case(instruction[5:0])
                        6'h20,  //add
                        6'h22,  //sub
                        6'h24,  //and
                        6'h25,  //or
                        6'h26,  //xor
                        6'h27,  //nor
                        6'h00,  //sll
                        6'h02,  //srl
                        6'h2A:  //slt
                            regToRead2 <= instruction[20:16];
                        default:
                            regToRead2 <= 0;
                    endcase
                end

                6'h1c:begin //checking for mul
                    if(instruction[5:0] == 6'h02) regToRead2 <= instruction[20:16];
                    else regToRead2 <= 0;
                end

                6'h2b,  //sw
                6'h29,  //sh
                6'h28,  //sb
                6'h04,  //beq
                6'h05:  //bne
                    regToRead2 <= instruction[20:16];
                default:
                    regToRead2 <= 0;
            endcase

            //15 Instructions read the $rt register, 8 Instructions write to it
        end
    end
endmodule