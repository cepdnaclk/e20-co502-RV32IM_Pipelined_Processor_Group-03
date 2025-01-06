module immediate_extend(
    input[31:0] instruction,
    input[2:0] imm_select,

    output reg[31:0] immediate
);
    
    always @(instruction,imm_select) begin
        case(imm_select)
            3'b000: immediate = {{21{instruction[31]}},instruction[30:25],instruction[24:21],instruction[20]};
            3'b001: immediate = {{21{instruction[31]}},instruction[30:25],instruction[11:8],instruction[7]};
            3'b010: immediate = {{12{instruction[31]}},instruction[19:12],instruction[20],instruction[30:25],instruction[24:21],1'b0};
            3'b011: immediate = {instruction[31],instruction[30:20],instruction[19:12],12'b0};
            3'b100: immediate = {{20{instruction[31]}},instruction[7],instruction[30:25],instruction[11:8],1'b0};
        endcase
    end
endmodule