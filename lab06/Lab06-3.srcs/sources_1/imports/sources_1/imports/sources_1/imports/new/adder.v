`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/24 11:16:47
// Design Name: 
// Module Name: adder
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


module adder(
    input [31:0] shift1,
    input [31:0] shift2,
    input [31:0] PCData,
    output wire  [31:0] branchPC,
    output wire  [31:0] jumpPC
    );
    assign branchPC=PCData+shift1;
    assign jumpPC={PCData[31:28],shift2[27:0]};
endmodule
