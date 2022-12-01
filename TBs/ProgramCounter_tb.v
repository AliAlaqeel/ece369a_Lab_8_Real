`timescale 1ns / 1ps

module ProgramCounter_tb();
    //reg [31:0] currPC;
    reg clk, rst;
    reg pause;
    wire [31:0] pcResult;
//    wire addResult;
    
    ProgramCounter programCountinator5000(
        .Address( pcResult + 4 ), 
        .PCResult(pcResult), 
        .Reset(rst), 
        .Clk(clk), 
        .Pause(pause)
    );
    
//     PCAdder adder(
//         .PCResult(pcResult), 
//         .PCAddResult(addResult)
//     );
    
    initial begin
        clk <= 0;
        forever #25 clk <= ~clk;
    end

    initial begin
        rst <= 0;
        pause <= 0;
        #100
        pause <= 1;
        #50
        pause <= 0;
    end
endmodule