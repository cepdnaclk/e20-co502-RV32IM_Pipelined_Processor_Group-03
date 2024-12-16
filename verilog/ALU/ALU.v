module Add_unit(data1,data2,result);
    input [31:0] data1;
    input [31:0] data2;
    output [31:0] result;

    assign result = data1 + data2;
endmodule

module XOR_unit(data1,data2,result);
    input [31:0] data1;
    input [31:0] data2;
    output [31:0] result;
    assign result = data1 ^ data2;
endmodule

module AND_unit(data1,data2,result);
    input [31:0] data1;
    input [31:0] data2;
    output [31:0] result;
    assign result = data1 & data2;
endmodule

module OR_unit(data1,data2,result);
    input [31:0] data1;
    input [31:0] data2;
    output [31:0] result;

    assign result = data1 | data2;
endmodule

module MUL_unit(data1,data2,result); //multplication of high instruction MULH
    input [31:0] data1;
    input [31:0] data2;
    output [31:0] result;
    
    reg [64:0] result1;
    always @(*) begin
        result1 = $signed(data1) * $signed(data2);
    end
    assign result = result1[31:0];
endmodule

module MULH_unit(data1,data2,result); //multplication of high instruction MULH
    input [31:0] data1;
    input [31:0] data2;
    output [31:0] result;
    reg [64:0] result1;
    always @(*) begin
        result1 = $signed(data1) * $signed(data2);
    
    end
    assign result = result1[63:32];
endmodule

module MULHU_unit(data1,data2,result); //multplication of high instruction MULHU (unsigned values)
    input [31:0] data1;
    input [31:0] data2;
    output [31:0] result;
    reg [63:0] result1;

    always @(*) begin
        result1 = $unsigned(data1) * $unsigned(data2);
    end
    assign result = result[63:32];
endmodule

module MULHSU_unit(data1,data2,result); //multplication of high instruction MULHSU (signed and unsigned values)
    input [31:0] data1;
    input [31:0] data2;
    output [31:0] result;
    reg [63:0] result1;
    always @(*) begin
        result1 = $signed(data1) * $unsigned(data2);
    end
    assign result = result1[63:32];
endmodule

module DIV_unit(data1,data2,result); //division instruction signed values
    input [31:0] data1;
    input [31:0] data2;
    output [31:0] result;

    assign result = $signed(data1) / $signed(data2);
endmodule

module DIVU_unit(data1,data2,result); //division instruction unsigned values
    input [31:0] data1;
    input [31:0] data2;
    output [31:0] result;

    assign result = $unsigned(data1) / $unsigned(data2);

endmodule

module REM_unit(data1,data2,result); //remainder instruction signed values
    input [31:0] data1;
    input [31:0] data2;
    output [31:0] result;

    assign result = $signed(data1) % $signed(data2);
endmodule

module REMU_unit(data1,data2,result); //remainder instruction unsigned values
    input [31:0] data1;
    input [31:0] data2;
    output [31:0] result;
    assign result = $unsigned(data1) % $unsigned(data2);
endmodule

module Forward_Unit(data2,result);
    input [31:0] data2;
    output [31:0] result;
    assign result = data2;
endmodule

module SLL_Unit(data1,data2,result);// logical left (to get logical write data 2 will be negative)
    input [31:0] data1;
    input [31:0] data2;
    output [31:0] result;
    assign result = data1 << data2;
endmodule

module SRA_Unit(data1,data2,result);// logical right (to get logical write data 2 will be negative)
    input [31:0] data1;
    input [31:0] data2;
    output [31:0] result;
    assign result = $signed(data1) >> data2;
endmodule

module SLT_Unit(data1,data2,result);// set less than
    input [31:0] data1;
    input [31:0] data2;
    output [31:0] result;

    assign result = (data1 < data2) ? 32'b1 : 32'b0;
    
endmodule

module ALU_unit(Opcode, data1, data2, result);
    input [4:0] Opcode;
    input [31:0] data1;
    input [31:0] data2;

    output  reg [31:0] result;

    wire [31:0] result00, result01, result02, result03, result04, result05, result06, result07, result08, result09, result10, result11, result12, result13, result14, result15;

    Add_unit add_unit(data1, data2, result00);
    XOR_unit xor_unit(data1, data2, result01);
    AND_unit and_unit(data1, data2, result02);
    OR_unit or_unit(data1, data2, result03);
    MUL_unit mul_unit(data1, data2, result04);
    MULH_unit mulh_unit(data1, data2, result05);
    MULHU_unit mulhu_unit(data1, data2, result06);
    MULHSU_unit mulhsu_unit(data1, data2, result07);
    DIV_unit div_unit(data1, data2, result08);
    DIVU_unit divu_unit(data1, data2, result09);
    REM_unit rem_unit(data1, data2, result10);
    REMU_unit remu_unit(data1, data2, result11);
    Forward_Unit forward_unit(data2, result12);
    SLL_Unit sll_unit(data1, data2, result13);
    SRA_Unit sra_unit(data1, data2, result14);
    SLT_Unit slt_unit(data1, data2, result15);

    //mux for selecting the result
    always @(*) begin
        case(Opcode)
            5'b00000: result = result00; // add
            5'b00001: result = result01; // xor
            5'b00010: result = result02; // and
            5'b00011: result = result03; // or
            5'b00100: result = result04; // mul
            5'b00101: result = result05; // mulh
            5'b00110: result = result06; // mulhu
            5'b00111: result = result07; // mulhsu
            5'b01000: result = result08; // div
            5'b01001: result = result09; // divu
            5'b01010: result = result10; // rem
            5'b01011: result = result11; // remu
            5'b01100: result = result12; // forward
            5'b01101: result = result13; // sll
            5'b01110: result = result14; // sra
            5'b01111: result = result15; // slt
            default: result = 32'bx;
        endcase
    end
endmodule