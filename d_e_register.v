`timescale 1ns / 1ps
module d_e_register(
    Clk,
    d_currPC,
    e_currPC,
    d_instruction,
    e_instruction,
    d_data1,
    e_data1,
    d_data2,
    e_data2,
    d_signExtImm,
    e_signExtImm,
    d_writeBack,
    e_writeBack,
    d_writeReg,
    e_writeReg
);

    input Clk;

    input [31:0] d_currPC;
    output reg [31:0] e_currPC;

    input [31:0] d_instruction;
    output reg [31:0] e_instruction;

    input [31:0] d_data1;
    output reg [31:0] e_data1;

    input [31:0] d_data2;
    output reg [31:0] e_data2;

    input [31:0] d_signExtImm;
    output reg [31:0] e_signExtImm;

    input d_writeBack;
    output reg e_writeBack;

    input [4:0] d_writeReg;
    output reg [4:0] e_writeReg;

    always@(posedge Clk)begin
        e_currPC <= d_currPC;
        e_instruction <= d_instruction;
        e_data1 <= d_data1;
        e_data2 <= d_data2;
        e_signExtImm <= d_signExtImm;
        e_writeBack <= d_writeBack;
        e_writeReg <= d_writeReg;
    end
    
endmodule