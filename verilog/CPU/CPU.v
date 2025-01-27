`timescale 1ns / 1ps    

`include "Stages of the pipeline/instruction decode stage/instruction_decode.v"
`include "Stages of the pipeline/instruction fetch stage/instruction_fetch.v"
`include "Stages of the pipeline/Memory Access stage/memory_access.v"
`include "Stages of the pipeline/instruction execution stage/instruction_execution.v"


//pipeleine registors

`include "pipeline registers/IF registers/instructionfetch.v"
`include "pipeline registers/EX registers/Execution.v"
`include "pipeline registers/MA register/EX_MA.v"
`include "pipeline registers/WB register/MA_WB.v"


module CPU(
    input CLK,
);
    //implimenting the wires
    wire [31:0] pc_out_if, pc4_out_if, instruction_out_if;
    wire [31:0] write_data_out_if;
    wire [4:0] write_reg_out_if;
    wire reg_write_enable_out_if;

    // Instruction Decode Stage Signals
    wire [31:0] pc_out_id, pc4_out_id;
    wire [4:0] ALU_opcode_id;
    wire mux1_select_id, mux2_select_id, reg_write_enable_id, mem_write_enable_id, mem_read_enable_id, branch_id, jump_id, JAL_select_id;
    wire [31:0] immidiate_value_id, data1_id, data2_id;
    wire [2:0] funct3_id;
    wire [4:0] Rd_id;

    // Execution Stage Signals
    wire [4:0] ALU_select_ex;
    wire mux1_select_ex, mux2_select_ex, mux3_select_ex, regwrite_enable_ex, mem_write_enable_ex, mem_read_enable_ex, branch_ex, jump_ex, jal_select_ex;
    wire [31:0] PC4_ex, PC_ex, Immediate_ex, data1_ex, data2_ex;
    wire [2:0] Instruction_func3_ex;
    wire [4:0] destination_reg_ex;
    wire [31:0] ALUD_ex, ALU_result_ex, data2_out_ex;
    wire branch_control_out_ex;

    // Memory Access Stage Signals
    wire mem_write_ma, mem_read_ma, mux3_select_ma, regwrite_enable_ma;
    wire [31:0] ALU_out_ma, DATA_2_ma, read_data_ma;
    wire [2:0] func3_ma;
    wire [4:0] rd_ma;

    // Write-Back Stage Signals
    wire mux3_select_wb, regwrite_enable_wb;
    wire [31:0] ALU_out_wb, read_data_wb;
    wire [4:0] rd_wb;

    // Pipeline Registers
    Instfetch_registers IF_ID(
        .CLK(clk),
        .PC4(pc4_out_if),
        .PC(pc_out_if),
        .instruction(instruction_out_if),
        .instruction_out(instruction_out_id),
        .PC_out(pc_out_id),
        .PC4_out(pc4_out_id)
    );

    Execution_registers ID_EX(
        .CLK(clk),
        .alu_select(ALU_opcode_id),
        .mux1_select(mux1_select_id),
        .mux2_select(mux2_select_id),
        .mux3_select(mux3_select_id),
        .regwrite_enable(reg_write_enable_id),
        .mem_read(mem_read_enable_id),
        .mem_write(mem_write_enable_id),
        .branch(branch_id),
        .jump(jump_id),
        .jal_select(JAL_select_id),
        .PC4(pc4_out_id),
        .PC(pc_out_id),
        .Immediate(immidiate_value_id),
        .data1(data1_id),
        .data2(data2_id),
        .Instruction_func3(funct3_id),
        .destination_reg(Rd_id),
        .alu_select_out(ALU_select_ex),
        .mux1_select_out(mux1_select_ex),
        .mux2_select_out(mux2_select_ex),
        .mux3_select_out(mux3_select_ex),
        .regwrite_enable_out(regwrite_enable_ex),
        .mem_read_out(mem_read_enable_ex),
        .mem_write_out(mem_write_enable_ex),
        .branch_out(branch_ex),
        .jump_out(jump_ex),
        .jal_select_out(jal_select_ex),
        .PC4_out(PC4_ex),
        .PC_out(PC_ex),
        .Immediate_out(Immediate_ex),
        .data1_out(data1_ex),
        .data2_out(data2_ex),
        .Instruction_func3_out(Instruction_func3_ex),
        .desti nation_reg_out(destination_reg_ex)
    );

    EX_MA_register EX_MA(
        .CLK(clk),
        .mem_write(mem_write_enable_ex),
        .mem_read(mem_read_enable_ex),
        .MUX3_select(mux3_select_ex),
        .regwrite_enable(regwrite_enable_ex),
        .ALU_out(ALU_result_ex),
        .DATA_2(data2_out_ex),
        .func_3(Instruction_func3_ex),
        .rd(destination_reg_ex),
        .mem_write_out(mem_write_ma),
        .mem_read_out(mem_read_ma),
        .MUX3_select_out(mux3_select_ma),
        .regwrite_enable_out(regwrite_enable_ma),
        .ALU_out_out(ALU_out_ma),
        .DATA_2_out(DATA_2_ma),
        .func_3_out(func3_ma),
        .rd_out(rd_ma)
    );

    MA_WB_register MA_WB(
        .CLK(clk),
        .MUX3_select(mux3_select_ma),
        .regwrite_enable(regwrite_enable_ma),
        .ALU_out(ALU_out_ma),
        .read_data(read_data_ma),
        .rd(rd_ma),
        .MUX3_select_out(mux3_select_wb),
        .regwrite_enable_out(regwrite_enable_wb),
        .ALU_out_out(ALU_out_wb),
        .read_data_out(read_data_wb),
        .rd_out(rd_wb)
    );

    // Instruction Fetch Stage
    instruction_fetch IF(
        .CLK(clk),
        .RESET(reset),
        .ALUD(ALU_out_wb),
        .MEMD(read_data_wb),
        .Rd(rd_wb),
        .mux3_select(mux3_select_wb),
        .reg_write_enable(regwrite_enable_wb),
        .branch_control(branch_control_out_ex),
        .branch_address(ALU_result_ex),
        .write_data_out(write_data_out_if),
        .write_reg_out(write_reg_out_if),
        .reg_write_enable_out(reg_write_enable_out_if),
        .pc_out(pc_out_if),
        .pc4_out(pc4_out_if),
        .instruction_out(instruction_out_if)
    );

    // Instruction Decode Stage
    instruction_decode ID(
        .instruction(instruction_out_id),
        .clk(clk),
        .reset(reset),
        .wite_enable(reg_write_enable_out_if),
        .write_data(write_data_out_if),
        .write_reg(write_reg_out_if),
        .pc(pc_out_id),
        .pc4(pc4_out_id),
        .pc_out(pc_out_id),
        .pc4_out(pc4_out_id),
        .AlU_opcode(ALU_opcode_id),
        .mux1_select(mux1_select_id),
        .mux2_select(mux2_select_id),
        .reg_write_enable(reg_write_enable_id),
        .mem_write_enable(mem_write_enable_id),
        .mem_read_enable(mem_read_enable_id),
        .branch(branch_id),
        .jump(jump_id),
        .JAL_select(JAL_select_id),
        .immidiate_value(immidiate_value_id),
        .data1(data1_id),
        .data2(data2_id),
        .funct3(funct3_id),
        .Rd(Rd_id)
    );

    // Instruction Execution Stage
    instruction_execution EX(
        .ALU_select(ALU_select_ex),
        .mux1_select(mux1_select_ex),
        .mux2_select(mux2_select_ex),
        .mux3_select(mux3_select_ex),
        .regwrite_enable(regwrite_enable_ex),
        .memory_write_enable(mem_write_enable_ex),
        .memory_read_enable(mem_read_enable_ex),
        .branch(branch_ex),
        .jump(jump_ex),
        .jal_select(jal_select_ex),
        .pc4(PC4_ex),
        .pc(PC_ex),
        .immediate(Immediate_ex),
        .data1(data1_ex),
        .data2(data2_ex),
        .funct3(Instruction_func3_ex),
        .rd(destination_reg_ex),
        .ALUD(ALUD_ex),
        .ALU_result(ALU_result_ex),
        .data2_out(data2_out_ex),
        .funct3_out(Instruction_func3_ex),
        .rd_out(destination_reg_ex),
        .memory_read_enable_out(mem_read_enable_ex),
        .memory_write_enable_out(mem_write_enable_ex),
        .regwrite_enable_out(regwrite_enable_ex),
        .mux3_select_out(mux3_select_ex),
        .branch_control_out(branch_control_out_ex)
    );

    // Memory Access Stage
    memory_access MA(
        .clk(clk),
        .reset(reset),
        .mem_read(mem_read_ma),
        .mem_write(mem_write_ma),
        .mux3_select(mux3_select_ma),
        .regwrite_enable(regwrite_enable_ma),
        .alud(ALU_out_ma),
        .data2(DATA_2_ma),
        .func3(func3_ma),
        .rd(rd_ma),
        .mux3_select_out(mux3_select_ma),
        .regwrite_enable_out(regwrite_enable_ma),
        .alud_out(ALU_out_ma),
        .rd_out(rd_ma),
        .read_data(read_data_ma)
    );
    

endmodule