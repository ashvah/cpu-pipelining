`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/17 11:03:05
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] input1,
    input [31:0] input2,
    input [3:0] ALUCtrOut,
    output zero,
    output [31:0] aluReg
    );
    reg zero;
    reg [31:0] aluReg;
    
    always @ (input1 or input2 or ALUCtrOut)
    begin
        case (ALUCtrOut)
        4'b0010:aluReg=input1+input2;//add
        4'b0110://sub
        begin
            aluReg=input1-input2;
        end
        4'b0000:aluReg=input1&input2;//and
        4'b0001:aluReg=input1|input2;//or
        4'b0111://slt
        begin
            if(input1[31]^input2[31]==0) aluReg=(input1<input2)?1:0;
            else aluReg=(input1[31]==1)?1:0;
        end
        4'b1100:aluReg=~(input1|input2);//nor
        endcase
        if (aluReg==0)
            zero=1;
        else
            zero=0;
    end
endmodule
