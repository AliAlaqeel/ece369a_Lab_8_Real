`timescale 1ns / 1ps

/*
To Test the Branch Resolver
*/

module BranchResolver_tb(); 
    
    reg [31:0] data1;
    reg [31:0] data2;
    reg [31:0] instruction;
    reg [31:0] programCount;
    wire [31:0] jumpOffset;
    wire branchBool;
    wire jumpBool;

    BranchResolver branchRes(
        .regData1(data1), 
        .regData2(data2), 
        .instr(instruction), 
        .progCount(programCount), 
        .jOffset(jumpOffset), 
        .branchOccurance(branchBool), 
        .jumpOccurance(jumpBool)
    );

    initial begin
        programCount <= 'h100;

        //Testing bgez
        instruction <= 'h0501fffb;
        data1 <= 1;
        data2 <= 10;
        #10
        data1 <= 0;
        #10
        data1 <= -1;

        //Testing beq
        #10
        instruction <= 'h11090007;
        data1 <= 1;
        data2 <= 1;
        #10
        data2 <= -1;

        //Testing bne
        #10
        instruction <= 'h1509fff9;
        data1 <= 1;
        data2 <= 1;
        #10
        data2 <= 3;

        //Testing bgtz
        #10
        instruction <= 'h1d000005;
        data1 <= 1;
        #10
        data1 <= 0;
        #10
        data1 <= -1;

        //blez
        #10
        instruction <= 'h1900fff7;
        data1 <= 1;
        #10
        data1 <= 0;
        #10
        data1 <= -1;

        //bltz
        #10
        instruction <= 'h05000003;
        data1 <= 1;
        #10
        data1 <= 0;
        #10
        data1 <= -1;

        //jump
        #10
        instruction <= 'h08000000;

        //jal
        #10
        instruction <= 'h0c00000d;

        //jr
        #10
        instruction <= 'h03e00008;
        data1 <= 123456789;
    end

endmodule