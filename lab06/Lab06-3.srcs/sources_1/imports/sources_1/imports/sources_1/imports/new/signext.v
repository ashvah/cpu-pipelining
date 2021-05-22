`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/17 15:07:05
// Design Name: 
// Module Name: signext
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


module signext(
    input [15:0] inst,
    input opExt,
    output reg [31:0] data
    );
    always @(inst or opExt)
    begin
    if(opExt)    
        data={ {16 {inst[15]}},inst};
    else
        data={ {16 {1'b0}},inst};
    end
endmodule
