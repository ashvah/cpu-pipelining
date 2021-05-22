`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/08 22:59:31
// Design Name: 
// Module Name: EXMEM
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


module EXMEM(
    input Clk,
    input [2:0] EX_type,
    input [31:0] EX_PC,
    input EX_memToReg,
    input EX_regWrite,
    input EX_memRead,
    input EX_memWrite,
    input EX_branch,
    input EX_jal,
    input [31:0] EX_Datart,
    input EX_zero,
    input [31:0] EX_ALUout,
    input [4:0] EX_WriteReg,
    
    output reg [31:0] PC_MEM,
    output reg [2:0] type_MEM,
    output reg memToReg_MEM,
    output reg regWrite_MEM,
    output reg memRead_MEM,
    output reg memWrite_MEM,
    output reg branch_MEM,
    output reg jal_MEM,
    output reg [31:0] Datart_MEM,
    output reg zero_MEM,
    output reg [31:0] ALUout_MEM,
    output reg [4:0] WriteReg_MEM
    );
    reg [31:0] PC;
    reg [2:0] type;
    reg [31:0] INST;
    reg memToReg;
    reg regWrite;
    reg memRead;
    reg memWrite;
    reg branch;
    reg jal;
    reg [31:0] Datart;
    reg zero;
    reg [31:0] ALUout;
    reg [4:0] WriteReg;
    always @(posedge Clk)
    begin
        PC_MEM=PC;
        type_MEM=type;
        memToReg_MEM=memToReg;
        regWrite_MEM=regWrite;
        memRead_MEM=memRead;
        memWrite_MEM=memWrite;
        branch_MEM=branch;
        jal_MEM=jal;
        Datart_MEM=Datart;
        zero_MEM=zero;
        ALUout_MEM=ALUout;
        WriteReg_MEM=WriteReg;
    end
    always @(negedge Clk)
    begin
         PC=EX_PC;
         type=EX_type;
     memToReg=EX_memToReg;
     regWrite=EX_regWrite;
     memRead=EX_memRead;
      memWrite=EX_memWrite;
     branch=EX_branch;
     jal=EX_jal;
     Datart=EX_Datart;
      zero=EX_zero;
        ALUout=EX_ALUout;
        WriteReg=EX_WriteReg;
    end
    
endmodule
