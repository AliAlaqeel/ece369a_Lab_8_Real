`timescale 1ns / 1ps
/*
Inputs:
[5 bits] Register To Read 1
[5 bits] Register To Read 2
[5 bits] decode_DstReg
[5 bits] execute_DstReg
[1 bit] branchOccurance
[1 bit] jumpOccurance

Outputs:
[1 bit] disable_f_d_pipe_reg
[1 bit] pause_pc

Functionality:
Detects if there are Hazards and delays pipeline for them

    Data Hazards: Delays dependent instructions by pausing PC and disabling f_d pipeline register
    Branch Hazards: If a jump or branch is detected, disables the f_d register once (in effect flushing untaken branch (branches assumed not taken, even jumps))

*/
module HAZARD_Detector(
        regToRead1, 
        regToRead2, 
        decode_dstReg, 
        execute_dstReg, 
        branchOccurance, 
        jumpOccurance, 
        disable_f_d_pipe_reg, 
        pausePC,
        decode_writeBack,
        execute_writeBack,
        memory_dstReg,
        write_dstReg,
        memory_writeBack,
        write_writeBack
    );

    input [4:0] regToRead1;
    input [4:0] regToRead2;

    input [4:0] decode_dstReg;
    input [4:0] execute_dstReg;
    input [4:0] memory_dstReg;
    input [4:0] write_dstReg;
    input decode_writeBack;
    input execute_writeBack;
    input memory_writeBack;
    input write_writeBack;
    input branchOccurance, jumpOccurance;

    output reg disable_f_d_pipe_reg, pausePC;

    initial begin
        disable_f_d_pipe_reg <= 0;
        pausePC <= 0;
    end

    always@(*)begin

        if(    //Check for Jump/Branch Hazards 
            (branchOccurance == 1)
            ||
            (jumpOccurance == 1)
        )begin
            disable_f_d_pipe_reg <= 1;
            pausePC <= 0;
        end

        else if( //Check for Data Hazards (One of the Destination Registers are a Register To Read)
            ((decode_dstReg == regToRead1) && (regToRead1 != 0) && (decode_writeBack == 1))
            ||
            ((execute_dstReg == regToRead1) && (regToRead1 != 0) && (execute_writeBack == 1))
            ||
            ((decode_dstReg == regToRead2) && (regToRead2 != 0) && (decode_writeBack == 1))
            ||
            ((execute_dstReg == regToRead2) && (regToRead2 != 0) && (execute_writeBack == 1))
            ||
            ((memory_dstReg == regToRead1) && (regToRead1 != 0) && (memory_writeBack == 1))
            ||
            ((write_dstReg == regToRead1) && (regToRead1 != 0) && (write_writeBack == 1))
            ||
            ((memory_dstReg == regToRead2) && (regToRead2 != 0) && (memory_writeBack == 1))
            ||
            ((write_dstReg == regToRead2) && (regToRead2 != 0) && (write_writeBack == 1))
        )begin
            disable_f_d_pipe_reg <= 1;
            pausePC <= 1;
        end
        
        else begin
            disable_f_d_pipe_reg <= 0;
            pausePC <= 0;
        end

    end

endmodule