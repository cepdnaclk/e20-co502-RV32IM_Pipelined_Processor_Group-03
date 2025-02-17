//Adding Stalls to avoid Hazards
module Hazard_Detection(
    input [4:0] ID_EX_rs1, ID_EX_rs2, EX_MEM_rd, MEM_WB_rd,
    input EX_MEM_memRead, MEM_WB_memRead,
    output reg stall
);
    always @(*) begin
        stall = 0;
        
        // Stall if a load-use hazard is detected and forwarding is not possible
        if (EX_MEM_memRead && ((EX_MEM_rd == ID_EX_rs1) || (EX_MEM_rd == ID_EX_rs2)))
            stall = 1;
        else if (MEM_WB_memRead && ((MEM_WB_rd == ID_EX_rs1) || (MEM_WB_rd == ID_EX_rs2)))
            stall = 1;
    end
endmodule
