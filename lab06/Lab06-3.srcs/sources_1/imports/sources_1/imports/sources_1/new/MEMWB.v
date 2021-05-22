`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/08 23:37:08
// Design Name: 
// Module Name: MEMWB
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


module MEMWB(
    input Clk,
    input [31:0] MEM_PC,
    input [2:0] MEM_type,
    input MEM_memToReg,
    input MEM_regWrite,
    input [4:0] MEM_WriteReg,
    input [31:0]  MEM_DataWriteToReg,
 
    output reg [31:0] PC_WB,
    output reg [2:0] type_WB,
    output reg memToReg_WB,
    output reg regWrite_WB,
    output reg [4:0] WriteReg_WB,
    output reg [31:0] DataWriteToReg_WB
    );
    reg [31:0] PC;
    reg [2:0] type;
    reg memToReg;
    reg regWrite;
    reg jal;
    reg [31:0] ALUout;
    reg [4:0] WriteReg;
    reg [31:0] DataWriteToReg;
    always @(posedge Clk)
       begin
        PC_WB=PC;
        type_WB=type;
        memToReg_WB=memToReg;
        regWrite_WB=regWrite;
        WriteReg_WB=WriteReg;
        DataWriteToReg_WB=DataWriteToReg;
    end
    always @(negedge Clk)
    begin
      PC=MEM_PC;
      type=MEM_type;
     memToReg=MEM_memToReg;
     regWrite=MEM_regWrite;
        WriteReg=MEM_WriteReg;
        DataWriteToReg=MEM_DataWriteToReg;
    end

endmodule
