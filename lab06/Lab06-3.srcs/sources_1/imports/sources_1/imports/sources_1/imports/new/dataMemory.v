`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/17 14:16:33
// Design Name: 
// Module Name: dataMemory
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


module dataMemory(
    input Clk,
    input [31:0] address,
    input [31:0] writeData,
    input memWrite,
    input memRead,
    input reset,
    output reg [31:0] readData
    );
    reg [31:0] memFile[63:0];
    integer i;

    always @(address or memRead or reset or writeData)
        begin
            if(reset)
                for(i=0;i<64;i=i+1) memFile[i]=32'b00000000000000000000000000000000;
            if(memRead==1) readData=memFile[address];
        end
    always @(negedge Clk)
        begin
            if(memWrite==1) memFile[address]<=writeData;
        end
        
    initial begin
        $readmemh("C:/Archlabs/Lab06-3/Lab06-3.srcs/data/dataMemFile.txt",memFile);
    end
endmodule
