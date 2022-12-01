`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - ALU32Bit_tb.v
// Description - Test the 'ALU32Bit.v' module.
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit_tb(); 

	reg [4:0] ALUControl;   // control bits for ALU operation
	reg [31:0] A, B;	        // inputs

	wire [31:0] ALUResult;	// answer
	wire Zero;	        // Zero=1 if ALUResult == 0

    ALU32Bit u0(
        .ALUControl(ALUControl), 
        .A(A), 
        .B(B), 
        .ALUResult(ALUResult), 
        .Zero(Zero)
    );

	initial begin
	
    /* Please fill in the implementation here... */

	//Testing Add
    ALUControl <= 0;
    A <= 5;
    B <= 3;

    #10
    A <= 8;
    B <= -8;

    #10
    A <= -9;
    B <= 7;

    #10

    //Testing Sub
    ALUControl <= 1;
    A <= 5;
    B <= 3;

    #10
    A <= 8;
    B <= -8;

    #10
    A <= -9;
    B <= 7;

    #10
    //Testing Mul
    ALUControl <= 2;
    A <= 5;
    B <= 3;

    #10
    B <= -1;

    #10
    A <= 0;

    #10
    //Testing And
    ALUControl <= 3;
    A <= 32'b111111;
    B <= 32'b101010;

    #10
    A <= 32'b1010101010101;
    B <= 32'b1010101010101;

    #10
    B <= 32'b0101010101010;
    
    #10
    //Testing Or
    ALUControl <= 4;
    A <= 32'b1111111;
    B <= 32'b0000000;

    #10
    A <= 32'b0000000;


    #10
    //Testing Shift left
    ALUControl <= 6;
    A <= -32'd30;
    B <= 4;

    //Testing Shift Right
    #100 ALUControl <= 7;
    A <= -32'd69;
    B <= 3;

    //Testing XOR
    #100 ALUControl <= 8;
    A <= 32'b101010;
    B <= 32'b010101;

    #10
    A <= 32'b111000;
    B <= 32'b110111;

    //Testing Slt
    #10
    ALUControl <= 9;
    A <= 5;
    B <= 7;

    #10
    A <= 4;
    B <= 4;

    #10
    A <= 0;
    B <= -8;
    
	end

endmodule

