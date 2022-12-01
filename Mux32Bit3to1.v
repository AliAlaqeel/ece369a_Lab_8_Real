`timescale 1ns / 1ps

///////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

module Mux32Bit3To1(out, inA, inB, inC, sel);

    output reg [31:0] out;
    
    input [31:0] inA;
    input [31:0] inB;
    input [31:0] inC;
    input [1:0] sel;

    /* Fill in the implementation here ... */ 
    always@(*)begin
        if(sel == 0) out <= inA;
        else if(sel == 1) out <= inB;
        else out <= inC; 
    end
endmodule
