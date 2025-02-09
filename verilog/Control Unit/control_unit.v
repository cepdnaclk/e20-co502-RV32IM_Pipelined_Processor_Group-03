module control_unit(
    input[31:0] instruction,

    output reg[4:0] AlU_opcode,
    output reg mux1_select,  //PC Select
    output reg mux2_select,  //Imm Select
    output reg mux3_select,  //Data Mem Select
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
            7'b0110011:begin//R-type Instructions----------------------------------------
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

            //I-type Instructions-------------------------------------------------------
            //Load instructions (LB, LH, LW, LBU, LHU)
            7'b0000011: begin #1		            
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

            //ADDI, SLLI, SLTI, SLTIU, XORI, SLRI, SRAI, ORI, ANDI
            7'b0010011: begin #1		            
                imm_select = 3'b000;
                mux1_select = 1'b0;
                mux2_select = 1'b1;
                jal_select = 1'b0;
                mux3_select = 1'b0;
                regwrite_enable = 1'b1;
                mem_read = 1'b0;
                mem_write = 1'b0;
                branch = 1'b0;
                jump = 1'b0;   

                case(funct3)
                    3'b000: AlU_opcode = 5'b00000;               //ADDI
                    3'b001: begin                                //SLLI
                        case(funct7)
                            7'b0000000: AlU_opcode = 5'b00011;
                        endcase
                    end
                    
                    3'b010: AlU_opcode = 5'b00100;               //SLTI
                    3'b011: AlU_opcode = 5'b00101;               //SLTIU
                    3'b100: AlU_opcode = 5'b00110;               //XORI
                    3'b101: begin                                //SLRI, SRAI
                        case(funct7)
                            7'b0000000: AlU_opcode = 5'b00111;   //SRLI 
                            7'b0100000: AlU_opcode = 5'b01000;   //SRAI     
                        endcase                        
                    end
                    
                    3'b110: AlU_opcode = 5'b01001;                    //ORI
                    3'b111: AlU_opcode = 5'b01010;                    //ANDI
                endcase      
            end

            //JALR Instruction
            7'b1100111: begin #1                
                AlU_opcode = 5'b00000;
                imm_select = 3'b000;
                mux1_select = 1'b0;
                mux2_select = 1'b1;
                jal_select = 1'b1;
                mux3_select= 1'b0;
                regwrite_enable = 1'b1;
                mem_read = 1'b0;
                mem_write = 1'b0;
                branch = 1'b0;
                jump = 1'b1;             
            end

            //S-type Instructions---------------------------------------------------------
            //Store instructions (SB, SH, SW, SBU, SHU)
            7'b0100011: begin #1                
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

            //B-type instructions------------------------------------------------------ 
            7'b1100011: begin #1                
                AlU_opcode = 5'b00010;
                imm_select = 3'b011;
                mux1_select = 1'b1;
                mux2_select = 1'b1;
                jal_select = 1'b0;
                mux3_select= 1'bx;
                regwrite_enable = 1'b0;
                mem_read = 1'b0;
                mem_write = 1'b0;
                branch = 1'b1;
                jump = 1'b0;             
            end

            // J-type Insructions------------------------------------------------
            // JAL
            7'b1101111: begin #1                
                AlU_opcode = 5'b00001;
                imm_select = 3'b100;
                mux1_select = 1'b1;
                mux2_select = 1'b1;
                jal_select = 1'b1;
                mux3_select= 1'b0;
                regwrite_enable = 1'b1;
                mem_read = 1'b0;
                mem_write = 1'b0;
                branch = 1'b0;
                jump = 1'b1;             
            end

            // U-type instructions---------------------------------------------
            //AUIPC
            7'b0010111: begin #1                
                AlU_opcode = 5'b00001;
                imm_select = 3'b010;
                mux1_select = 1'b1;
                mux2_select = 1'b1;
                jal_select = 1'b0;
                mux3_select= 1'b0;
                regwrite_enable = 1'b1;
                mem_read = 1'b0;
                mem_write = 1'b0;
                branch = 1'b0;
                jump = 1'b0;             
            end

            //LUI
            7'b0110111: begin #1                
                AlU_opcode = 5'b00000;
                imm_select = 3'b010;
                mux1_select = 1'bx;
                mux2_select = 1'b1;
                jal_select = 1'b0;
                mux3_select= 1'b0;
                regwrite_enable = 1'b1;
                mem_read = 1'b0;
                mem_write = 1'b0;
                branch = 1'b0;
                jump = 1'b0;           
            end

        endcase
    end
endmodule