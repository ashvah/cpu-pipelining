`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/24 10:07:47
// Design Name: 
// Module Name: Top
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

//IF ID EX MEM WB 五阶段流水线
//解决了结构冒险
//解决了分支冒险
//解决了数据冒险
//predict-not-taken
//31 MIPS Instructions
module Top(
    input Clk,
    input reset,
    output [31:0] nextPC, 
    output stall_IF
    );
    //PC
    wire stallJ1;//j jal
    wire stallJ2;//jr
    wire flush;
    wire checkoverflowR_ID;//R type
    wire checkoverflowI_ID;//I type
    wire checkoverflow_ID;
    assign checkoverflow_ID=checkoverflowR_ID||checkoverflowI_ID;
    wire checkoverflow_EX;
    wire overflow_EX;
    assign stall_IF=(stallJ1||stallJ2)||flush;
    
    wire [2:0] type_ID;
    wire [2:0] type_EX;
    wire [2:0] type_MEM;
    wire [2:0] type_WB;
    
    //IF
    wire [31:0] INST_IF;
    wire [31:0] PC_IF;
    
    //IF:  input nextPC output instruction
    InstMemory mainInstMemory_IF(
    .ReadAddress(nextPC),
    .Instruction(INST_IF)
    );
    
    assign PC_IF=nextPC+4;
    
    //ID
    wire [31:0] PC_ID;
    wire stall_ID;
    wire [31:0] INST_ID;
    wire regDst_ID;
    wire ALUsrc_ID;
    wire memToReg_ID;
    wire regWrite_ID;
    wire memRead_ID;
    wire memWrite_ID;
    wire branch_ID;
    wire opExt_ID;//used
    wire [3:0] ALUCtrOut_ID;
    wire jump_ID;//used
    wire jal_ID;
    wire jr_ID;//used
    wire [31:0] Datars_ID;
    wire [31:0] Datart_ID;
    wire [31:0] signextData_ID;
    wire [31:0] ShiftedImmediate_ID;//used
    wire [31:0] jumpPC_ID;//used
    wire [2:0] aluOp_ID;
    wire lock_ID;
    wire lock_EX;
    wire rsSrc_ID;
    wire bne_ID;
    
    //IF/ID
    IFID IF_ID(
        .lock(lock_ID),
        .IF_stall(stall_IF),
        .IF_INST(INST_IF),
        .IF_PC(PC_IF),
        .Clk(Clk),
        .stall_ID(stall_ID),
        .INST_ID(INST_ID),
        .PC_ID(PC_ID)
    );
    
    //ID: input opcode output ctrol signal
    Ctr mainCtr_ID(
    .opCode(INST_ID[31:26]),
    .regDst(regDst_ID),
    .ALUsrc(ALUsrc_ID),
    .memToReg(memToReg_ID),
    .regWrite(regWrite_ID),
    .memRead(memRead_ID),
    .memWrite(memWrite_ID),
    .branch(branch_ID),
    .aluOp(aluOp_ID),
    .jump(jump_ID),
    .jal(jal_ID),
    .opExt(opExt_ID),
    .stall(stallJ1),
    .type(type_ID),
    .overflow(checkoverflowI_ID),
    .rsSrc(rsSrc_ID),
    .bne(bne_ID)
    );
    
    //ID: input aluop output aluctr
    ALUctr mainALUctr(
    .aluOp(aluOp_ID),
    .funct(INST_ID[5:0]),
    .ALUCtrOut(ALUCtrOut_ID),
    .jr(jr_ID),
    .stall(stallJ2),
    .overflow(checkoverflowR_ID)
    );
    
    wire jal_MEM;
    wire [31:0] PC_MEM;
    wire [4:0] WriteReg_MEM;
    wire [4:0] WriteReg_WB;
    wire [4:0] WriteReg_EX;
    wire [31:0] ALUout_MEM;
    wire [31:0] ALUout_WB;
    wire [31:0] DataWriteToReg_WB;
    wire [31:0] DataWriteToReg_MEM;
    wire forwardingMEM_rs_ID;
    wire forwardingMEM_rt_ID;
    wire forwardingWB_rs_ID;
    wire forwardingWB_rt_ID;
    
    //ID load interlock
    InterLock IL_ID(
    .type_ID(type_ID),
    .type_EX(type_EX),
    .type_MEM(type_MEM),
    .type_WB(type_WB),
    .WriteReg_EX(WriteReg_EX),
    .WriteReg_MEM(WriteReg_MEM),
    .WriteReg_WB(WriteReg_WB),
    .INST_ID(INST_ID),
    .forwardingMEM_rs(forwardingMEM_rs_ID),
    .forwardingMEM_rt(forwardingMEM_rt_ID),
    .forwardingWB_rs(forwardingWB_rs_ID),
    .forwardingWB_rt(forwardingWB_rt_ID),
    .lock(lock_ID)
    );
    
    wire [31:0] DatarsF_ID;
    wire [31:0] DatartF_ID;
    assign DatarsF_ID=forwardingMEM_rs_ID? DataWriteToReg_MEM:(forwardingWB_rs_ID?DataWriteToReg_WB:Datars_ID);//转发到rs
    assign DatartF_ID=forwardingMEM_rt_ID? DataWriteToReg_MEM :forwardingWB_rt_ID?DataWriteToReg_WB:Datart_ID;//转发到rt
    
    //ID:  input immediate number ouput signextData
    signext signext_ID(
    .inst(INST_ID[15:0]),
    .opExt(opExt_ID),
    .data(signextData_ID)
    );
    
    //ID: jmp shiftleft
    Shiftleft shift_ID(
    .signext(INST_ID),
    .immediate(ShiftedImmediate_ID)
    );
    
    wire [31:0] ShiftedImmediateBranch_ID;
    //EX: branch shiftleft signext
    Shiftleft shift1(
    .signext(signextData_ID),
    .immediate(ShiftedImmediateBranch_ID)
    );
    
    wire [31:0] branchPC_ID;
    //EX: PC adder input signext shifted left 2,PC+4, ouput branchPC
    adder PCadder(
    .shift1(ShiftedImmediateBranch_ID),
    .shift2(ShiftedImmediate_ID),
    .PCData(PC_ID),
    .branchPC(branchPC_ID),
    .jumpPC(jumpPC_ID)
    );
    
    wire zero_ID;
    assign zero_ID=(DatarsF_ID==DatartF_ID)?1:0;
    assign flush=(zero_ID^bne_ID)&&branch_ID;
    
    //EX
    wire [31:0] PC_EX;
    wire [31:0] INST_EX;//used
    wire regDst_EX;//used
    wire ALUsrc_EX;//used
    wire memToReg_EX;
    wire regWrite_EX;
    wire memRead_EX;
    wire memWrite_EX;
    wire branch_EX;
    wire [3:0] ALUCtrOut_EX;//used
    wire jal_EX;
    wire [31:0] Datars_EX;//used
    wire [31:0] Datart_EX;
    wire [31:0] signextData_EX;//used
    wire [31:0] input2_EX;//used
    wire zero_EX;
    wire [31:0] ALUout_EX;
    wire [31:0] ShiftedImmediate_EX;//used
    wire rsSrc_EX;
    
    //ID/EX
    
    IDEX ID_EX(
        .Clk(Clk),
    .ID_rsSrc(rsSrc_ID),
    .ID_lock(lock_ID),
    .ID_PC(PC_ID),
    .ID_type(type_ID),
    .ID_INST(INST_ID),
    .ID_regDst(regDst_ID),
    .ID_ALUsrc(ALUsrc_ID),
    .ID_memToReg(memToReg_ID),
    .ID_regWrite(regWrite_ID),
    .ID_memRead(memRead_ID),
    .ID_memWrite(memWrite_ID),
    .ID_branch(branch_ID),
    .ID_ALUCtrOut(ALUCtrOut_ID),
    .ID_jal(jal_ID),
    .ID_Datars(DatarsF_ID),
    .ID_Datart(DatartF_ID),
    .ID_signextData(signextData_ID),
    .ID_checkoverflow(checkoverflow_ID),
    .rsSrc_EX(rsSrc_EX),
    .PC_EX(PC_EX),
    .type_EX(type_EX),
    .INST_EX(INST_EX),
    .regDst_EX(regDst_EX),
    .ALUsrc_EX(ALUsrc_EX),
    .memToReg_EX(memToReg_EX),
    .regWrite_EX(regWrite_EX),
    .memRead_EX(memRead_EX),
    .memWrite_EX(memWrite_EX),
    .branch_EX(branch_EX),
    .ALUCtrOut_EX(ALUCtrOut_EX),
    .jal_EX(jal_EX),
    .Datars_EX(Datars_EX),
    .Datart_EX(Datart_EX),
    .signextData_EX(signextData_EX),
    .checkoverflow_EX(checkoverflow_EX)
    );
   
    wire forwardingMEM_rs_EX;
    wire forwardingMEM_rt_EX;
    wire forwardingWB_rs_EX;
    wire forwardingWB_rt_EX;
    
    //EX: data hazard
    DataHazard DH_EX(
    .type_EX(type_EX),
    .type_MEM(type_MEM),
    .type_WB(type_WB),
    .WriteReg_MEM(WriteReg_MEM),
    .WriteReg_WB(WriteReg_WB),
    .INST_EX(INST_EX),
    .forwardingMEM_rs(forwardingMEM_rs_EX),
    .forwardingMEM_rt(forwardingMEM_rt_EX),
    .forwardingWB_rs(forwardingWB_rs_EX),
    .forwardingWB_rt(forwardingWB_rt_EX)
    );
    
    wire [31:0] DatarsF_EX;
    wire [31:0] DatartF_EX;
    wire [31:0] input1_EX;
    assign DatarsF_EX=forwardingMEM_rs_EX?DataWriteToReg_MEM:(forwardingWB_rs_EX?DataWriteToReg_WB:Datars_EX);//转发到rs
    assign DatartF_EX=forwardingMEM_rt_EX?DataWriteToReg_MEM:(forwardingWB_rt_EX?DataWriteToReg_WB:Datart_EX);//转发到rt
    
    //EX: output aluout/zero
    ALU mainALU_EX(
    .input1(input1_EX),
    .input2(input2_EX),
    .ALUCtrOut(ALUCtrOut_EX),
    .shamt(INST_EX[10:6]),
    .checkoverflow(checkoverflow_EX),
    .zero(zero_EX),
    .aluReg(ALUout_EX),
    .overflow(overflow_EX)
    );
    
    //EX: input signextData Darart ouput input2(ALU)
    MUX mux1(
    .input1(signextData_EX),
    .input2(DatartF_EX),
    .sel(ALUsrc_EX),
    .output1(input2_EX)
    );
    
    assign input1_EX=rsSrc_EX?16:DatarsF_EX;
    
    //EX: input rd and rt ouput writeaddress(registerfile)
    wire [4:0] WriteReg1;  
    assign WriteReg1=regDst_EX?INST_EX[15:11]:INST_EX[20:16];
    assign WriteReg_EX=jal_EX? 5'b11111 : WriteReg1;
    
    //MEM
    wire memToReg_MEM;
    wire regWrite_MEM;
    wire memRead_MEM;//used
    wire memWrite_MEM;//used
    wire branch_MEM;//used
    wire [31:0] Datart_MEM;//used
    wire zero_MEM;//used
    wire [31:0] branchPC_MEM;//used
    wire [31:0] readDataFromMem_MEM;
    
    //EX/MEM
    EXMEM EX_MEM(
    .Clk(Clk),
    .EX_type(type_EX),
    .EX_PC(PC_EX),
    .EX_memToReg(memToReg_EX),
    .EX_regWrite(regWrite_EX),
    .EX_memRead(memRead_EX),
    .EX_memWrite(memWrite_EX),
    .EX_branch(branch_EX),
    .EX_jal(jal_EX),
    .EX_Datart(Datart_EX),
    .EX_zero(zero_EX),
    .EX_ALUout(ALUout_EX),
    .EX_WriteReg(WriteReg_EX),
    
    .PC_MEM(PC_MEM),
    .type_MEM(type_MEM),
    .memToReg_MEM(memToReg_MEM),
    .regWrite_MEM(regWrite_MEM),
    .memRead_MEM(memRead_MEM),
    .memWrite_MEM(memWrite_MEM),
    .branch_MEM(branch_MEM),
    .jal_MEM(jal_MEM),
    .Datart_MEM(Datart_MEM),
    .zero_MEM(zero_MEM),
    .ALUout_MEM(ALUout_MEM),
    .WriteReg_MEM(WriteReg_MEM)
    );
    
    //MEM: input address output readDataFromMem
    dataMemory memoryFile_MEM(
    .Clk(Clk),
    .address(ALUout_MEM),
    .writeData(Datart_MEM),
    .memWrite(memWrite_MEM),
    .memRead(memRead_MEM),
    .reset(reset),
    .readData(readDataFromMem_MEM)
    );
    
    //MEM： output PC
    PC mainPC_MEM(
    .reset(reset),
    .Clk(Clk),
    .branch(branch_ID),
    .bne(bne_ID),
    .zero(zero_ID),
    .jump(jump_ID),
    .branchPC(branchPC_ID),
    .jumpPC(jumpPC_ID),
    .jrPC(DatarsF_ID),
    .jr(jr_ID),
    .stalli(stall_IF),
    .lock(lock_ID),
    .PCreg(nextPC)
    );
    
    //MEM: input aluout and memoryout ouput registerwritedata(registerfile)
    wire [31:0] Datamux3_MEM; 
    MUX mux_MEM(
    .input1(readDataFromMem_MEM),
    .input2(ALUout_MEM),
    .sel(memToReg_MEM),
    .output1(Datamux3_MEM)
    );
    
    //MEM: if jal=1 write jalPC to $31
    MUX mux4_MEM(
    .input1(PC_MEM),
    .input2(Datamux3_MEM),
    .sel(jal_MEM),
    .output1(DataWriteToReg_MEM)
    );
    
    //WB
    wire [31:0] PC_WB;//used
    wire memToReg_WB;//used
    wire [4:0] regWrite_WB;//used
    
    //MEM/WB
     MEMWB MEM_WB(
    .Clk(Clk),
    .MEM_type(type_MEM),
    .MEM_PC(PC_MEM),
    .MEM_memToReg(memToReg_MEM),
    .MEM_regWrite(regWrite_MEM),
    .MEM_WriteReg(WriteReg_MEM),
    .MEM_DataWriteToReg(DataWriteToReg_MEM),
    .PC_WB(PC_WB),
    .type_WB(type_WB),
    .memToReg_WB(memToReg_WB),
    .regWrite_WB(regWrite_WB),
    .WriteReg_WB(WriteReg_WB),
    .DataWriteToReg_WB(DataWriteToReg_WB)
     );
    
    //ID/WB:  input rs rt output reg[rs],reg[rt]
    Registers registerFile_WB(
    .readReg1(INST_ID[25:21]),
    .readReg2(INST_ID[20:16]),
    .WriteReg(WriteReg_WB),
    .DataWrite(DataWriteToReg_WB),
    .Clk(Clk),
    .reset(reset),
    .RegWrite(regWrite_WB),
    .readData1(Datars_ID),
    .readData2(Datart_ID)
    ); 

endmodule
