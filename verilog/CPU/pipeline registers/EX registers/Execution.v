module Execution_registers(
    input CLK,
    input Stall,  // Stall signal added
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

    // Forwarding control signals from Hazard Unit
    input [1:0] ForwardA, 
    input [1:0] ForwardB,

    // Data from MEM and WB stages for forwarding
    input [31:0] ALU_result_M, 
    input [31:0] MemData_WB,

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

    always @(posedge CLK) begin
        if (Stall) begin
            // Hold the values to stall EX stage
            alu_select_out <= alu_select_out;
            mux1_select_out <= mux1_select_out;
            mux2_select_out <= mux2_select_out;
            mux3_select_out <= mux3_select_out;
            regwrite_enable_out <= 0;  // Force no write in stall condition
            mem_read_out <= 0;
            mem_write_out <= 0;
            branch_out <= 0;
            jump_out <= 0;
            jal_select_out <= 0;

            PC4_out <= PC4_out;
            PC_out <= PC_out;
            Immediate_out <= Immediate_out;
            
            // Forwarding logic holds the previous data in case of stall
            data1_out <= data1_out;
            data2_out <= data2_out;

            Instruction_func3_out <= Instruction_func3_out;
            destination_reg_out <= destination_reg_out;
        end else begin
            // Forwarding logic based on ForwardA and ForwardB signals
            // Forward data for Rs1
            if (ForwardA == 2'b10) begin
                data1_out <= ALU_result_M;  // Forward from MEM stage
            end else if (ForwardA == 2'b01) begin
                data1_out <= MemData_WB;    // Forward from WB stage
            end else begin
                data1_out <= data1;         // No forwarding, use normal data
            end

            // Forward data for Rs2
            if (ForwardB == 2'b10) begin
                data2_out <= ALU_result_M;  // Forward from MEM stage
            end else if (ForwardB == 2'b01) begin
                data2_out <= MemData_WB;    // Forward from WB stage
            end else begin
                data2_out <= data2;         // No forwarding, use normal data
            end

            // Normal execution for other signals
            alu_select_out <= alu_select;
            mux1_select_out <= mux1_select;
            mux2_select_out <= mux2_select;
            mux3_select_out <= mux3_select;
            regwrite_enable_out <= regwrite_enable;
            mem_read_out <= mem_read;
            mem_write_out <= mem_write;
            branch_out <= branch;
            jump_out <= jump;
            jal_select_out <= jal_select;

            PC4_out <= PC4;
            PC_out <= PC;
            Immediate_out <= Immediate;
            Instruction_func3_out <= Instruction_func3;
            destination_reg_out <= destination_reg;
        end
    end
endmodule
