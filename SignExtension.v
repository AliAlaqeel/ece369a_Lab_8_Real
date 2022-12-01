`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - SignExtension.v
// Description - Sign extension module.
////////////////////////////////////////////////////////////////////////////////
module SignExtension(in, out);

    /* A 16-Bit input word */
    input [15:0] in;
    
    /* A 32-Bit output word */
    output reg [31:0] out;
    
    always @(*)begin
        if(in[15]==1)begin
            out<={16'hFFFF,in[15:0]};
        end
        else if(in[15]==0)begin
            out<={16'b0,in[15:0]};
        end  
    end
endmodule
