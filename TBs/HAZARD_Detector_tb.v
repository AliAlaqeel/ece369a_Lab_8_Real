`timescale 1ns / 1ps

module HAZARD_Detector_tb();
    reg [4:0] regToRead1;
    reg [4:0] regToRead2;

    reg [4:0] decode_dstReg;
    reg [4:0] execute_dstReg;

    reg branchOccurance, jumpOccurance;

    wire disablePipelineReg;
    wire pausePC;

    HAZARD_Detector h1(
        .regToRead1(regToRead1), 
        .regToRead2(regToRead2), 
        .decode_dstReg(decode_dstReg), 
        .execute_dstReg(execute_dstReg), 
        .branchOccurance(branchOccurance), 
        .jumpOccurance(jumpOccurance), 
        .disable_f_d_pipe_reg(disablePipelineReg), 
        .pausePC(pausePC)
    );

    initial begin
        //Setup
        regToRead1 <= 0;
        regToRead2 <= 0;
        decode_dstReg <= 0;
        execute_dstReg <= 0;
        branchOccurance <= 0;
        jumpOccurance <= 0;
        
        //Test Branch
        #100
        branchOccurance <= 1;
        
        //Test Jump
        #100
        branchOccurance <= 0;
        jumpOccurance <= 1;

        //Test non-dependent Regs
        #100
        jumpOccurance <= 0;
        regToRead1 <= 5'd11;
        regToRead2 <= 5'd15;
        #100
        decode_dstReg <= 5'd18;
        execute_dstReg <= 5'd25;

        //Test Dependant Regs
        #100
        decode_dstReg <= 5'd11;

        #100
        decode_dstReg <= 5'd8;
        execute_dstReg <= 5'd15;
    end

endmodule