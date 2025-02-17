`include "../ALU/ALU.v"
`include "../branch control/branch_control.v"
`include "../Hazard_Unit/load_use_hazard.v"
`include "../Hazard_Unit/Forwarding_Unit.v"
`include "../Hazard_Unit/Hazard_Detection.v"

module instruction_execution(
    //from control unit
    input [4:0]ALU_select,
    input mux1_select,
    input mux2_select,
    input mux3_select, 
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
    input [4:0] rs1, rs2, rd, // Register addresses
    input [4:0] EX_MEM_rd, MEM_WB_rd, // Forwarding sources
    input EX_MEM_regWrite, MEM_WB_regWrite,
    input EX_MEM_memRead, MEM_WB_memRead,
    input [2:0] funct3,

    output [31:0] ALUD,
    output [31:0] ALU_result,
    output [31:0] data2_out,
    output [2:0] funct3_out,
    output [4:0] rd_out,

    output memory_read_enable_out,
    output memory_write_enable_out,
    output regwrite_enable_out,
    output mux3_select_out, 
    output branch_control_out,
    output stall // Stall signal from hazard detection
);

    // Forwarding Unit
    wire [1:0] forwardA, forwardB;
    Forwarding_Unit FU(
        .ID_EX_rs1(rs1), 
        .ID_EX_rs2(rs2),
        .EX_MEM_rd(EX_MEM_rd), 
        .MEM_WB_rd(MEM_WB_rd),
        .EX_MEM_regWrite(EX_MEM_regWrite), 
        .MEM_WB_regWrite(MEM_WB_regWrite),
        .forwardA(forwardA), 
        .forwardB(forwardB)
    );

    // Hazard Detection Unit
    Hazard_Detection HDU(
        .ID_EX_rs1(rs1), 
        .ID_EX_rs2(rs2),
        .EX_MEM_rd(EX_MEM_rd), 
        .MEM_WB_rd(MEM_WB_rd),
        .EX_MEM_memRead(EX_MEM_memRead), 
        .MEM_WB_memRead(MEM_WB_memRead),
        .stall(stall)
    );

    // Connecting ALU with forwarding logic
    wire [31:0] mux1_out, mux2_out;
    reg [31:0] operandA, operandB;
    
    always @(*) begin
        case (forwardA)
            2'b10: operandA = ALU_result;
            2'b01: operandA = data1;
            default: operandA = (mux1_select == 1'b0) ? pc : data1;
        endcase

        case (forwardB)
            2'b10: operandB = ALU_result;
            2'b01: operandB = data2;
            default: operandB = (mux2_select == 1'b0) ? data2 : immediate;
        endcase
    end

    ALU_unit ALU_unit1(
        .Opcode(ALU_select),
        .data1(operandA),
        .data2(operandB),
        .result(ALU_result)
    );

    assign ALUD = (jal_select == 1'b0) ? pc4 : ALU_result;

    // Connecting branch control
    branch_control branch_control1(
        .jump(jump),
        .branch(branch),
        .funct3(funct3),
        .data1(operandA),
        .data2(operandB),
        .isJumpOrBranch(branch_control_out)
    );

    // Input --> Output
    assign memory_read_enable_out = memory_read_enable;
    assign memory_write_enable_out = memory_write_enable;
    assign regwrite_enable_out = regwrite_enable;
    assign mux3_select_out = mux3_select;
    assign funct3_out = funct3;
    assign rd_out = rd;
    assign data2_out = data2;

endmodule
