// module PipelineHazardUnit(
//     input [4:0] Rs1_E, Rs2_E, RD_M, RD_WB, // Register operands
//     input RegWrite_M, RegWrite_WB, MemRead_M, // Control signals
//     output reg [1:0] ForwardA, ForwardB, // Forwarding control
//     output reg Stall // Stall signal
// );

// always @(*) begin
//     // Default: No forwarding or stalls
//     ForwardA = 2'b00;
//     ForwardB = 2'b00;
//     Stall = 0;

//     // EX-EX Forwarding (Higher Priority)
//     if (RegWrite_M && (RD_M != 0)) begin
//         if (RD_M == Rs1_E) ForwardA = 2'b10; // Forward ALU result to Rs1
//         if (RD_M == Rs2_E) ForwardB = 2'b10; // Forward ALU result to Rs2
//     end

//     // MEM-EX Forwarding
//     if (RegWrite_WB && (RD_WB != 0)) begin
//         if (RD_WB == Rs1_E && !(RegWrite_M && (RD_M == Rs1_E))) 
//             ForwardA = 2'b01; // Forward MEM/WB value to Rs1
//         if (RD_WB == Rs2_E && !(RegWrite_M && (RD_M == Rs2_E))) 
//             ForwardB = 2'b01; // Forward MEM/WB value to Rs2
//     end

//     // Stall for Load-Use Hazard (When Forwarding Fails)
//     if (MemRead_M && ((RD_M == Rs1_E) || (RD_M == Rs2_E))) begin
//         Stall = 1;
//     end
// end

// endmodule

module PipelineHazardUnit(
    input [4:0] Rs1_E, Rs2_E, RD_M, RD_WB, // Register operands
    input RegWrite_M, RegWrite_WB, MemRead_M, // Control signals
    output reg [1:0] ForwardA, ForwardB, // Forwarding control
    output reg Stall // Stall signal
);

always @(*) begin
    // Default: No forwarding or stalls
    ForwardA = 2'b00;
    ForwardB = 2'b00;
    Stall = 0;

    // MEM-EX Forwarding (Higher Priority) - When ALU result is available in MEM stage
    if (RegWrite_M && (RD_M != 0)) begin
        // Forward ALU result to Rs1 if RD_M matches Rs1_E
        if (RD_M == Rs1_E) ForwardA = 2'b10;
        // Forward ALU result to Rs2 if RD_M matches Rs2_E
        if (RD_M == Rs2_E) ForwardB = 2'b10;
    end

    // MEM-EX Forwarding - Forward data from WB stage if MEM forwarding is not possible
    if (RegWrite_WB && (RD_WB != 0)) begin
        // Forward data from WB stage to Rs1 if RD_WB matches Rs1_E, and MEM stage doesn't forward
        if (RD_WB == Rs1_E && !(RegWrite_M && (RD_M == Rs1_E))) 
            ForwardA = 2'b01; // Forward MEM/WB value to Rs1
        // Forward data from WB stage to Rs2 if RD_WB matches Rs2_E, and MEM stage doesn't forward
        if (RD_WB == Rs2_E && !(RegWrite_M && (RD_M == Rs2_E))) 
            ForwardB = 2'b01; // Forward MEM/WB value to Rs2
    end

    // Stall for Load-Use Hazard (When Forwarding Fails) - If data is not forwarded from MEM stage
    if (MemRead_M && ((RD_M == Rs1_E) || (RD_M == Rs2_E))) begin
        Stall = 1; // Stall if load-use hazard is detected (waiting for data from MEM stage)
    end
end

endmodule

