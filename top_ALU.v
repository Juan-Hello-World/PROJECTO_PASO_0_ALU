
//Problema 2

`timescale 1ns / 1ps



module top_ALU (
    input clk,
    input [15:0] sw,
    output [15:0] led
);

    wire [4:0] A, B;
    wire [2:0] ALUControl;
    wire [4:0] Result;
    wire [3:0] AluFlags;

    // Switches:
    // sw[4:0]   = A
    // sw[9:5]   = B
    // sw[12:10] = ALUControl
    assign A = sw[4:0];
    assign B = sw[9:5];
    assign ALUControl = sw[12:10];

    ALU_5bits alu_inst (
        .A(A),
        .B(B),
        .ALUControl(ALUControl),
        .Result(Result),
        .AluFlags(AluFlags)
    );

    // LEDs:
    // led[4:0]   = Result
    // led[15:12] = Flags (N, Z, C, V)
    assign led[4:0] = Result;
    assign led[15:12] = AluFlags;
    assign led[11:5] = 7'b0000000;

endmodule