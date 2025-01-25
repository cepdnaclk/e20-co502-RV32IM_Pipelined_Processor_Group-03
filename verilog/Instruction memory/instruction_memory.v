module instruction_memory(
    input  clk,
    input [31:0] PC,
    input reset,

    output reg [31:0] instruction
);
    reg [31:0] memory [0:1023];
    integer i;

    initial begin
        $readmemh("instructions.txt", memory);
    end

    always @(posedge clk) begin
        instruction <= memory[PC];
    end
endmodule