`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/17 11:26:35
// Design Name: 
// Module Name: ALU_tb
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


module ALU_tb(

    );
    reg [31:0] input1;
    reg [31:0] input2;
    reg [3:0] ALUCtrOut;
    wire zero;
    wire [31:0] aluReg;
    
    ALU u0(
        .input1(input1),
        .input2(input2),
        .ALUCtrOut(ALUCtrOut),
        .zero(zero),
        .aluReg(aluReg)
        );
    initial begin
    ALUCtrOut=4'b0000;//and
    input1=0;
    input2=0;
    #100;
    input1=15;
    input2=10;
    #100;
    ALUCtrOut=4'b0001;//or
    #100;
    ALUCtrOut=4'b0010;//add
    #100;
    ALUCtrOut=4'b0110;//sub
    #100;
    ALUCtrOut=4'b0110;//sub
    input1=10;
    input2=15;
    #100;
    ALUCtrOut=4'b0111;//slt
    input1=15;
    input2=10;
    #100;
    ALUCtrOut=4'b0111;//slt
    input1=10;
    input2=15;
    #100;
    ALUCtrOut=4'b1100;//nor
    input1=1;
    input2=1;
    #100;
    ALUCtrOut=4'b1100;//nor
    input1=16;
    input2=1;
    end
endmodule
