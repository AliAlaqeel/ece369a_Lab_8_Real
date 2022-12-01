`timescale 1ns / 1ps
module e_m_register(
    Clk,
    e_currPC,
    m_currPC,
    e_instruction,
    m_instruction,
    e_writeBack,
    m_writeBack,
    e_writeReg,
    m_writeReg,
    e_ALUresult,
    m_ALUresult,
    e_data2,
    m_data2
);

    input Clk;

    input [31:0] e_currPC;
    output reg [31:0] m_currPC;

    input [31:0] e_instruction;
    output reg [31:0] m_instruction;

    input e_writeBack;
    output reg m_writeBack;

    input [4:0] e_writeReg;
    output reg [4:0] m_writeReg;

    input [31:0] e_ALUresult;
    output reg [31:0] m_ALUresult;

    input [31:0] e_data2;
    output reg [31:0] m_data2;

    always@(posedge Clk)begin
        m_currPC <= e_currPC;
        m_instruction <= e_instruction;
        m_data2 <= e_data2;
        m_writeBack <= e_writeBack;
        m_writeReg <= e_writeReg;
        m_ALUresult <= e_ALUresult;
    end
    
endmodule