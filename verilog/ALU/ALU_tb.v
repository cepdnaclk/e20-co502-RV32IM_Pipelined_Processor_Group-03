`timescale 1ps/1ps
`include "ALU.v"

module tb_ALU ;
    reg[31:0]DATA1,DATA2;
    reg[4:0]OPCODE;
    wire[31:0]ALU_OUTPUT;

    integer i;

    ALU_unit test_unit(OPCODE,DATA1,DATA2,ALU_OUTPUT);                       // initiating the alu module 
    initial begin
        $monitor("Time=%0t, Data1=%d, Data2=%d, Output=%d", $time, DATA1, DATA2,ALU_OUTPUT);

            
        DATA1 = 32'd6;
        DATA2 = 32'd3;
        OPCODE = 5'd0;
            

        for (i=0;i<=17;i++)
        begin
            OPCODE =i;
            #5;
        end
        $finish;
    end
    
endmodule