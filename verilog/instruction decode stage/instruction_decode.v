`include "../Control Unit/control_unit.v"
`include "../Register/register.v"
`include "../extend Immediate/immidiate.v"

module instruction_decode(
    input[31:0] instruction,
    input clk,
    input reset,

    input wite_enable,
    input [31:0] write_data,
    input [4:0] write_reg,

    //input ---> output
    input [31:0] pc,
    input[31:0] pc4,

    output [31:0] pc_out,
    output [31:0] pc4_out,

    //control unit output
    output [4:0] AlU_opcode,
    output mux1_select,
    output mux2_select,
    output reg_write_enable,
    output mem_write_enable,
    output mem_read_enable,
    output branch,
    output jump,
    output JAL_select,

    //extend immediate output
    output [31:0] immidiate_value,
    output [31:0] data1,
    output [31:0] data2,

    output [2:0] funct3,
    output [4:0] Rd
);
    wire [2:0] imm_select;
    //control unit
    control_unit control_unit(
        //input
        .instruction(instruction),
        //output
        .AlU_opcode(AlU_opcode),
        .mux1_select(mux1_select),
        .mux2_select(mux2_select),
        .regwrite_enable(reg_write_enable),
        .mem_read(mem_read_enable),
        .mem_write(mem_write_enable),
        .branch(branch),
        .jump(jump),
        .jal_select(JAL_select),
        .imm_select(imm_select)
    );

    //extend immediate
    immediate_extend immidiate(
        //input
        .instruction(instruction),
        .imm_select(imm_select),
        //output
        .immediate(immidiate_value)
    );

    //register file
    register_file register_file(
        //input
        .clk(clk),
        .reset(reset),
        .write_enable(write_enable),
        .reg_write_data(write_data),
        .write_reg_addr(write_reg),
        .addr1(instruction[19:15]),
        .addr2(instruction[24:20]),
        //output
        .data1(data1),
        .data2(data2)
    );

    assign funct3 = instruction[14:12];
    assign Rd = instruction[11:7];

endmodule