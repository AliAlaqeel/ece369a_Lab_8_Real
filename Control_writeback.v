`timescale 1ns / 1ps

module Control_writeback(instruction, memToReg, writeBack);

input [31:0] instruction;
output reg [1:0] memToReg;
output reg writeBack;

initial begin
    memToReg <= 1;
    writeBack <= 0;
end

always@(*)begin

    case(instruction[31:26])    //Checking for memToReg
        6'h23,
        6'h21,
        6'h20:
            memToReg <= 0;

        6'h03:
            memToReg <= 2;

        default:
            memToReg <= 1;
    endcase

    // case(instruction[31:26])    //Checking for writeback
    //     6'h00:begin  //Checking for R-types
    //         case(instruction[5:0])
    //             6'h20,  //add
    //             6'h22,  //sub
    //             6'h24,  //and
    //             6'h25,  //or
    //             6'h26,  //xor
    //             6'h27,  //nor
    //             6'h00,  //sll
    //             6'h02,  //srl
    //             6'h2A:  //slt
    //                 writeBack <= 1;
    //             default:
    //                 writeBack <= 0;
    //         endcase
    //     end

    //     6'h1c:begin //checking for mul
    //         if(instruction[5:0] == 6'h02) writeBack <= 1;
    //         else writeBack <= 0;
    //     end

    //     6'h08,  //addi
    //     6'h23,  //lw
    //     6'h21,  //lh
    //     6'h20,  //lb
    //     6'h0C,  //andi
    //     6'h0D,  //ori
    //     6'h0E,  //xori
    //     6'h0A,  //slti
    //     6'h03:  //jal
    //         writeBack <= 1;
    //     default:
    //         writeBack <= 0;
    // endcase

end

endmodule