module control_unit(
    input[31:0] instruction,

    output reg[4:0] AlU_opcode,
    output reg mux1_select,
    output reg mux2_select,
    output reg mux3_select,
    output reg regwrite_enable,
    output reg mem_read,
    output reg mem_write,
    output reg branch,
    output reg jump,
    output reg jal_select,
    output reg[2:0] imm_select
);
    wire [6:0] opcode;
    wire [2:0] funct3;
    wire [6:0] funct7;
    
    assign opcode = instruction[6:0];   
    assign funct3 = instruction[14:12];
    assign funct7 = instruction[31:25];

    always @(opcode,funct7,funct3) begin
        case(opcode)
            7'b0110011:begin//R-type
                mux1_select = 1'b1;
                mux2_select = 1'b0;
                mux3_select = 1'b0;
                regwrite_enable = 1'b1;
                mem_read = 1'b0;
                mem_write = 1'b0;
                branch = 1'b0;
                jump = 1'b0;
                jal_select = 1'b0;
                imm_select = 3'b000;
                case({funct7,funct3})
                    10'b0000000000:AlU_opcode = 5'b00000;//ADD
                    10'b0100000000:AlU_opcode = 5'b10000;//SUB
                    10'b0000000001:AlU_opcode = 5'b01101;//SLL
                    10'b0000000010:AlU_opcode = 5'b01111;//SLT
                    10'b0000000011:AlU_opcode = 5'b10001;//SLTU
                    10'b0000000100:AlU_opcode = 5'b00001;//XOR
                    10'b0000000101:AlU_opcode = 5'b10010;//SRL
                    10'b0100000101:AlU_opcode = 5'b01110;//SRA
                    10'b0000000110:AlU_opcode = 5'b00011;//OR
                    10'b0000000111:AlU_opcode = 5'b00010;//AND
                    10'b0000001000:AlU_opcode = 5'b00100;//MUL
                    10'b0000001001:AlU_opcode = 5'b00101;//MULH
                    10'b0000001010:AlU_opcode = 5'b01011;//MULHSU
                    10'b0000001011:AlU_opcode = 5'b00110;//MULHU
                    10'b0000001100:AlU_opcode = 5'b01000;//DIV
                    10'b0000001101:AlU_opcode = 5'b01001;//DIVU
                    10'b0000001110:AlU_opcode = 5'b01010;//REM
                    10'b0000001111:AlU_opcode = 5'b01011;//REMU
                    default:AlU_opcode = 5'b00000;
                endcase
            end

            //I-type

            7'b0000011: begin #1		            //Load instructions (LB, LH, LW, LBU, LHU)
                AlU_opcode = 5'b00000;
                imm_select = 3'b000;
                mux1_select = 1'b0;
                mux2_select = 1'b1;
                jal_select = 1'b0;
                mux3_select = 1'b1;
                regwrite_enable = 1'b1;
                mem_read = 1'b1;
                mem_write = 1'b0;
                branch = 1'b0;
                jump = 1'b0;                    
            end

            7'b0100011: begin #1                //Store instructions (SB, SH, SW, SBU, SHU)
                AlU_opcode = 5'b00000;
                imm_select = 3'b001;
                mux1_select = 1'b0;
                mux2_select = 1'b1;
                jal_select = 1'b0;
                mux3_select= 1'bx;
                regwrite_enable = 1'b0;
                mem_read = 1'b0;
                mem_write = 1'b1;
                branch = 1'b0;
                jump = 1'b0;             
            end
        endcase
    end
endmodule