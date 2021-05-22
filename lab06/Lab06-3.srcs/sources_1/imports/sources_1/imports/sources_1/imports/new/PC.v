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
    input bne,
    input zero,
    input jump,
    input [31:0] branchPC,
    input [31:0] jumpPC,
    input [31:0] jrPC,
    input jr,
    input stalli,
    input lock,
    output reg [31:0] PCreg
    );
    always @(reset)
    begin
        if(reset) PCreg=32'h00000000;
    end
    
    always @(posedge Clk)
    begin
        if(branch===1)
        begin
            if((zero^bne)===1)
                PCreg<=branchPC;//branchÌø×ª
            else PCreg<=PCreg+4;
        end
        else
        begin
            if(jump===1) PCreg<=jumpPC;
            if(jr===1) PCreg<=jrPC;
            if(!(jump===1)&&!(jr===1))
            begin
                if(!(stalli===1)&&!(lock===1)) PCreg<=PCreg+4;
            end
        end
    end
    
    initial begin
        PCreg=32'hFFFFFFFC;
    end
endmodule
