`timescale 1ns / 1ps
module f_d_register(
    Clk, 
    deactivate,
    f_currPC,
    d_currPC,
    f_instruction,
    d_instruction,
    f_writeback,
    d_writeback
);

    input Clk, deactivate;

    input [31:0] f_currPC;
    output reg [31:0] d_currPC;

    input [31:0] f_instruction;
    output reg [31:0] d_instruction;

    input f_writeback;
    output reg d_writeback;

    initial begin 
        d_currPC <= 0;
        d_instruction <= 0;
        d_writeback <= 0;
    end

    always@(posedge Clk)begin
        if(deactivate == 1)begin
        d_currPC <= 0;
        d_instruction <= 0;
        d_writeback <= 0;
        end
        else begin
        d_currPC <= f_currPC;
        d_instruction <= f_instruction;
        d_writeback <= f_writeback;
        end
    end

endmodule