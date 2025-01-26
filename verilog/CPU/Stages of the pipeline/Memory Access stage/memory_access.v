`include "../Data Memory/Data_Memory.v"

module memory_access(
    //inputs for memory access
    input clk,                 
    input reset,                
    input mem_read,             
    input mem_write,            
    input mux3_select,
    input regwrite_enable,
    input [31:0] alud,
    input [31:0] data2,
    input [2:0] func3,
    input [4:0] rd,

    //input ---> output
    output mux3_select_out,
    output regwrite_enable_out,
    output [31:0] alud_out,
    output [31:0] rd_out,

    //output
    output [31:0] read_data
           
);

wire [31:0] read_data;

Data_Memory data_memory(
    //inputs for memory access
    .clk(clk),
    .reset(reset),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .mem_address(alud),
    .data_in(data2),
    .busywait(),
    .func3(func3),
    //output from memory
    .data_out(read_data)

);
endmodule  