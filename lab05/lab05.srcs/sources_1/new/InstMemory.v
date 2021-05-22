`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/24 09:54:21
// Design Name: 
// Module Name: InstMemory
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


module InstMemory(
    input [31:0] ReadAddress,
    output [31:0] Instruction
    );
    reg [31:0] Instruction;
    reg [31:0] InstMemoryFile[31:0];
    
    always @(ReadAddress)
    begin
        Instruction=InstMemoryFile[(ReadAddress>>2)];
    end
    
    initial begin
        $readmemb("C:/Archlabs/lab05/lab05.srcs/data/InstMemFile.txt",InstMemoryFile);
    end
endmodule
