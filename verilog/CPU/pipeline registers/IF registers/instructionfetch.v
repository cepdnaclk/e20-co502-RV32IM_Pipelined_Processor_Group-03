module Instfetch_registers(
    input CLK,
    input [31:0] PC4,
    input [31:0] PC,
    input [31:0] instruction,

    output reg [31:0] instruction_out,
    output reg [31:0] PC_out,
    output reg [31:0] PC4_out

);

    reg [31:0] instruction_intermediate;
    reg [31:0] PC_intermediate;
    reg [31:0] PC4_intermediate;

    always @(posedge CLK) begin
        instruction_out <= instruction_intermediate;
        PC_out <= PC_intermediate;
        PC4_out <= PC4_intermediate;

        instruction_intermediate <= instruction;
        PC_intermediate <= PC;
        PC4_intermediate <= PC4;
    end
endmodule