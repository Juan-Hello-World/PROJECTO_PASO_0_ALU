
//Problema 1

`timescale 1ns / 1ps

module tb_ALU;
    reg [31:0] A, B;
    reg [2:0] ALUControl;
    wire [31:0] Result;
    wire [3:0] AluFlags;
    
    // Instanciar el ALU
    ALU uut (
        .A(A),
        .B(B),
        .ALUControl(ALUControl),
        .Result(Result),
        .AluFlags(AluFlags)
    );
    
    initial begin
        // Encabezado de la simulación
        $display("==============================================================");
        $display(" Operacion   |    A    |    B    |  Result  | N | Z | C | V |");
        $display("==============================================================");
        
        // Operación 1: 3 + 5 = 8
        A = 32'd3; B = 32'd5; ALUControl = 3'b010;  // ADD
        #10;
        $display(" 3 + 5       | %6d  | %6d  |  %6d  | %d | %d | %d | %d |",
                 A, B, Result, AluFlags[3], AluFlags[2], AluFlags[1], AluFlags[0]);
        
        // Operación 2: 5 - 5 = 0
        A = 32'd5; B = 32'd5; ALUControl = 3'b110;  // SUB
        #10;
        $display(" 5 - 5       | %6d  | %6d  |  %6d  | %d | %d | %d | %d |",
                 A, B, Result, AluFlags[3], AluFlags[2], AluFlags[1], AluFlags[0]);
        
        // Operación 3: 8 AND 1 = 0
        A = 32'd8; B = 32'd1; ALUControl = 3'b000;  // AND
        #10;
        $display(" 8 AND 1     | %6d  | %6d  |  %6d  | %d | %d | %d | %d |",
                 A, B, Result, AluFlags[3], AluFlags[2], AluFlags[1], AluFlags[0]);
        
        // Operación 4: 5 OR 7 = 7
        A = 32'd5; B = 32'd7; ALUControl = 3'b001;  // OR
        #10;
        $display(" 5 OR 7      | %6d  | %6d  |  %6d  | %d | %d | %d | %d |",
                 A, B, Result, AluFlags[3], AluFlags[2], AluFlags[1], AluFlags[0]);
        
        $display("==============================================================");
        #10;
        $finish;
    end
endmodule