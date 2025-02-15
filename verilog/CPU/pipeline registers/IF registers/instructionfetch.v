module Instfetch_registers(
    input CLK,
    input Stall,  // Stall signal added
    input [31:0] PC4,
    input [31:0] PC,
    input [31:0] instruction,

    output reg [31:0] instruction_out,
    output reg [31:0] PC_out,
    output reg [31:0] PC4_out
);

    always @(posedge CLK) begin
        if (Stall) begin
            // Hold current values in IF stage
            instruction_out <= instruction_out;
            PC_out <= PC_out;
            PC4_out <= PC4_out;
        end else begin
            // Normal execution
            instruction_out <= instruction;
            PC_out <= PC;
            PC4_out <= PC4;
        end
    end
endmodule
