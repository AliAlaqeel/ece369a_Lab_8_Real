`timescale 1ns / 1ps
/*
ECE 369A - Lab 7
Lab Group 25 - Section C

Top module file
Students & Effort Percentage:
Ali Alaqeel 50% - Logan Stonehouse 50%
*/
module Top(
    Clk, 
    Reset,
    out7,
    en_out
);
    input Clk;
    input Reset;
    output [6:0] out7;
    output [7:0] en_out;

    wire [31:0] v0Reg, v1Reg;


    ////    Setup     ////
    wire ClkDivided;

    ClkDiv clockDivider(
        .Clk(Clk), 
        .Rst(Reset), 
        .ClkOut(ClkDivided)
    );

    Two4DigitDisplay digitDisplay(
        .Clk( Clk ), 
        .NumberA( v1Reg[15:0] ), 
        .NumberB( v0Reg[15:0] ), 
        .out7( out7 ), 
        .en_out( en_out )
    );

    ////    fetch stage     ////
    wire [31:0] f_currPC;
    wire [31:0] f_instruction;
    wire [31:0] f_nextPC;
    wire f_writeBack;

    Mux32Bit3To1 pcMux(
        .out(f_nextPC), 
        .inA(f_currPC + 4), 
        .inB((d_currPC + 4) + (d_signExtImm <<< 2)), 
        .inC(d_jumpOffset), 
        .sel(d_branchType)
    );

    ProgramCounter PC(
        .Address(f_nextPC), 
        .PCResult(f_currPC), 
        .Reset(Reset), 
        .Clk(ClkDivided), 
        .Pause(pausePC)
    );

    InstructionMemory instructionMem(
        .Address(f_currPC), 
        .Instruction(f_instruction)
    );

    Control_fetch f_control(
        .instruction(f_instruction), 
        .writeBack(f_writeBack)
    );

    wire [4:0] regToRead1;
    wire [4:0] regToRead2;

    ReadRegsDetector readRegistorsDetector(
        .instruction(f_instruction), 
        .regToRead1(regToRead1), 
        .regToRead2(regToRead2)
    );

    wire deactivatePipe, pausePC;

    HAZARD_Detector hazardDetector(
        .regToRead1(regToRead1), 
        .regToRead2(regToRead2), 
        .decode_dstReg(d_writeReg), 
        .execute_dstReg(e_writeReg), 
        .branchOccurance(d_branchOccur), 
        .jumpOccurance(d_jumpOccur), 
        .disable_f_d_pipe_reg(deactivatePipe), 
        .pausePC(pausePC),
        .decode_writeBack(d_writeBack),
        .execute_writeBack(e_writeBack),
        .memory_dstReg(m_writeReg),
        .write_dstReg(w_writeReg),
        .memory_writeBack(m_writeBack),
        .write_writeBack(w_writeBack)
    );

    ////    fetch => decode    ////
    wire [31:0] d_currPC;
    wire [31:0] d_instruction;
    wire d_writeBack;

    f_d_register f_d_reg(
        .Clk(ClkDivided), 
        .deactivate(deactivatePipe),
        .f_currPC(f_currPC),
        .d_currPC(d_currPC),
        .f_instruction(f_instruction),
        .d_instruction(d_instruction),
        .f_writeback(f_writeBack),
        .d_writeback(d_writeBack)
    );

    ////    decode stage    ////
    wire [31:0] d_data1;
    wire [31:0] d_data2;
    wire [31:0] d_signExtImm;

    RegisterFile regFile(
        .ReadRegister1(d_instruction[25:21]),
        .ReadRegister2(d_instruction[20:16]), 
        .WriteRegister(w_writeReg), 
        .WriteData(w_writeData), 
        .RegWrite(w_writeBack), 
        .Clk(ClkDivided), 
        .ReadData1(d_data1), 
        .ReadData2(d_data2),
        .v0Data(v0Reg),
        .v1Data(v1Reg)
    );

    SignExtension signExt(
        .in(d_instruction[15:0]), 
        .out(d_signExtImm)
    );

    wire [31:0] d_jumpOffset;
    wire d_jumpOccur, d_branchOccur;

    BranchResolver branchResolver(
        .regData1(d_data1), 
        .regData2(d_data2), 
        .instr(d_instruction), 
        .progCount(d_currPC), 
        .jOffset(d_jumpOffset), 
        .branchOccurance(d_branchOccur), 
        .jumpOccurance(d_jumpOccur)
    );

    wire [1:0] d_writeRegChoice;
    wire [1:0] d_branchType;

    Control_Decode d_control(
        .instruction(d_instruction), 
        .branchOccurance(d_branchOccur), 
        .jumpOccurance(d_jumpOccur), 
        .branchType(d_branchType), 
        .writeRegChoice(d_writeRegChoice)
    );

    wire [4:0] d_writeReg;

    Mux5Bit3To1 d_writeRegMux(
        .out(d_writeReg), 
        .inA(d_instruction[20:16]), 
        .inB(d_instruction[15:11]), 
        .inC(5'd31), 
        .sel(d_writeRegChoice)
    );

    ////    decode => execute    ////
    wire [31:0] e_currPC;
    wire [31:0] e_instruction;
    wire [31:0] e_data1;
    wire [31:0] e_data2;
    wire [31:0] e_signExtImm;
    wire e_writeBack;
    wire [4:0] e_writeReg;

    d_e_register d_e_reg(
        .Clk(ClkDivided),
        .d_currPC(d_currPC),
        .e_currPC(e_currPC),
        .d_instruction(d_instruction),
        .e_instruction(e_instruction),
        .d_data1(d_data1),
        .e_data1(e_data1),
        .d_data2(d_data2),
        .e_data2(e_data2),
        .d_signExtImm(d_signExtImm),
        .e_signExtImm(e_signExtImm),
        .d_writeBack(d_writeBack),
        .e_writeBack(e_writeBack),
        .d_writeReg(d_writeReg),
        .e_writeReg(e_writeReg)
    );

    ////    execute stage    ////
    wire d_aluSrc;

    Control_execute e_control(
        .instruction(e_instruction), 
        .aluSrc(d_aluSrc)
    );

    wire [31:0] aluBinput;

    Mux32Bit2To1 aluSrcMux(
        .out(aluBinput), 
        .inA(e_data2), 
        .inB(e_signExtImm), 
        .sel(d_aluSrc)
    );

    wire [3:0] aluOp;

    ALUControl aluControl(
        .Opcode(e_instruction[31:26]), 
        .Funct(e_instruction[5:0]), 
        .ALU_op(aluOp)
    );

    wire [31:0] e_aluResult;
    wire uselessZero;

    ALU32Bit aluUnit(
        .ALUControl(aluOp), 
        .A(e_data1), 
        .B(aluBinput), 
        .ALUResult(e_aluResult), 
        .Zero(uselessZero)
    );

    ////   Execute => Memory    ////
    wire [31:0] m_currPC;
    wire [31:0] m_instruction;
    wire [31:0] m_data2;
    wire m_writeBack;
    wire [4:0] m_writeReg;
    wire MemRead, MemWrite;
    wire [31:0] m_ALUresult;

    e_m_register e_mem_reg(
        .Clk(ClkDivided),
        .e_currPC(e_currPC),
        .m_currPC(m_currPC),
        .e_instruction(e_instruction),
        .m_instruction(m_instruction),
        .e_writeBack(e_writeBack),
        .m_writeBack(m_writeBack),
        .e_writeReg(e_writeReg),
        .m_writeReg(m_writeReg),
        .e_ALUresult(e_aluResult),
        .m_ALUresult(m_ALUresult),
        .e_data2(e_data2),
        .m_data2(m_data2)
    );

    ////    Memory Stage    ////
    Control_Memory m_control(
        .Instruction(m_instruction),
        .MemRead(MemRead),
        .MemWrite(MemWrite)
    );
    
    wire [31:0] m_memData;

    DataMemory dataMem(
        .Clk(ClkDivided), 
        .MemRead(MemRead), 
        .MemWrite(MemWrite), 
        .Address(m_ALUresult), 
        .WriteData(m_data2), 
        .ReadData(m_memData), 
        .Opcode(m_instruction[31:26])
    );

    ////    memory => writeback     ////
    wire [31:0] w_currPC;
    wire [31:0] w_instruction;
    wire w_writeBack;
    wire [4:0] w_writeReg;
    wire [31:0] w_ALUresult;
    wire [31:0] w_memData;

    m_w_register m_w_reg(
        .Clk(ClkDivided),
        .m_currPC(m_currPC),
        .w_currPC(w_currPC),
        .m_instruction(m_instruction),
        .w_instruction(w_instruction),
        .m_writeBack(m_writeBack),
        .w_writeBack(w_writeBack),
        .m_writeReg(m_writeReg),
        .w_writeReg(w_writeReg),
        .m_ALUresult(m_ALUresult),
        .w_ALUresult(w_ALUresult),
        .m_memData(m_memData),
        .w_memData(w_memData)
    );

    //  writeback stage //
    wire userlessWire2;
    wire [1:0] memToReg;

    Control_writeback w_control(
        .instruction(w_instruction), 
        .memToReg(memToReg), 
        .writeBack(userlessWire2)
    );

    wire [31:0] w_writeData;

    Mux32Bit3To1 w_writebackMux(
        .out(w_writeData), 
        .inA(w_memData), 
        .inB(w_ALUresult), 
        .inC( w_currPC + 4 ), 
        .sel(memToReg)
    );

endmodule