`timescale 1ns / 1ps

module Top_tb();
    reg Clk, Reset;
     wire [6:0] program_counter;
    wire [7:0] write_register_data;

    Top computer(
        .Clk(Clk), 
        .Reset(Reset),
        .out7(program_counter),
        .en_out(write_register_data)
    );

    initial begin
        Clk <= 1'b1;
        forever #10 Clk <= ~Clk;
    end

    initial begin
        Reset <=  1;
        #20
        Reset <=0;
    end
endmodule