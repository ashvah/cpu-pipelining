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
    input [2:0] aluOp,
    input [5:0] funct,
    output [3:0] ALUCtrOut,
    output jr
    );
    reg [3:0] ALUCtrOut;
    reg jr;
    always @(aluOp or funct)
    begin
        jr=0;
        casex ({aluOp,funct})
        9'b000xxxxxx:ALUCtrOut=4'b0010;//lw sw addi
        9'b001xxxxxx:ALUCtrOut=4'b0110;//branch
        9'b1xx100000:ALUCtrOut=4'b0010;//add
        9'b011xxxxxx:ALUCtrOut=4'b0000;//and
        9'b1xx100010:ALUCtrOut=4'b0110;//subtract
        9'b1xxxx0100:ALUCtrOut=4'b0000;//and
        9'b010xxxxxx:ALUCtrOut=4'b0001;//or
        9'b1xxxx0101:ALUCtrOut=4'b0001;//or
        9'b1xxxx1010:ALUCtrOut=4'b0111;//slt
        9'b1xx000000:ALUCtrOut=4'b0011;//sll
        9'b1xx000010:ALUCtrOut=4'b0101;//srl
        9'b1xxxx1000:
        begin
             ALUCtrOut=4'b0000;
             jr=1;//jr
        end
        endcase
    end
endmodule
