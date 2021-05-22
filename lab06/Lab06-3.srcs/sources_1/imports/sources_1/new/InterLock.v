`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/16 19:58:49
// Design Name: 
// Module Name: InterLock
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


module InterLock(
    input [2:0] type_ID,
    input [2:0] type_EX,
    input [2:0] type_MEM,
    input [2:0] type_WB,
    input [4:0] WriteReg_EX,
    input [4:0] WriteReg_MEM,
    input [4:0] WriteReg_WB,
    input [31:0] INST_ID,
    output reg forwardingMEM_rs,
    output reg forwardingMEM_rt,
    output reg forwardingWB_rs,
    output reg forwardingWB_rt,
    output reg lock
    );
    
    always @(type_ID or type_EX or type_MEM or type_WB or WriteReg_EX or WriteReg_MEM or WriteReg_WB or INST_ID)
    begin
        forwardingMEM_rs=0;
        forwardingMEM_rt=0;
        forwardingWB_rs=0;
        forwardingWB_rt=0;
        lock=0;
        if((type_MEM==3'b100)||(type_MEM==3'b011)||(type_MEM==3'b101)||(type_MEM==3'b000))//R:jal
        begin
            if(WriteReg_MEM==INST_ID[25:21]) forwardingMEM_rs=1;
            if(WriteReg_MEM==INST_ID[20:16]) forwardingMEM_rt=1;
        end
        if((type_WB==3'b100)||(type_WB==3'b011)||(type_WB==3'b101)||(type_WB==3'b000))//R andi ori addi jal lw
        begin
            if(WriteReg_WB==INST_ID[25:21]) forwardingWB_rs=1;
            if(WriteReg_WB==INST_ID[20:16]) forwardingWB_rt=1;
        end
        if(type_MEM==3'b000)
        begin
            if(WriteReg_MEM==INST_ID[20:16]||WriteReg_MEM==INST_ID[25:21])
            begin
                if(type_ID==3'b110) lock=1;
            end
        end         
        if(type_EX==3'b000)//lw
        begin
            if(WriteReg_EX==INST_ID[20:16])
            begin
                if((type_ID==3'b100)||(type_ID==3'b110))lock=1;//R,rt
            end
            if(WriteReg_EX==INST_ID[25:21])
            begin
                if((type_ID==3'b100)||(type_ID==3'b011)||(type_ID==3'b110)||(type_ID==3'b000)||(type_ID==3'b001))lock=1;//R,lw,sw,beq,andi,ori,adi rs
            end
        end
    end
endmodule
