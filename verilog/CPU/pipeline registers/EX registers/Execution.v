module Execution_registers(
    input CLK,
    input [4:0] alu_select,
    input mux1_select,
    input mux2_select,
    input mux3_select,
    input regwrite_enable,
    input mem_read,
    input mem_write,
    input branch,
    input jump,
    input jal_select,
    
    input [31:0] PC4,
    input [31:0] PC,
    input [31:0] Immediate,
    input [31:0] data1,
    input [31:0] data2,

    input [2:0] Instruction_func3,
    input [4:0] destination_reg,

    output reg [4:0] alu_select_out,
    output reg mux1_select_out,
    output reg mux2_select_out,
    output reg mux3_select_out,
    output reg regwrite_enable_out,
    output reg mem_read_out,
    output reg mem_write_out,
    output reg branch_out,
    output reg jump_out,
    output reg jal_select_out,

    output reg [31:0] PC4_out,
    output reg [31:0] PC_out,
    output reg [31:0] Immediate_out,
    output reg [31:0] data1_out,
    output reg [31:0] data2_out,

    output reg [2:0] Instruction_func3_out,
    output reg [4:0] destination_reg_out
);

    reg [4:0] alu_select_intermediate;
    reg mux1_select_intermediate;
    reg mux2_select_intermediate;
    reg mux3_select_intermediate;
    reg regwrite_enable_intermediate;
    reg mem_read_intermediate;
    reg mem_write_intermediate;
    reg branch_intermediate;
    reg jump_intermediate;
    reg jal_select_intermediate;

    reg [31:0] PC4_intermediate;
    reg [31:0] PC_intermediate;
    reg [31:0] Immediate_intermediate;
    reg [31:0] data1_intermediate;
    reg [31:0] data2_intermediate;

    reg [2:0] Instruction_func3_intermediate;
    reg [4:0] destination_reg_intermediate;

    always @(posedge CLK) begin
        alu_select_out <= alu_select_intermediate;
        mux1_select_out <= mux1_select_intermediate;
        mux2_select_out <= mux2_select_intermediate;
        mux3_select_out <= mux3_select_intermediate;
        regwrite_enable_out <= regwrite_enable_intermediate;
        mem_read_out <= mem_read_intermediate;
        mem_write_out <= mem_write_intermediate;
        branch_out <= branch_intermediate;
        jump_out <= jump_intermediate;
        jal_select_out <= jal_select_intermediate;

        PC4_out <= PC4_intermediate;
        PC_out <= PC_intermediate;
        Immediate_out <= Immediate_intermediate;
        data1_out <= data1_intermediate;
        data2_out <= data2_intermediate;

        Instruction_func3_out <= Instruction_func3_intermediate;
        destination_reg_out <= destination_reg_intermediate;

        alu_select_intermediate <= alu_select;
        mux1_select_intermediate <= mux1_select;
        mux2_select_intermediate <= mux2_select;
        mux3_select_intermediate <= mux3_select;
        regwrite_enable_intermediate <= regwrite_enable;
        mem_read_intermediate <= mem_read;
        mem_write_intermediate <= mem_write;
        branch_intermediate <= branch;
        jump_intermediate <= jump;
        jal_select_intermediate <= jal_select;

        PC4_intermediate <= PC4;
        PC_intermediate <= PC;
        Immediate_intermediate <= Immediate;
        data1_intermediate <= data1;
        data2_intermediate <= data2;

        Instruction_func3_intermediate <= Instruction_func3;
        destination_reg_intermediate <= destination_reg;
    end
endmodule   