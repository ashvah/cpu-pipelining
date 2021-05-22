`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/17 14:26:03
// Design Name: 
// Module Name: dataMemory_tb
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


module dataMemory_tb(

    );
    reg Clk;
    reg [31:0] address;
    reg [31:0] writeData;
    reg memWrite;
    reg memRead;
    reg reset;
    wire [31:0] readData;
    dataMemory n0(
    .Clk( Clk),
    .address(address),
    .writeData(writeData),
    .memWrite(memWrite),
    .memRead(memRead),
    .reset(reset),
    .readData(readData)
    );
always #100 Clk=!Clk;
initial begin
memWrite=0;
memRead=0;
address=0;
writeData=0;
Clk=1;
reset=1;

#100 reset=0;
#85;
memWrite=1'b1;
address=32'b00000000000000000000000000000111;
writeData=32'b11100000000000000000000000000000;
#100;
memWrite=1'b1;
address=32'b00000000000000000000000000000110;
writeData=32'hffffffff;
#185;
memRead=1'b1;
memWrite=1'b0;
address=7;
#80;
memWrite=1;
address=8;
writeData=32'haaaaaaaa;
#80;
memWrite=0;
memRead=1;
address=6;
end
endmodule
