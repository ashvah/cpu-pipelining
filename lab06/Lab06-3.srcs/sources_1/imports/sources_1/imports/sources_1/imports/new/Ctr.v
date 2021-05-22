`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/17 08:13:57
// Design Name: 
// Module Name: Ctr
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


module Ctr(
    input [5:0] opCode,
    output regDst,
    output ALUsrc,
    output memToReg,
    output regWrite,
    output memRead,
    output memWrite,
    output branch,
    output [2:0] aluOp,
    output jump,
    output jal,
    output opExt,
    output reg stall,
    output reg [2:0] type,
    output reg overflow,
    output reg rsSrc,
    output reg bne
    );
    
    reg regDst;
    reg ALUsrc;
    reg memToReg;
    reg regWrite;
    reg memRead;
    reg memWrite;
    reg branch;
    reg [2:0] aluOp;
    reg jump;
    reg jal;
    reg opExt;
    
    always @(opCode)
    begin
        overflow=0;
        rsSrc=0;
        bne=0;
        
        case(opCode)
        6'b000000://R type
        begin
            regDst=1;
            ALUsrc=0;
            memToReg=0;
            regWrite=1;
            memRead=0;
            memWrite=0;
            branch=0;
            aluOp=3'b100;
            jump=0;
            jal=0;
            opExt=0;
            stall=0;
            type=3'b100;
        end
        //I type
        6'b001000://addi
        begin
            regDst=0;
            ALUsrc=1;
            memToReg=0;
            regWrite=1;
            memRead=0;
            memWrite=0;
            branch=0;
            aluOp=3'b000;
            jump=0;
            jal=0;
            opExt=1;
            stall=0;
            type=3'b011;
            overflow=1;
        end
        6'b001001://addiu
        begin
            regDst=0;
            ALUsrc=1;
            memToReg=0;
            regWrite=1;
            memRead=0;
            memWrite=0;
            branch=0;
            aluOp=3'b000;
            jump=0;
            jal=0;
            opExt=0;
            stall=0;
            type=3'b011;
        end
        6'b001100://andi
        begin
            regDst=0;
            ALUsrc=1;
            memToReg=0;
            regWrite=1;
            memRead=0;
            memWrite=0;
            branch=0;
            aluOp=3'b011;
            jump=0;
            jal=0;
            opExt=0;
            stall=0;
            type=3'b011;
        end
        6'b001101://ori
        begin
            regDst=0;
            ALUsrc=1;
            memToReg=0;
            regWrite=1;
            memRead=0;
            memWrite=0;
            branch=0;
            aluOp=3'b010;
            jump=0;
            jal=0;
            opExt=0;
            stall=0;
            type=3'b011;
        end
        6'b001110://xori
        begin
            regDst=0;
            ALUsrc=1;
            memToReg=0;
            regWrite=1;
            memRead=0;
            memWrite=0;
            branch=0;
            aluOp=3'b001;
            jump=0;
            jal=0;
            opExt=0;
            stall=0;
            type=3'b010;
        end
        6'b001111://lui
        begin
            regDst=0;
            ALUsrc=1;
            memToReg=0;
            regWrite=1;
            memRead=0;
            memWrite=0;
            branch=0;
            aluOp=3'b101;
            jump=0;
            jal=0;
            opExt=0;
            stall=0;
            type=3'b011;
            rsSrc=1;
        end 
        6'b001010://slti
        begin
            regDst=0;
            ALUsrc=1;
            memToReg=0;
            regWrite=1;
            memRead=0;
            memWrite=0;
            branch=0;
            aluOp=3'b110;
            jump=0;
            jal=0;
            opExt=1;
            stall=0;
            type=3'b010;
            overflow=1;
        end 
        6'b001011://sltiu
        begin
            regDst=0;
            ALUsrc=1;
            memToReg=0;
            regWrite=1;
            memRead=0;
            memWrite=0;
            branch=0;
            aluOp=3'b110;
            jump=0;
            jal=0;
            opExt=0;
            stall=0;
            type=3'b010;
        end 
        6'b100011://lw
        begin
            regDst=0;
            ALUsrc=1;
            memToReg=1;
            regWrite=1;
            memRead=1;
            memWrite=0;
            branch=0;
            aluOp=3'b000;
            jump=0;
            jal=0;
            opExt=1;
            stall=0;
            type=3'b000;
        end
        6'b101011://sw
        begin
            regDst=0;//x
            ALUsrc=1;
            memToReg=0;//x
            regWrite=0;
            memRead=0;
            memWrite=1;
            branch=0;
            aluOp=3'b000;
            jump=0;
            jal=0;
            opExt=1;
            stall=0;
            type=3'b001;
        end
        6'b000100://beq type
        begin
            regDst=0;//x
            ALUsrc=0;
            memToReg=0;//x
            regWrite=0;
            memRead=0;
            memWrite=0;
            branch=1;
            aluOp=3'b001;
            jump=0;
            jal=0;
            opExt=1;
            stall=0;
            type=3'b110;
        end    
        6'b000101://bne type
        begin
            regDst=0;//x
            ALUsrc=0;
            memToReg=0;//x
            regWrite=0;
            memRead=0;
            memWrite=0;
            branch=1;
            bne=1;
            aluOp=3'b001;
            jump=0;
            jal=0;
            opExt=1;
            stall=0;
            type=3'b110;
        end    
        
        
        //J type
        6'b000010://jump
        begin
            regDst=0;
            ALUsrc=1;
            memToReg=0;
            regWrite=1;
            memRead=0;
            memWrite=0;
            branch=0;
            aluOp=3'b000;
            jump=1;
            jal=0;
            opExt=1;
            stall=1;
            type=3'b010;
        end
        6'b000011://jal
        begin
            regDst=0;
            ALUsrc=1;
            memToReg=0;
            regWrite=1;
            memRead=0;
            memWrite=0;
            branch=0;
            aluOp=3'b000;
            jump=1;
            jal=1;
            opExt=1;
            stall=1;
            type=3'b101;
        end
        default:
        begin
            regDst=0;
            ALUsrc=0;
            memToReg=0;
            regWrite=0;
            memRead=0;
            memWrite=0;
            branch=0;
            aluOp=3'b000;
            jump=0;
            jal=0;
            opExt=0;
            stall=0;
            type=3'b100;
        end
        endcase
    end

endmodule
