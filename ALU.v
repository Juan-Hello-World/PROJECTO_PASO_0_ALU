//Problema 1


`timescale 1ns / 1ps

module ALU (
    input [31:0] A, B,
    input [2:0] ALUControl,
    output reg [31:0] Result,
    output reg [3:0] AluFlags  // N, Z, C, V
);

    // Códigos de operación
    localparam AND_OP = 3'b000;
    localparam OR_OP  = 3'b001;
    localparam ADD    = 3'b010;
    localparam SUB    = 3'b110;

    wire [31:0] sum_result;
    wire carry_out;
    wire overflow;
    
    // Sumador/Restador
    assign {carry_out, sum_result} = (ALUControl == SUB) ? (A - B) : (A + B);

    always @(*) begin
        case (ALUControl)
            ADD: begin
                Result = sum_result;
                AluFlags[3] = Result[31];               // N
                AluFlags[2] = (Result == 32'd0);        // Z
                AluFlags[1] = carry_out;                // C
                AluFlags[0] = overflow;                 // V
            end
            
            SUB: begin
                Result = sum_result;
                AluFlags[3] = Result[31];
                AluFlags[2] = (Result == 32'd0);
                AluFlags[1] = carry_out;
                AluFlags[0] = overflow;
            end
            
            AND_OP: begin
                Result = A & B;
                AluFlags[3] = Result[31];
                AluFlags[2] = (Result == 32'd0);
                AluFlags[1] = 1'b0;
                AluFlags[0] = 1'b0;
            end
            
            OR_OP: begin
                Result = A | B;
                AluFlags[3] = Result[31];
                AluFlags[2] = (Result == 32'd0);
                AluFlags[1] = 1'b0;
                AluFlags[0] = 1'b0;
            end
            
            default: begin
                Result = 32'd0;
                AluFlags = 4'b0000;
            end
        endcase
    end

    // Detección de overflow
    assign overflow = (ALUControl == ADD) ? 
                      ((A[31] == B[31]) && (Result[31] != A[31])) :
                      (ALUControl == SUB) ? 
                      ((A[31] != B[31]) && (Result[31] != A[31])) : 
                      1'b0;

endmodule
