module instruction_memory(
    input  clk,
    input [31:0] PC,
    input reset,

    output reg [31:0] instruction
);
    reg [31:0] memory [0:1023];
    integer i;

    initial begin
        memory[0] = 32'b00000000101000000000000010010011; //ADDI x1, x0, 10
        memory[1] = 32'b00000000010100000000000100010011; //ADDI x2, x0, 5
        memory[2] = 32'b00000000001000001000000110110011; //ADD x3, x1, x2
        memory[3] = 32'b01000000001000001000001000110011; //SUB x2, x1, x2
        memory[4] = 32'b00000000001100000010000000100011; //SW x3, 6(x0)
        memory[5] = 32'b00000000010000000010001000100011; //SW x4, 4(x0)
        memory[6] = 32'b00000000000000000010001010000011; //LW x2, 0(x0)
        memory[7] = 32'b00000000010000000010001100000011; //LW x1, 4(x0)
    end

    always @(posedge clk) begin
        instruction <= memory[PC/4];
    end
endmodule