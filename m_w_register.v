`timescale 1ns / 1ps
module m_w_register(
    Clk,
    m_currPC,
    w_currPC,
    m_instruction,
    w_instruction,
    m_writeBack,
    w_writeBack,
    m_writeReg,
    w_writeReg,
    m_ALUresult,
    w_ALUresult,
    m_memData,
    w_memData
);

    input Clk;

    input [31:0] m_currPC;
    output reg [31:0] w_currPC;

    input [31:0] m_instruction;
    output reg [31:0] w_instruction;

    input m_writeBack;
    output reg w_writeBack;

    input [4:0] m_writeReg;
    output reg [4:0] w_writeReg;

    input [31:0] m_ALUresult;
    output reg [31:0] w_ALUresult;

    input [31:0] m_memData;
    output reg [31:0] w_memData;

    always@(posedge Clk)begin
        w_currPC <= m_currPC;
        w_instruction <= m_instruction;
        w_writeBack <= m_writeBack;
        w_writeReg <= m_writeReg;
        w_ALUresult <= m_ALUresult;
        w_memData <= m_memData;
    end

endmodule