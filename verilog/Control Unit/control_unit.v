// Advanced Computer Architecture (CO502)
// Design: Control Unit
// Group Number: 03
// E Numbers: E/20/369, E/20/381, E/20/385
// Last Modified: 04.12.2024

module controlunit(
    input [6:0] opcode,
    input [2:0] funct3,
    input [6:0] funct7,

    output reg [4:0] alu_select,
    output reg mux1_select,
    output reg mux2_select,
    output reg mux3_select,
    output reg istwoscompliment,
    output reg regwrite_enable,
    output reg mem_read,
    output reg mem_write,
    output reg branch,
    output reg jump,
    output reg jal_select,
    output reg imm_select
);

    always @(*) 
    begin
        case(opcode)

        7'b0110011: begin // R-type
            if (func7[4:0] == 5'b00000) begin
                case(funct3)
                    3'b000: begin // ADD
                        if (func7[6:5] == 2'b01) begin
                            alu_select = 5'b10000; //sub
                            mux1_select = 1'b0;
                            mux2_select = 1'b0;
                            mux3_select = 1'b0;
                            regwrite_enable = 1'b1;
                            mem_read = 1'b0;
                            mem_write = 1'b0;
                            branch = 1'b0;
                            jump = 1'b0;
                            jal_select = 1'b0;
                            imm_select = 1'b0;
                        end
                        else begin
                            alu_select = 5'b00000; //add
                            mux1_select = 1'b0;
                            mux2_select = 1'b0;
                            mux3_select = 1'b0;
                            regwrite_enable = 1'b1;
                            mem_read = 1'b0;
                            mem_write = 1'b0;
                            branch = 1'b0;
                            jump = 1'b0;
                            jal_select = 1'b0;
                            imm_select = 1'b0;
                        end
                      
                    end
                    3'b001: begin // SLL
                        alu_select = 5'b01101;
                        mux1_select = 1'b0;
                        mux2_select = 1'b0;
                        mux3_select = 1'b0;
                        regwrite_enable = 1'b1;
                        mem_read = 1'b0;
                        mem_write = 1'b0;
                        branch = 1'b0;
                        jump = 1'b0;
                        jal_select = 1'b0;
                        imm_select = 1'b0;
                    end
                    3'b010: begin // SLT
                        alu_select = 5'b01111;
                        mux1_select = 1'b0;
                        mux2_select = 1'b0;
                        mux3_select = 1'b0;
                        regwrite_enable = 1'b1;
                        mem_read = 1'b0;
                        mem_write = 1'b0;
                        branch = 1'b0;
                        jump = 1'b0;
                        jal_select = 1'b0;
                        imm_select = 1'b0;
                    end
                    3'b011: begin // SLTU
                        alu_select = 5'b10001;
                        mux1_select = 1'b0;
                        mux2_select = 1'b0;
                        mux3_select = 1'b0;
                        regwrite_enable = 1'b1;
                        mem_read = 1'b0;
                        mem_write = 1'b0;
                        branch = 1'b0;
                        jump = 1'b0;
                        jal_select = 1'b0;
                        imm_select = 1'b0;
                    end
                    3'b100: begin // XOR
                        alu_select = 5'b00001;
                        mux1_select = 1'b0;
                        mux2_select = 1'b0;
                        mux3_select = 1'b0;
                        regwrite_enable = 1'b1;
                        mem_read = 1'b0;
                        mem_write = 1'b0;
                        branch = 1'b0;
                        jump = 1'b0;
                        jal_select = 1'b0;
                        imm_select = 1'b0;
                    end
                    3'b101: begin // SRA
                        if (func7[6:5] == 2'b01) begin
                            alu_select = 5'b10010; //SRL
                            mux1_select = 1'b0;
                            mux2_select = 1'b0;
                            mux3_select = 1'b0;
                            regwrite_enable = 1'b1;
                            mem_read = 1'b0;
                            mem_write = 1'b0;   
                            branch = 1'b0;
                            jump = 1'b0;
                            jal_select = 1'b0;
                            imm_select = 1'b0;
                        end
                        else begin
                            alu_select = 5'b01110; //SRA
                            mux1_select = 1'b0;
                            mux2_select = 1'b0;
                            mux3_select = 1'b0;
                            regwrite_enable = 1'b1;
                            mem_read = 1'b0;
                            mem_write = 1'b0;
                            branch = 1'b0;
                            jump = 1'b0;
                            jal_select = 1'b0;
                            imm_select = 1'b0;
                        end
                    end
                      
                    3'b110: begin // OR
                        alu_select = 5'b00011;
                        mux1_select = 1'b0;
                        mux2_select = 1'b0;
                        mux3_select = 1'b0;
                        regwrite_enable = 1'b1;
                        mem_read = 1'b0;
                        mem_write = 1'b0;
                        branch = 1'b0;
                        jump = 1'b0;
                        jal_select = 1'b0;
                        imm_select = 1'b0;
                    end
                    3'b111: begin // AND
                        alu_select = 5'b00010;
                        mux1_select = 1'b0;
                        mux2_select = 1'b0;
                        mux3_select = 1'b0;
                        regwrite_enable = 1'b1;
                        mem_read = 1'b0;
                        mem_write = 1'b0;
                        branch = 1'b0;
                        jump = 1'b0;
                        jal_select = 1'b0;
                        imm_select = 1'b0;
                    end
                endcase
            end

            else if (func7[4:0] == 5'b00001) begin
                case(funct3)
                    3'b000: begin // MUL
                        alu_select = 5'b00100;
                        mux1_select = 1'b0;
                        mux2_select = 1'b0;
                        mux3_select = 1'b0;
                        regwrite_enable = 1'b1;
                        mem_read = 1'b0;
                        mem_write = 1'b0;
                        branch = 1'b0;
                        jump = 1'b0;
                        jal_select = 1'b0;
                        imm_select = 1'b0;
                    end
                    3'b001: begin // MULH
                        alu_select = 5'b00101;
                        mux1_select = 1'b0;
                        mux2_select = 1'b0;
                        mux3_select = 1'b0;
                        regwrite_enable = 1'b1;
                        mem_read = 1'b0;
                        mem_write = 1'b0;
                        branch = 1'b0;
                        jump = 1'b0;
                        jal_select = 1'b0;
                        imm_select = 1'b0;
                    end
                    3'b010: begin // MULHSU
                        alu_select = 5'b00111;
                        mux1_select = 1'b0;
                        mux2_select = 1'b0;
                        mux3_select = 1'b0;
                        regwrite_enable = 1'b1;
                        mem_read = 1'b0;
                        mem_write = 1'b0;
                        branch = 1'b0;
                        jump = 1'b0;
                        jal_select = 1'b0;
                        imm_select = 1'b0;
                    end
                    3'b011: begin // MULHU
                        alu_select = 5'b00110;
                        mux1_select = 1'b0;
                        mux2_select = 1'b0;
                        mux3_select = 1'b0;
                        regwrite_enable = 1'b1;
                        mem_read = 1'b0;
                        mem_write = 1'b0;
                        branch = 1'b0;
                        jump = 1'b0;
                        jal_select = 1'b0;
                        imm_select = 1'b0;
                    end
                    3'b100: begin // DIV
                        alu_select = 5'b01000;
                        mux1_select = 1'b0;
                        mux2_select = 1'b0;
                        mux3_select = 1'b0;
                        regwrite_enable = 1'b1;
                        mem_read = 1'b0;
                        mem_write = 1'b0;
                        branch = 1'b0;
                        jump = 1'b0;
                        jal_select = 1'b0;
                        imm_select = 1'b0;
                    end
                    3'b101: begin // DIVU
                        alu_select = 5'b01001;
                        mux1_select = 1'b0;
                        mux2_select = 1'b0;
                        mux3_select = 1'b0;
                        regwrite_enable = 1'b1;
                        mem_read = 1'b0;
                        mem_write = 1'b0;
                        branch = 1'b0;
                        jump = 1'b0;
                        jal_select = 1'b0;
                        imm_select = 1'b0;
                    end
                    3'b110: begin // REM
                        alu_select = 5'b01010;
                        mux1_select = 1'b0;
                        mux2_select = 1'b0;
                        mux3_select = 1'b0;
                        regwrite_enable = 1'b1;
                        mem_read = 1'b0;
                        mem_write = 1'b0;
                        branch = 1'b0;
                        jump = 1'b0;
                        jal_select = 1'b0;
                        imm_select = 1'b0;
                    end
                    3'b111: begin // REMU
                        alu_select = 5'b01011;
                        mux1_select = 1'b0;
                        mux2_select = 1'b0;
                        mux3_select = 1'b0;
                        regwrite_enable = 1'b1;
                        mem_read = 1'b0;
                        mem_write = 1'b0;
                        branch = 1'b0;
                        jump = 1'b0;
                        jal_select = 1'b0;
                        imm_select = 1'b0;
                    end
                endcase
            end
        end
        endcase
    end
endmodule



                        
            