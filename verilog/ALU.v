module Add_unit(data1,data2,result);
    input [31:0] data1;
    input [31:0] data2;
    output [31:0] result;
    reg [31:0] result;
    always @(*) begin
        result = data1 + data2;
    end
endmodule

module XOR_unit(data1,data2,result);
    input [31:0] data1;
    input [31:0] data2;
    output [31:0] result;
    reg [31:0] result;
    always @(*) begin
        result = data1 ^ data2;
    end
endmodule

module AND_unit(data1,data2,result);
    input [31:0] data1;
    input [31:0] data2;
    output [31:0] result;
    reg [31:0] result;
    always @(*) begin
        result = data1 & data2;
    end
endmodule

module OR_unit(data1,data2,result);
    input [31:0] data1;
    input [31:0] data2;
    output [31:0] result;
    reg [31:0] result;
    always @(*) begin
        result = data1 | data2;
    end
endmodule

