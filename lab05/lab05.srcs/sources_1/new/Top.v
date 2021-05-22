`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/24 10:07:47
// Design Name: 
// Module Name: Top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Top(
    input Clk,
    input reset,
    output wire [31:0] nextPC 
    );
    //ctr unit
    wire regDst;
    wire ALUsrc;
    wire memToReg;
    wire regWrite;
    wire memRead;
    wire memWrite;
    wire branch;
    wire opExt;
    wire [2:0] aluOp;
    wire [3:0] ALUCtrOut;
    wire jump;
    wire jal;
    wire [31:0] INST;
    
    //alu
    wire [31:0] input2;
    wire [31:0] ALUout;
    wire zero;
    wire jr;
    
    //register
    wire [4:0] WriteReg;
    wire [31:0] DataWriteToReg;
    wire [31:0] Datars;
    wire [31:0] Datart;
    
    //memory   
    wire [31:0] readDataFromMem;
    
    //signext
    wire [31:0] signextData;
    
    //Shiftleft
    wire [31:0] ShiftedImmediate1;
    wire [31:0] ShiftedImmediate2;
    
    //PCadder
    wire [31:0] branchPC;
    wire [31:0] jumpPC;
    
    //input opcode output ctrol signal
    Ctr mainCtr(
    .opCode(INST[31:26]),
    .regDst(regDst),
    .ALUsrc(ALUsrc),
    .memToReg(memToReg),
    .regWrite(regWrite),
    .memRead(memRead),
    .memWrite(memWrite),
    .branch(branch),
    .aluOp(aluOp),
    .jump(jump),
    .jal(jal),
    .opExt(opExt)
    );
    
    //input aluop output aluctr
    ALUctr mainALUctr(
    .aluOp(aluOp),
    .funct(INST[5:0]),
    .ALUCtrOut(ALUCtrOut),
    .jr(jr)
    );
    
    //output aluout/zero
    ALU mainALU(
    .input1(Datars),
    .input2(input2),
    .ALUCtrOut(ALUCtrOut),
    .shamt(INST[10:6]),
    .zero(zero),
    .aluReg(ALUout)
    );
    
    //input nextPC output instruction
    InstMemory mainInstMemory(
    .ReadAddress(nextPC),
    .Instruction(INST)
    );
    
    //output PC
    PC mainPC(
    .reset(reset),
    .Clk(Clk),
    .branch(branch),
    .zero(zero),
    .jump(jump),
    .branchPC(branchPC),
    .jumpPC(jumpPC),
    .jrPC(Datars),
    .jr(jr),
    .PCreg(nextPC)
    );
    
    //input rs rt output reg[rs],reg[rt]
    Registers registerFile(
    .readReg1(INST[25:21]),
    .readReg2(INST[20:16]),
    .WriteReg(WriteReg),
    .DataWrite(DataWriteToReg),
    .Clk(Clk),
    .reset(reset),
    .RegWrite(regWrite),
    .readData1(Datars),
    .readData2(Datart)
    );
    
    //input address output readDataFromMem
    dataMemory memoryFile(
    .Clk(Clk),
    .address(ALUout),
    .writeData(Datart),
    .memWrite(memWrite),
    .memRead(memRead),
    .reset(reset),
    .readData(readDataFromMem)
    );
    
    //input immediate number ouput signextData
    signext signext1(
    .inst(INST[15:0]),
    .opExt(opExt),
    .data(signextData)
    );
    
    //input signextData Darart ouput input2(ALU)
    
    MUX mux1(
    .input1(signextData),
    .input2(Datart),
    .sel(ALUsrc),
    .output1(input2)
    );
    
    wire [4:0] WriteReg1;
    
    //input rd and rt ouput writeaddress(registerfile)
    assign WriteReg1=regDst?INST[15:11]:INST[20:16];
    assign WriteReg=jal? 5'b11111 : WriteReg1;
    
    wire [31:0] Datamux3;
    
    //input aluout and memoryout ouput registerwritedata(registerfile) 
    MUX mux3(
    .input1(readDataFromMem),
    .input2(ALUout),
    .sel(memToReg),
    .output1(Datamux3)
    );
    
    //if jal=1 write jalPC to $31
    MUX mux4(
    .input1(nextPC+4),
    .input2(Datamux3),
    .sel(jal),
    .output1(DataWriteToReg)
    );
    
    //branch shiftleft signext
    Shiftleft shift1(
    .signext(signextData),
    .immediate(ShiftedImmediate1)
    );
    
    
    
    //jmp shiftleft
    Shiftleft shift2(
    .signext(INST),
    .immediate(ShiftedImmediate2)
    );
    
    //PC adder input signext shifted left 2,PC+4, ouput branchPC
    adder PCadder(
    .shift1(ShiftedImmediate1),
    .shift2(ShiftedImmediate2),
    .PCData(nextPC),
    .branchPC(branchPC),
    .jumpPC(jumpPC)
    );
    

endmodule
