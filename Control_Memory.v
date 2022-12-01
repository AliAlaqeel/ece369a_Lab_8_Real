`timescale 1ns / 1ps

module Control_Memory(Instruction,MemRead,MemWrite);
input [31:0] Instruction;
output reg MemRead;
output reg MemWrite;

initial begin
    MemRead = 0;
    MemWrite = 0;
end

always @(*)begin
    case(Instruction[31:26])
        6'h23,//Lw
        6'h21,//load half
        6'h20:begin//Load byte
            MemRead = 1;
            MemWrite = 0;
        end
        6'h2B,
        6'h28,
        6'h29:begin
            MemWrite = 1;
            MemRead = 0;
        end
        default:begin
            MemRead = 0;
            MemWrite = 0;
        end
    endcase
    
end
endmodule