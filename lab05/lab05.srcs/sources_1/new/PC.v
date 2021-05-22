`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/24 10:10:00
// Design Name: 
// Module Name: PC
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


module PC(
    input reset,
    input Clk,
    input branch,
    input zero,
    input jump,
    input [31:0] branchPC,
    input [31:0] jumpPC,
    input [31:0] jrPC,
    input jr,
    output reg [31:0] PCreg
    );
    always @(reset)
    begin
        if(reset) PCreg=32'h00000000;
    end
    
    always @(posedge Clk)
    begin
        if(branch&zero) 
            PCreg<=branchPC;
        else
            PCreg<=PCreg+4;
        if(jump) PCreg<=jumpPC;
        if(jr) PCreg<=jrPC;
    end
    
    initial begin
        PCreg=32'hFFFFFFFC;
    end
endmodule
