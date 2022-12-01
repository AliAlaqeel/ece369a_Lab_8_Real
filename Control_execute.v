`timescale 1ns / 1ps

module Control_execute(instruction, aluSrc);

    input [31:0] instruction;
    output reg aluSrc;


    always@(*)begin
        case(instruction[31:26])    //Opcode
            6'h08,  //addi
            6'h23,  //lw
            6'h2B,  //sw
            6'h20,  //lb
            6'h28,  //sb
            6'h21,  //lh
            6'h29,  //sh
            6'h0C,  //andi
            6'h0D,  //ori
            6'h0E,  //xori
            6'h0A:begin  //slti
                aluSrc <= 1;
            end
            default:begin
                aluSrc <= 0;
            end
        endcase
    end

endmodule