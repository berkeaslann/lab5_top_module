module instruction_decoder(
    input [31:0] instruction,
    output reg [2:0] alu_op,
    output reg [4:0] rs1,
    output reg [4:0] rs2,
    output reg [4:0] rd,
    output reg [31:0] immediate
);

    // Instruction format:
    // [31:25] - opcode
    // [24:20] - rs1
    // [19:15] - rs2
    // [14:10] - rd
    // [9:0]   - immediate

    always @(*) begin
        case (instruction[31:25])
            7'b0000000: begin
                alu_op = 3'b000;
                rs1 = 5'b00000;
                rs2 = 5'b00000;
                rd = 5'b00000;
                immediate = 32'b0;
            end
            7'b0000001: begin
                alu_op = 3'b001;
                rs1 = 5'b00000;
                rs2 = 5'b00000;
                rd = 5'b00000;
                immediate = 32'b0;
            end
            7'b0000010: begin
                alu_op = 3'b010;
                rs1 = instruction[24:20];
                rs2 = instruction[19:15];
                rd = instruction[14:10];
                immediate = 32'b0;
            end
            7'b0000011: begin
                alu_op = 3'b011;
                rs1 = instruction[24:20];
                rs2 = instruction[19:15];
                rd = instruction[14:10];
                immediate = 32'b0;
            end
            7'b0000100: begin
                alu_op = 3'b100;
                rs1 = instruction[24:20];
                rs2 = instruction[19:15];
                rd = instruction[14:10];
                immediate = 32'b0;
            end
            7'b0000101: begin
                alu_op = 3'b101;
                rs1 = instruction[24:20];
                rs2 = instruction[19:15];
                rd = instruction[14:10];
                immediate = 32'b0;
            end
            7'b0000110: begin
                alu_op = 3'b110;
                rs1 = instruction[24:20];
                rs2 = 5'b00000;
                rd = instruction[14:10];
                immediate = {{22{instruction[9]}}, instruction[9:0]};
            end
            7'b0000111: begin
                alu_op = 3'b111;
                rs1 = instruction[24:20];
                rs2 = 5'b00000;
                rd = instruction[14:10];
                immediate = {{22{instruction[9]}}, instruction[9:0]};
            end
            default: begin
                alu_op = 3'b000;
                rs1 = 5'b00000;
                rs2 = 5'b00000;
                rd = 5'b00000;
                immediate = 32'b0;
            end
        endcase
    end

endmodule 