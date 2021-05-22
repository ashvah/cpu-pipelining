`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/16 17:46:54
// Design Name: 
// Module Name: DataHazard
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


module DataHazard(
    input [2:0] type_EX,
    input [2:0] type_MEM,
    input [2:0] type_WB,
    input [4:0] WriteReg_MEM,
    input [4:0] WriteReg_WB,
    input [31:0] INST_EX,
    output reg forwardingMEM_rs,
    output reg forwardingMEM_rt,
    output reg forwardingWB_rs,
    output reg forwardingWB_rt
    );
    
    always @(type_EX or type_MEM or type_WB or WriteReg_MEM or WriteReg_WB or INST_EX)
    begin
        forwardingMEM_rs=0;
        forwardingMEM_rt=0;
        forwardingWB_rs=0;
        forwardingWB_rt=0;
        if((type_MEM==3'b100)||(type_MEM==3'b011)||(type_MEM==3'b101))//R andi ori addi jal
        begin
            if(WriteReg_MEM==INST_EX[25:21]) forwardingMEM_rs=1;
            if(WriteReg_MEM==INST_EX[20:16]) forwardingMEM_rt=1;
        end
        if((type_WB==3'b100)||(type_WB==3'b011)||(type_WB==3'b101)||(type_WB==3'b000))//R andi ori addi jal lw
        begin
            if(WriteReg_WB==INST_EX[25:21]) forwardingWB_rs=1;
            if(WriteReg_WB==INST_EX[20:16]) forwardingWB_rt=1;
        end
    end
endmodule
