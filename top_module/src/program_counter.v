module program_counter(
    input clk,
    input reset,
    input control,
    output reg [7:0] pc
);

    always @(posedge clk) begin
        if (reset) begin
            pc <= 8'b0;
        end
        else if (control) begin
            pc <= pc + 1;
        end
    end

endmodule 