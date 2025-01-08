// Advanced Computer Architecture (CO502)
// Design: Data Memory
// Group Number: 03
// E Numbers: E/20/369, E/20/381, E/20/385
// Last Modified: 06.01.2024

`timescale  1ns/100ps

module EX_MA_register(
    input CLK,
    input mem_write,
    input mem_read,
    input MUX3_select,
    input regwrite_enable,
    input ALU_out [31:0],
    input DATA_2 [31:0],
    input func_3 [2:0],
    input rd [4:0]

    output reg mem_write_out,
    output reg mem_read_out,
    output reg MUX3_select_out,
    output reg regwrite_enable_out,
    output reg [31:0] ALU_out_out,
    output reg [31:0] DATA_2_out,
    output reg [2:0] func_3_out, 
    output reg [4:0] rd_out 

);

always @(posedge CLK) begin
    mem_write_out <= mem_write;
    mem_read_out <= mem_read;
    MUX3_select_out <= MUX3_select;
    regwrite_enable_out <= regwrite_enable;
    ALU_out_out <= ALU_out;
    DATA_2_out <= DATA_2;
    func_3_out <= func_3;
    rd_out <= rd;
end
