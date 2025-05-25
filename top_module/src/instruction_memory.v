module instruction_memory(
    input [7:0] pc,
    output reg [31:0] instruction
);

    // Memory array to store instructions
    reg [31:0] memory [0:255];

    // Initialize memory with instructions
    initial begin
        memory[0] = {7'b0000110, 5'b00000, 5'b00000, 5'b01010, 10'b0000001010};
        memory[1] = {7'b0000110, 5'b00000, 5'b00000, 5'b01111, 10'b0000001111};
        memory[2] = {7'b0000010, 5'b01010, 5'b01111, 5'b11001, 10'b0000000000};
        memory[3] = {7'b0000111, 5'b11001, 5'b00000, 5'b10100, 10'b0000000101};
        memory[4] = {7'b0000110, 5'b00000, 5'b00000, 5'b00101, 10'b0000000010};
        memory[5] = {7'b0000100, 5'b11001, 5'b00101, 5'b11110, 10'b0000000000};
    end

    // Read instruction based on PC
    always @(*) begin
        instruction = memory[pc];
    end

endmodule 