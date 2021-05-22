`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/17 09:59:27
// Design Name: 
// Module Name: ALUctr
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


module ALUctr(
    input [1:0] aluOp,
    input [5:0] funct,
    output [3:0] ALUCtrOut
    );
    reg [3:0] ALUCtrOut;
    always @(aluOp or funct)
    begin
        casex ({aluOp,funct})
        8'b00xxxxxx:ALUCtrOut=4'b0010;//lw sw
        8'b01xxxxxx:ALUCtrOut=4'b0110;//branch
        8'b1xxx0000:ALUCtrOut=4'b0010;//add
        8'b1xxx0010:ALUCtrOut=4'b0110;//subtract
        8'b1xxx0100:ALUCtrOut=4'b0000;//and
        8'b1xxx0101:ALUCtrOut=4'b0001;//or
        8'b1xxx1010:ALUCtrOut=4'b0111;//slt
        endcase
    end
endmodule
