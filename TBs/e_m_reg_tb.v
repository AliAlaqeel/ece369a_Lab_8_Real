`timescale 1ns / 1ps
module e_m_reg_tb();
    reg clk, writebackIn;
    reg [31:0] currPcIn, instrIn, aluResultIn, dataIn;
    reg [4:0] writeRegIn;
    wire [31:0] currPcOut, instrOut, aluResultOut, dataOut;
    wire writebackOut;
    wire [4:0] writeRegOut;

    e_m_register register_but_with_a_j(
    .Clk(clk),
    .e_currPC(currPcIn),
    .m_currPC(currPcOut),
    .e_instruction(instrIn),
    .m_instruction(instrOut),
    .e_writeBack(writebackIn),
    .m_writeBack(writebackOut),
    .e_writeReg(writeRegIn),
    .m_writeReg(writeRegOut),
    .e_ALUresult(aluResultIn),
    .m_ALUresult(aluResultOut),
    .e_data2(dataIn),
    .m_data2(dataOut)
    );

    initial begin
        clk <= 1;
        forever #20 clk <= ~clk;
    end

    initial begin
        currPcIn <= 0;
        instrIn <= 0;
        writebackIn <= 0;
        writeRegIn <= 0;
        aluResultIn <= 0;
        dataIn<= 0;
    end

endmodule