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
    output reg [31:0] Instruction
    );
    reg [63:0] InstMemoryFile[31:0];
    
    always @(ReadAddress)
    begin
       Instruction=InstMemoryFile[(ReadAddress>>2)];
    end
    
    initial begin
        $readmemb("C:/Archlabs/Lab06-3/Lab06-3.srcs/data/InstMemFile2.txt",InstMemoryFile);
    end
endmodule
