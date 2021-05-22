`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/24 12:28:22
// Design Name: 
// Module Name: Top_tb
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


module Top_tb(

    );
    reg Clk;
    reg reset;
    wire [31:0] PC;
    wire stall;
    Top MIPS_CPU(
    .Clk(Clk),
    .reset(reset),
    .nextPC(PC),
    .stall_IF(stall)
    );
always #(100) Clk=!Clk;
initial begin
    reset=0;
    Clk=1;
end
endmodule
