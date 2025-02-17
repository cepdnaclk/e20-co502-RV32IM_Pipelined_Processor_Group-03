// Forwarding Unit Implementation for RISC-V Pipelined Processor

module Forwarding_Unit(
    input [4:0] ID_EX_rs1, ID_EX_rs2, // Source registers in EX stage
    input [4:0] EX_MEM_rd, MEM_WB_rd, // Destination registers from later stages
    input EX_MEM_regWrite, MEM_WB_regWrite, // Write-back control signals
    output reg [1:0] forwardA, forwardB // Forwarding control signals
);

    always @(*) begin
        // Default: No forwarding (00)
        forwardA = 2'b00;
        forwardB = 2'b00;
        
        // Forward from EX/MEM stage
        if (EX_MEM_regWrite && (EX_MEM_rd != 5'b0) && (EX_MEM_rd == ID_EX_rs1))
            forwardA = 2'b10;
        if (EX_MEM_regWrite && (EX_MEM_rd != 5'b0) && (EX_MEM_rd == ID_EX_rs2))
            forwardB = 2'b10;

        // Forward from MEM/WB stage (only if EX/MEM did not match)
        if (MEM_WB_regWrite && (MEM_WB_rd != 5'b0) && (MEM_WB_rd == ID_EX_rs1) && !(EX_MEM_regWrite && (EX_MEM_rd == ID_EX_rs1)))
            forwardA = 2'b01;
        if (MEM_WB_regWrite && (MEM_WB_rd != 5'b0) && (MEM_WB_rd == ID_EX_rs2) && !(EX_MEM_regWrite && (EX_MEM_rd == ID_EX_rs2)))
            forwardB = 2'b01;
    end
endmodule