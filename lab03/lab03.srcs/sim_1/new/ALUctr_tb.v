`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/17 10:18:35
// Design Name: 
// Module Name: ALUctr_tb
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


module ALUctr_tb(

    );
    reg [1:0] aluOp;
    reg [5:0] funct;
    wire [3:0] ALUCtrOut;
    ALUctr u0(
        .aluOp(aluOp),
        .funct(funct),
        .ALUCtrOut(ALUCtrOut)
        );
    initial begin
        aluOp=2'b00;
        funct=6'b000000;
        #100;
        
        #100;
        {aluOp,funct}=8'b00xxxxxx;
        #100;
        {aluOp,funct}=8'b01xxxxxx;
        #100;
        {aluOp,funct}=8'b1xxx0000;
        #100;
        {aluOp,funct}=8'b1xxx0010;
        #100;
        {aluOp,funct}=8'b1xxx0100;
        #100;
        {aluOp,funct}=8'b1xxx0101;
        #100;
        {aluOp,funct}=8'b1xxx1010;
    end
endmodule
