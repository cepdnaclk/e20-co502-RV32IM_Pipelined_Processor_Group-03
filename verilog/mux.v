// MUX modlue for CPU use

module mux(IN1, IN2, SELECT, OUT);
    input[31:0] IN1, IN2;
    input SELECT;
    output reg [31:0] OUT;

    always @ (IN1, IN2, SELECT)
    begin
        if(SELECT == 1'b0)
            OUT = IN1
        else
            OUT = IN2
    end

endmodule