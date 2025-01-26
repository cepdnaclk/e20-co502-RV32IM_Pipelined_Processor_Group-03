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
    

endmodule