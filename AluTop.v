`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.05.2026 09:35:18
// Design Name: 
// Module Name: AluTop
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

module AluTop(
    input clk,
    input [4:0] A,
    input [4:0] B,
    input [1:0] bshift,
    input [2:0] ALUControl,
    output [4:0] Result,
    output [3:0] AluFlags,
    output [4:0] A_desplazado
    );
    
    shift shift_inst(
        .A(A),
        .bshift(bshift),
        .A_desplazado(A_desplazado)
    );
    ALU alu_inst (
        .A(A_desplazado),
        .B(B),
        .ALUControl(ALUControl),
        .Result(Result),
        .AluFlags(AluFlags)
    );
endmodule
