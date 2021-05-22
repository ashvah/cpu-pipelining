`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/17 12:53:10
// Design Name: 
// Module Name: Registers_tb
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


module Registers_tb(

    );
    reg [4:0] readReg1;
    reg [4:0] readReg2;
    reg [4:0] WriteReg;
    reg [31:0] DataWrite;
    reg Clk;
    reg reset;
    reg RegWrite;
    wire [31:0] readData1;
    wire [31:0] readData2;

    Registers u0(
        .readReg1(readReg1),
        .readReg2(readReg2),
        .WriteReg(WriteReg),
        .DataWrite(DataWrite),
        .Clk(Clk),
        .reset(reset),
        .RegWrite(RegWrite),
        .readData1(readData1),
        .readData2(readData2)
        );
always #(100) Clk=!Clk;
initial begin
    readReg1=0;
    readReg2=0;
    WriteReg=0;
    RegWrite=0;
    Clk=1;
    DataWrite=0;
    reset=1;
    #100 reset=0;
    
    #285;
    RegWrite=1'b1;
    WriteReg=5'b10101;
    DataWrite=32'hffff0000;
    #200;
    WriteReg=5'b01010;
    DataWrite=32'h0000ffff;
    #200;
    RegWrite=1'b0;
    WriteReg=5'b00000;
    DataWrite=32'h00000000;
    
    #50;
    readReg1=5'b10101;
    readReg2=5'b01010;
    #50;
    readReg1=5'b00000;
    
    #150;
    RegWrite=1'b1;
    WriteReg=5'b00000;
    DataWrite=32'hffffffff;
    #150;
    DataWrite=32'h00000000;
end
endmodule
