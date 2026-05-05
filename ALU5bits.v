//Problema 2


module ALU_5bits (
    input [4:0] A, B,
    input [2:0] ALUControl,
    output reg [4:0] Result,
    output reg [3:0] AluFlags  // N, Z, C, V
);

    localparam AND_OP = 3'b000;
    localparam OR_OP  = 3'b001;
    localparam ADD    = 3'b010;
    localparam SUB    = 3'b110;

    wire [4:0] sum_result;
    wire carry_out;
    wire overflow;
    
    assign {carry_out, sum_result} = (ALUControl == SUB) ? (A - B) : (A + B);

    always @(*) begin
        case (ALUControl)
            ADD: begin
                Result = sum_result;
                AluFlags[3] = Result[4];
                AluFlags[2] = (Result == 5'd0);
                AluFlags[1] = carry_out;
                AluFlags[0] = overflow;
            end
            SUB: begin
                Result = sum_result;
                AluFlags[3] = Result[4];
                AluFlags[2] = (Result == 5'd0);
                AluFlags[1] = carry_out;
                AluFlags[0] = overflow;
            end
            AND_OP: begin
                Result = A & B;
                AluFlags[3] = Result[4];
                AluFlags[2] = (Result == 5'd0);
                AluFlags[1] = 1'b0;
                AluFlags[0] = 1'b0;
            end
            OR_OP: begin
                Result = A | B;
                AluFlags[3] = Result[4];
                AluFlags[2] = (Result == 5'd0);
                AluFlags[1] = 1'b0;
                AluFlags[0] = 1'b0;
            end
            default: begin
                Result = 5'd0;
                AluFlags = 4'b0000;
            end
        endcase
    end

    assign overflow = (ALUControl == ADD) ? 
                      ((A[4] == B[4]) && (Result[4] != A[4])) :
                      (ALUControl == SUB) ? 
                      ((A[4] != B[4]) && (Result[4] != A[4])) : 
                      1'b0;

endmodule