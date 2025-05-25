module register_file(
    input clk,
    input reset,
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
    input [31:0] write_data,
    input write_enable,
    output reg [31:0] read_data1,
    output reg [31:0] read_data2
);

    // 32 registers of 32 bits each
    reg [31:0] registers [0:31];
    integer i;

    // Initialize registers
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            registers[i] = 32'b0;
        end
    end

    // Read operation
    always @(*) begin
        read_data1 = (rs1 == 0) ? 32'b0 : registers[rs1];
        read_data2 = (rs2 == 0) ? 32'b0 : registers[rs2];
    end

    // Write operation
    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i < 32; i = i + 1) begin
                registers[i] <= 32'b0;
            end
        end
        else if (write_enable && rd != 0) begin
            registers[rd] <= write_data;
        end
    end

endmodule 