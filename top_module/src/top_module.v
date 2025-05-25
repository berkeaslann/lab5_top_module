module top_module(
    input clk,
    input reset,
    input control,
    output [31:0] result,
    output [6:0] seg,
    output [7:0] an
);

    wire [7:0] pc;
    wire [31:0] instruction;
    wire [2:0] alu_op;
    wire [4:0] rs1, rs2, rd;
    wire [31:0] immediate;
    wire [31:0] read_data1, read_data2;
    wire [31:0] alu_result;

    program_counter pc_inst(
        .clk(clk),
        .reset(reset),
        .control(control),
        .pc(pc)
    );

    instruction_memory imem_inst(
        .pc(pc),
        .instruction(instruction)
    );

    instruction_decoder decoder_inst(
        .instruction(instruction),
        .alu_op(alu_op),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .immediate(immediate)
    );

    register_file rf_inst(
        .clk(clk),
        .reset(reset),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .write_data(alu_result),
        .write_enable(1'b1),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    alu alu_inst(
        .operand1(read_data1),
        .operand2((alu_op == 3'b110 || alu_op == 3'b111) ? immediate : read_data2),
        .alu_op(alu_op),
        .result(alu_result)
    );

    seg7_controller seg7_inst(
        .clk(clk),
        .reset(reset),
        .value(alu_result),
        .seg(seg),
        .an(an)
    );

    assign result = alu_result;

endmodule


// ======================= SEG7 CONTROLLER MODULE =========================

module seg7_controller(
    input clk,
    input reset,
    input [31:0] value,
    output reg [6:0] seg,
    output reg [7:0] an
);

    reg [2:0] digit_select;
    reg [3:0] digit_value;
    reg [19:0] counter;

    // Counter for multiplexing
    always @(posedge clk) begin
        if (reset)
            counter <= 0;
        else
            counter <= counter + 1;
    end

    // Determine which digit to show and its value
    always @(*) begin
        digit_select = counter[19:17];
        digit_value = 4'b0000;
        an = 8'b11111111;

        case (digit_select)
            3'b000: begin
                an = 8'b11111110;
                digit_value = value[3:0];
            end
            3'b001: begin
                an = 8'b11111101;
                digit_value = value[7:4];
            end
            3'b010: begin
                an = 8'b11111011;
                digit_value = value[11:8];
            end
            3'b011: begin
                an = 8'b11110111;
                digit_value = value[15:12];
            end
            3'b100: begin
                an = 8'b11101111;
                digit_value = value[19:16];
            end
            3'b101: begin
                an = 8'b11011111;
                digit_value = value[23:20];
            end
            3'b110: begin
                an = 8'b10111111;
                digit_value = value[27:24];
            end
            3'b111: begin
                an = 8'b01111111;
                digit_value = value[31:28];
            end
        endcase
    end

    // Display digit_value on 7-segment
    always @(*) begin
        case (digit_value)
            4'h0: seg = 7'b1000000;
            4'h1: seg = 7'b1111001;
            4'h2: seg = 7'b0100100;
            4'h3: seg = 7'b0110000;
            4'h4: seg = 7'b0011001;
            4'h5: seg = 7'b0010010;
            4'h6: seg = 7'b0000010;
            4'h7: seg = 7'b1111000;
            4'h8: seg = 7'b0000000;
            4'h9: seg = 7'b0010000;
            4'hA: seg = 7'b0001000;
            4'hB: seg = 7'b0000011;
            4'hC: seg = 7'b1000110;
            4'hD: seg = 7'b0100001;
            4'hE: seg = 7'b0000110;
            4'hF: seg = 7'b0001110;
            default: seg = 7'b1111111;
        endcase
    end

endmodule
