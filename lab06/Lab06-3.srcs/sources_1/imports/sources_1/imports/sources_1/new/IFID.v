`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/08 14:20:22
// Design Name: 
// Module Name: IFID
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


module IFID(
    input lock,
    input IF_stall,
    input [31:0] IF_INST,
    input [31:0] IF_PC,
    input Clk,
    output reg stall_ID,
    output reg [31:0] INST_ID,
    output reg [31:0] PC_ID
    );
    reg [31:0] INST;
    reg [31:0] PC;
    reg stall;
    
    always @(posedge Clk)
    begin
        INST_ID=INST;
        PC_ID=PC;
        stall_ID=stall;
    end
    always @(negedge Clk)
    begin
        if(!(lock===1))
        begin
        if(IF_stall===1) INST=32'h00000000;
        else INST=IF_INST;
        PC=IF_PC;
        stall=IF_stall;
        end
    end
endmodule
