// Advanced Computer Architecture (CO502)
// Design: Data Memory
// Group Number: 03
// E Numbers: E/20/369, E/20/381, E/20/385
// Last Modified: 06.01.2024

`timescale  1ns/100ps

`timescale 1ns/100ps

module EX_MA_register(
    input CLK,
    input MUX3_select,
    input regwrite_enable,
    input [31:0] ALU_out,
    input [31:0] read_data,
    input [4:0] rd,
    output reg MUX3_select_out,
    output reg regwrite_enable_out,
    output reg [31:0] ALU_out_out,
    output reg [31:0] read_data_out,
    output reg [4:0] rd_out
);

    always @(posedge CLK) begin
        MUX3_select_out <= MUX3_select;
        regwrite_enable_out <= regwrite_enable;
        ALU_out_out <= ALU_out;
        read_data_out <= read_data;
        rd_out <= rd;
    end

endmodule
