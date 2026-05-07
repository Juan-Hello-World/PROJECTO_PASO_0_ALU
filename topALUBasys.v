
//Problema 2

`timescale 1ns / 1ps

module top(input clk,
    input [15:0] sw,
    output [15:0] led);
    wire clk_slow;
    
    clockdivider c2(clk, clk_slow);
    top_ALU alu(clk_slow, sw, led);
    endmodule
    

module top_ALU (
    input clk,
    input [15:0] sw,
    output [15:0] led
);

    wire [4:0] A, B;
    wire [1:0] bshift; //Shift
    wire [2:0] ALUControl;
    wire [4:0] Result;
    wire [3:0] AluFlags;
    wire [4:0] A_desplazado; //Shift

    // Switches:
    // sw[4:0]   = A
    // sw[9:5]   = B
    // sw[12:10] = ALUControl
    assign A = sw[4:0];
    assign B = sw[9:5];
    assign bshift = sw[11:10];
    assign ALUControl = sw[15:13];
    
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

    // LEDs:
    // led[4:0]   = Result
    // led[15:12] = Flags (N, Z, C, V)
    assign led[4:0] = Result;
    assign led[15:12] = AluFlags;
    assign led[11:5] = 7'b0000000;

endmodule


module clockdivider(input in_clk, output reg out_clk);
    reg [26:0] counter = 0;
    initial out_clk = 0;
    
    always@(posedge in_clk) begin
        counter <= counter + 1;
        if (counter == 0) out_clk <= ~out_clk;
         // Si el counter llega a 0 es pq dio una vuelta entera a esos 2^25
         // cambios de ciclos que hubo.
    end
endmodule
