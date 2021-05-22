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
    output jr,
    output reg stall,
    output reg overflow
    );
    reg [3:0] ALUCtrOut;
    reg jr;
    always @(aluOp or funct)
    begin
        jr=0;
        stall=0;
        overflow=0;
        
        casex ({aluOp,funct})
        9'b100100000://add
        begin
            ALUCtrOut=4'b0010;
            overflow=1;
        end
        9'b100100001:ALUCtrOut=4'b0010;//addu
        9'b100100010://sub
        begin
            ALUCtrOut=4'b0110;
            overflow=1;
        end
        9'b100100011:ALUCtrOut=4'b0110;//subu
        9'b100100100:ALUCtrOut=4'b0000;//and
        9'b100100101:ALUCtrOut=4'b0001;//or
        9'b100100110:ALUCtrOut=4'b1000;//xor
        9'b100100111:ALUCtrOut=4'b1100;//nor
        9'b100101010://slt
        begin
            ALUCtrOut=4'b0111;
            overflow=1;
        end
        9'b100101011:ALUCtrOut=4'b0111;//sltu
        9'b100000000:ALUCtrOut=4'b0011;//sll
        9'b100000010:ALUCtrOut=4'b0101;//srl
        9'b100000011:ALUCtrOut=4'b1001;//sra
        9'b100000100:ALUCtrOut=4'b1011;//sllv
        9'b100000110:ALUCtrOut=4'b1101;//srlv
        9'b100000111:ALUCtrOut=4'b1111;//srav
        9'b100001000://jr
        begin
             ALUCtrOut=4'b0000;
             jr=1;//jr
             stall=1;
        end
        9'b000xxxxxx:ALUCtrOut=4'b0010;//lw sw addi addiu
        9'b011xxxxxx:ALUCtrOut=4'b0000;//andi
        9'b010xxxxxx:ALUCtrOut=4'b0001;//ori
        9'b001xxxxxx:ALUCtrOut=4'b1000;//xori
        9'b101xxxxxx:ALUCtrOut=4'b1011;//lui
        9'b110xxxxxx:ALUCtrOut=4'b0111;//slti sltiu
        endcase
    end
endmodule
