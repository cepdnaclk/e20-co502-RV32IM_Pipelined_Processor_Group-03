module instruction_memory(
    input  clk,
    input [31:0] PC,
    input reset

    output reg [31:0] instruction
);
    reg [31:0] memory [0:1023];
    integer i;

    initial begin
        memory[0] = 32'b00000000001000001_000_00011_0110011; //ADD x3, x1, x2
        memory[1] = 32'b0100000_00010_00001_000_00100_0110011; //SUB x2, x1, x2
        memory[2] = 32'b00000000001100000010000000100011; //SW x3, 6(x0)
        memory[3] = 32'b00000000010000000010001000100011; //SW x4, 4(x0)
        memory[4] = 32'b00000000000000000010001010000011; //LW x2, 0(x0)
        memory[5] = 32'b00000000010000000010001100000011; //LW x1, 4(x0)
    end

    always @(posedge clk) begin
        instruction <= memory[PC/4];
    end
endmodule