`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/08 16:10:49
// Design Name: 
// Module Name: IDEX
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


module IDEX(
    input Clk,
    input ID_rsSrc,
    input ID_lock,
    input [2:0] ID_type,
    input [31:0] ID_PC,
    input [31:0] ID_INST,
    input ID_regDst,
    input ID_ALUsrc,
    input ID_memToReg,
    input ID_regWrite,
    input ID_memRead,
    input ID_memWrite,
    input ID_branch,
    input [3:0] ID_ALUCtrOut,
    input ID_jal,
    input [31:0] ID_Datars,
    input [31:0] ID_Datart,
    input [31:0] ID_signextData,
    input ID_checkoverflow,
    
    output reg rsSrc_EX,
    output reg [31:0] PC_EX,
    output reg [2:0] type_EX,
    output reg [31:0] INST_EX,
    output reg regDst_EX,
    output reg ALUsrc_EX,
    output reg memToReg_EX,
    output reg regWrite_EX,
    output reg memRead_EX,
    output reg memWrite_EX,
    output reg branch_EX,
    output reg [3:0] ALUCtrOut_EX,
    output reg jal_EX,
    output reg [31:0] Datars_EX,
    output reg [31:0] Datart_EX,
    output reg [31:0] signextData_EX,
    output reg checkoverflow_EX
    );
    reg rsSrc;
    reg [31:0] PC;
    reg [2:0] type;
    reg [31:0] INST;
    reg regDst;
    reg ALUsrc;
    reg memToReg;
    reg regWrite;
    reg memRead;
    reg memWrite;
    reg branch;
    reg [3:0] ALUCtrOut;
    reg jal;
    reg [31:0] Datars;
    reg [31:0] Datart;
    reg [31:0] signextData;
    reg checkoverflow;
    always @(posedge Clk)
    begin
        rsSrc_EX=rsSrc;
        PC_EX=PC;
        type_EX=type;
        INST_EX=INST;
        regDst_EX=regDst;
        ALUsrc_EX=ALUsrc;
        memToReg_EX=memToReg;
        regWrite_EX=regWrite;
        memRead_EX=memRead;
        memWrite_EX=memWrite;
        branch_EX=branch;
        ALUCtrOut_EX=ALUCtrOut;
        jal_EX=jal;
        Datars_EX=Datars;
        Datart_EX=Datart;
        signextData_EX=signextData;
        checkoverflow_EX=checkoverflow;
    end
    always @(negedge Clk)
    begin
    rsSrc=ID_rsSrc;
         PC=ID_PC;
         type=ID_type;
      INST=ID_INST;
     regDst=ID_regDst;
    ALUsrc=ID_ALUsrc;
     memToReg=ID_memToReg;
     regWrite=ID_regWrite;
     memRead=ID_memRead;
      memWrite=ID_memWrite;
     branch=ID_branch;
      ALUCtrOut=ID_ALUCtrOut;
      jal=ID_jal;
     Datars=ID_Datars;
     Datart=ID_Datart;
      signextData=ID_signextData;
      checkoverflow=ID_checkoverflow;
      
      if(ID_lock)
      begin
        PC=0;
         type=3'b100;
         INST=0;
         regDst=0;
        ALUsrc=0;
         memToReg=0;
         regWrite=0;
        memRead=0;
         memWrite=0;
         branch=0;
         ALUCtrOut=0;
        jal=0;
        Datars=0;
         Datart=0;
        signextData=0;
        checkoverflow=0;
      end
    end
endmodule
