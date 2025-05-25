module alu(
    input [31:0] operand1,
    input [31:0] operand2,
    input [2:0] alu_op,
    output reg [31:0] result
);

    always @(*) begin
        case (alu_op)
            3'b000, 3'b001: result = 32'b0;
            3'b010: result = operand1 + operand2;
            3'b011: result = operand1 - operand2;
            3'b100: result = operand1 << operand2;
            3'b101: result = operand1 >> operand2;
            3'b110: result = operand1 + operand2;
            3'b111: result = operand1 - operand2;
            default: result = 32'b0;
        endcase
    end

endmodule 