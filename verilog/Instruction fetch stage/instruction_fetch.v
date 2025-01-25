`include "../PC/PC.v"
`include "../instruction memory/instruction_memory.v"


module instruction_fetch(
    input CLK,
    input RESET,
    input [31:0] ALUD,
    input [31:0] MEMD,
    input [4:0] Rd,
    input mux3_select,
    input reg_write_enable,
    input branch_control, //selecting the instruction to be fetched is branch,jump or not
    input [31:0] branch_address, //branch address to be fetched

    output [31:0] write_data_out,
    output [4:0] write_reg_out, //rd is a input and output
    output reg_write_enable_out, //reg_write enable is a input and output
    output [31:0] pc_out,
    output [31:0] pc4_out,
    output [31:0] instruction_out
);

    //write data out -- register data to be written
    assign write_data_out = (mux3_select == 1'b0) ? ALUD : MEMD;
    assign write_reg_out = Rd;
    assign reg_write_enable_out = reg_write_enable;

    wire [31:0] pc_input;
    //mux to select the pc input
    assign pc_input = (branch_control == 1'b1) ? branch_address : pc4_out;

    //pc module
    pc pc1(CLK, RESET, pc_input, pc_out);

    //pc+4
    assign pc4_out = pc_out + 4;
    
    //instruction memory module
    instruction_memory instruction_memory1(CLK, pc_out, RESET, instruction_out);

    



endmodule
