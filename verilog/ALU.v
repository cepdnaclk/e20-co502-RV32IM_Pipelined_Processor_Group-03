module Forward_unit(data2, result);
    input [31:0] data2;
    output [31:0] result;
    reg [31:0] result;
    always @(*) begin
        result = data2;
    end

endmodule