`include "../ALU/ALU.v"
`include "../branch control/branch_control.v"

module instruction_execution(
    //from control unit
    input [4:0]ALU_select,
    input mux1_select,
    input mux2_select,
    input mux3_select, //input --> output
    input regwrite_enable, //input --> output
    input memory_write_enable,//input --> output
    input memory_read_enable, // input --> output
    input branch,
    input jump,
    input jal_select,

    //other
    input [31:0] pc4,
    input [31:0] pc,
    input [31:0] immediate,
    input [31:0] data1,
    input [31:0] data2,
    input [2:0] funct3, //input --> output
    input [4:0] rd, //input --> output


    output [31:0] ALUD,
    output [31:0] ALU_result,
    output [31:0] data2_out,
    output [2:0] funct3_out,
    output [4:0] rd_out,

    output memory_read_enable_out,
    output memory_write_enable_out,
    output regwrite_enable_out,
    output mux3_select_out, //input --> output
    output branch_control_out
    

);

    //connecting ALU
    wire [31:0] mux1_out,mux2_out;
    assign mux1_out = (mux1_select == 1'b0) ? pc: data1;
    assign mux2_out = (mux2_select == 1'b0) ? data2: immediate;

    
    ALU_unit ALU_unit1(
        .Opcode(ALU_select),
        .data1(mux1_out),
        .data2(mux2_out),
        .result(ALU_result)

    );

    assign ALUD = (jal_select == 1'b0) ? pc4: ALU_result;

    //connecting branch control
    branch_control branch_control1(
        .jump(jump),
        .branch(branch),
        .funct3(funct3),
        .data1(data1),
        .data2(data2),
        .isJumpOrBranch(branch_control_out)
    );

    //input --> output
    assign memory_read_enable_out = memory_read_enable;
    assign memory_write_enable_out = memory_write_enable;
    assign regwrite_enable_out = regwrite_enable;
    assign mux3_select_out = mux3_select;
    assign funct3_out = funct3;
    assign rd_out = rd;
    assign data2_out = data2;




endmodule