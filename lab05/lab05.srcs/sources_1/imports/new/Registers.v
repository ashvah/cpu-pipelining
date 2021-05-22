`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/17 12:11:24
// Design Name: 
// Module Name: Registers
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


module Registers(
    input [25:21] readReg1,
    input [20:16] readReg2,
    input [4:0] WriteReg,
    input [31:0] DataWrite,
    input Clk,
    input reset,
    input RegWrite,
    output reg [31:0] readData1,
    output reg [31:0] readData2
    );
    reg [31:0] regFile[31:0];
    integer i;

    always @(readReg1 or readReg2 or WriteReg or reset or RegWrite or DataWrite or Clk)
        begin
            if(reset)
                for(i=0;i<32;i=i+1) regFile[i]=32'b00000000000000000000000000000000;
            readData1=regFile[readReg1];
            readData2=regFile[readReg2];         
        end
    always @(negedge Clk)
        begin
            if(RegWrite==1) regFile[WriteReg]<=DataWrite;
        end
        
    initial begin
        $readmemh("C:/Archlabs/lab05/lab05.srcs/data/registerFile.txt",regFile);
    end
endmodule
