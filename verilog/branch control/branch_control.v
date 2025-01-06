module branch_control(
    input jump,
    input branch,
    input[2:0] funct3,
    input[31:0] data1,data2,


    output reg isJumpOrBranch
);

    always @(data1,data2,jump,branch,funct3) begin
        if(jump) begin
            isJumpOrBranch = 1'b1;
        end
        else if(branch)begin
            case(funct3)
                3'b000://beq
                    if((data1==data2)) begin
                        isJumpOrBranch = 1'b1;
                    end
                
                3'b001://bne
                    if((data1!=data2))begin
                        isJumpOrBranch = 1'b1;
                    end

                3'b010://blt
                    if(($signed(data1) < $signed(data2)))begin
                        isJumpOrBranch = 1'b1;
                    end

                3'b011://bge
                    if(($signed(data1) >= $signed(data2)))begin
                        isJumpOrBranch = 1'b1;
                    end

                3'b100:// bltu
                    if(($unsigned(data1) < $unsigned(data2)))begin
                        isJumpOrBranch = 1'b1;
                    end

                3'b111://bgeu
                    if(($unsigned(data1) >= $unsigned(data2)))begin
                        isJumpOrBranch = 1'b1;
                    end
                default:
                    isJumpOrBranch = 1'b0;
            endcase
        end
        else begin
            isJumpOrBranch = 1'b0;
        end
       
    end
endmodule