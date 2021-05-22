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
    input [4:0] shamt, 
    input checkoverflow,
    output reg zero,
    output reg [31:0] aluReg,
    output reg overflow
    );
    
    reg [63:0] sign;
    
    always @ (input1 or input2 or ALUCtrOut or shamt or checkoverflow)
    begin
        overflow=0;
        case (ALUCtrOut)
        4'b0010://add
        begin
            aluReg=input1+input2;
            if(checkoverflow)
            begin
                if(!(input1[31]^input2[31])&&(input1[31]^aluReg[31])) overflow=1;
            end
        end
        4'b0110://sub
        begin
            aluReg=input1-input2;
            if(checkoverflow)
            begin
                if((input1[31]^input2[31])&&(input1[31]^aluReg[31])) overflow=1;
            end
        end
        4'b0000:aluReg=input1&input2;//and
        4'b0001:aluReg=input1|input2;//or
        4'b1000:aluReg=input1^input2;//xor
        4'b1100:aluReg=~(input1|input2);//nor               
        4'b0111://slt sltu
        begin
            if(!checkoverflow)
            begin//     ÎÞ·ûºÅ
                aluReg=(input1<input2)?1:0;
            end
            else//ÓÐ·ûºÅ
            begin
                if(input1[31]^input2[31]==0) aluReg=(input1<input2)?1:0;
                else aluReg=(input1[31]==1)?1:0;
            end
        end
        4'b0011:aluReg=input2<<shamt;//sll
        4'b0101:aluReg=input2>>shamt;//srl
        4'b1001://sra
        begin
            sign={{32{input2[31]}},input2};
            sign=sign>>shamt;
            aluReg=sign[31:0];
        end
        4'b1011:aluReg=input2<<input1;//sllv
        4'b1101:aluReg=input2>>input1;//srlv
        4'b1111://srav
        begin
            sign={{32{input2[31]}},input2};
            sign=sign>>input1;
            aluReg=sign[31:0];
        end
        endcase
        
        if (aluReg==0)
            zero=1;
        else
            zero=0;
    end
endmodule
