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
    output reg imm_select,
);

    always @(*) begin
        case(opcode)

        7'b0110011: begin // R-type
            if (func7[4:0] == 5'b00000) begin
                case(funct3)
                    3'b000: begin // ADD
                        if (func[6:5] == 2'b01) begin
                            alu_select = 10000; //sub
                            mux1_select = 0;
                            mux2_select = 0;
                            mux3_select = 0;
                            regwrite_enable = 1;
                            mem_read = 0;
                            mem_write = 0;
                            branch = 0;
                            jump = 0;
                            jal_select = 0;
                            imm_select = 0;
                        end
                        else begin
                            alu_select = 00000; //add
                            mux1_select = 0;
                            mux2_select = 0;
                            mux3_select = 0;
                            regwrite_enable = 1;
                            mem_read = 0;
                            mem_write = 0;
                            branch = 0;
                            jump = 0;
                            jal_select = 0;
                            imm_select = 0;
                        end
                    end
                    3'b001: begin // SLL
                        alu_select = 01101;
                        mux1_select = 0;
                        mux2_select = 0;
                        mux3_select = 0;
                        regwrite_enable = 1;
                        mem_read = 0;
                        mem_write = 0;
                        branch = 0;
                        jump = 0;
                        jal_select = 0;
                        imm_select = 0;
                    end
                    3'b010: begin // SLT
                        alu_select = 01111;
                        mux1_select = 0;
                        mux2_select = 0;
                        mux3_select = 0;
                        regwrite_enable = 1;
                        mem_read = 0;
                        mem_write = 0;
                        branch = 0;
                        jump = 0;
                        jal_select = 0;
                        imm_select = 0;
                    end
                    3'b011: begin // SLTU
                        alu_select = 10001;
                        mux1_select = 0;
                        mux2_select = 0;
                        mux3_select = 0;
                        regwrite_enable = 1;
                        mem_read = 0;
                        mem_write = 0;
                        branch = 0;
                        jump = 0;
                        jal_select = 0;
                        imm_select = 0;
                    end
                    3'b100: begin // XOR
                        alu_select = 00001;
                        mux1_select = 0;
                        mux2_select = 0;
                        mux3_select = 0;
                        regwrite_enable = 1;
                        mem_read = 0;
                        mem_write = 0;
                        branch = 0;
                        jump = 0;
                        jal_select = 0;
                        imm_select = 0;
                    end
                    3'b101: begin // SRA
                        if (func[6:5] == 2'b01) begin
                            alu_select = 10010; //SRL
                            mux1_select = 0;
                            mux2_select = 0;
                            mux3_select = 0;
                            regwrite_enable = 1;
                            mem_read = 0;
                            mem_write = 0;
                            branch = 0;
                            jump = 0;
                            jal_select = 0;
                            imm_select = 0;
                        end
                        else begin
                            alu_select = 01110; //SRA
                            mux1_select = 0;
                            mux2_select = 0;
                            mux3_select = 0;
                            regwrite_enable = 1;
                            mem_read = 0;
                            mem_write = 0;
                            branch = 0;
                            jump = 0;
                            jal_select = 0;
                            imm_select = 0;
                        end
                    end
                      
                    3'b110: begin // OR
                        alu_select = 00011;
                        mux1_select = 0;
                        mux2_select = 0;
                        mux3_select = 0;
                        regwrite_enable = 1;
                        mem_read = 0;
                        mem_write = 0;
                        branch = 0;
                        jump = 0;
                        jal_select = 0;
                        imm_select = 0;
                    end
                    3'b111: begin // AND
                        alu_select = 00010;
                        mux1_select = 0;
                        mux2_select = 0;
                        mux3_select = 0;
                        regwrite_enable = 1;
                        mem_read = 0;
                        mem_write = 0;
                        branch = 0;
                        jump = 0;
                        jal_select = 0;
                        imm_select = 0;
                    end

                        
            