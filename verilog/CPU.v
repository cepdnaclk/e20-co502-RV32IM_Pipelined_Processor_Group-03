// Advanced Computer Architecture (CO502)
// Design: Control Unit
// Group Number: 03
// E Numbers: E/20/369, E/20/381, E/20/385
// Last Modified: 13.12.2024

`timescale  1ns/100ps

`include "ALU.v"
`include "REGISTER.v"
`include "required.v"


module cpu (PC, INSTRUCTION, CLK, RESET, MEMREAD, MEMWRITE, ADDRESS, WRITEDATA, READDATA, BUSY,ICACHE_BUSY);  // ICACHE BUSY signal was added 
                                                                                                             // affects line at 85
    input CLK, RESET;
    input [31:0] INSTRUCTION;
    output reg [31:0] PC;

    // ALU Connections
    wire [31:0] OPERAND1, OPERAND2, ALURESULT;
    reg [6:0] ALUOP;

    // Register File Connections
    wire [5:0] READREG1, READREG2, WRITEREG;    //Addresses 5 bits
    wire [31:0] REGOUT1, REGOUT2;
    reg WRITEENABLE;

     // Reset and PC Handling
    always @ (posedge CLK) begin
        if(RESET == 1'b1) 
        begin
            #1
            PC = 0;
            //PCreg = 0;
        end else if (BUSY |ICACHE_BUSY) PC = PC;   
        else
            #1 PC = PCout;
    end


    // Control Unit Logic
    always @(INSTRUCTION) begin
        OPCODE = INSTRUCTION[6:0];

        case (OPCODE)
            7'b0110011: begin
                // Assign Values from R- Type Instruction (Opcode – 0110011)
                assign READREG1 = INSTRUCTION[19:15];
                assign READREG2 = INSTRUCTION[24:20];
                assign WRITEREG = INSTRUCTION[11:7];
                assign FUNCT7 = INSTRUCTION[31:25];
                assign FUNCT3 = INSTRUCTION[14:12];
                
                case (FUNCT3)
                    // Add and Sub
                    3'b000: begin
                        //ADD control signals
                        if FUNCT7 == 7'b0000000 begin
                            
                        end
                        if FUNCT7 == 7'b0100000 begin
                            
                        end

                    end

                    3'b000: 
                endcase
            end
        endcase

    end

    endmodule
