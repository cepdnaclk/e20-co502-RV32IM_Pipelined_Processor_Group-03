// Advanced Computer Architecture (CO502)
// Design: Shift Modules
// Group Number: 03
// E Numbers: E/20/369, E/20/381, E/20/385
// Last Modified: 10.12.2024


module mux2_1_32(
    input DATA1,
    input DATA2,
    input SELECTIONbit,
    output reg RESULT
);
    always @* begin
        if (SELECTIONbit == 1'b0) begin
            RESULT = DATA1;
        end else begin
            RESULT = DATA2;
        end
    end
endmodule

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Module for 32-bit left shift
// Logical shift left
module sll_32(
    output reg [31:0] RESULT,
    input [31:0] DATA1,
    input [4:0] DATA2
);
    wire [31:0] outputwires [4:0];

    // Using 5 levels of the mux. At each bit, shift operation is performed
    // Level 0: Shift by 1 bit
    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin
            if (i == 0)
                mux2_1_32 l0(.DATA1(DATA1[i]), .DATA2(1'b0), .SELECTIONbit(DATA2[0]), .RESULT(outputwires[0][i]));
            else
                mux2_1_32 l0(.DATA1(DATA1[i]), .DATA2(DATA1[i-1]), .SELECTIONbit(DATA2[0]), .RESULT(outputwires[0][i]));
        end
    endgenerate

    // Level 1: Shift by 2 bits
    generate
        for (i = 0; i < 32; i = i + 1) begin
            if (i < 2)
                mux2_1_32 l1(.DATA1(outputwires[0][i]), .DATA2(1'b0), .SELECTIONbit(DATA2[1]), .RESULT(outputwires[1][i]));
            else
                mux2_1_32 l1(.DATA1(outputwires[0][i]), .DATA2(outputwires[0][i-2]), .SELECTIONbit(DATA2[1]), .RESULT(outputwires[1][i]));
        end
    endgenerate

    // Level 2: Shift by 4 bits
    generate
        for (i = 0; i < 32; i = i + 1) begin
            if (i < 4)
                mux2_1_32 l2(.DATA1(outputwires[1][i]), .DATA2(1'b0), .SELECTIONbit(DATA2[2]), .RESULT(outputwires[2][i]));
            else
                mux2_1_32 l2(.DATA1(outputwires[1][i]), .DATA2(outputwires[1][i-4]), .SELECTIONbit(DATA2[2]), .RESULT(outputwires[2][i]));
        end
    endgenerate

    // Level 3: Shift by 8 bits
    generate
        for (i = 0; i < 32; i = i + 1) begin
            if (i < 8)
                mux2_1_32 l3(.DATA1(outputwires[2][i]), .DATA2(1'b0), .SELECTIONbit(DATA2[3]), .RESULT(outputwires[3][i]));
            else
                mux2_1_32 l3(.DATA1(outputwires[2][i]), .DATA2(outputwires[2][i-8]), .SELECTIONbit(DATA2[3]), .RESULT(outputwires[3][i]));
        end
    endgenerate

    // Level 4: Shift by 16 bits
    generate
        for (i = 0; i < 32; i = i + 1) begin
            if (i < 16)
                mux2_1_32 l4(.DATA1(outputwires[3][i]), .DATA2(1'b0), .SELECTIONbit(DATA2[4]), .RESULT(outputwires[4][i]));
            else
                mux2_1_32 l4(.DATA1(outputwires[3][i]), .DATA2(outputwires[3][i-16]), .SELECTIONbit(DATA2[4]), .RESULT(outputwires[4][i]));
        end
    endgenerate

    // Final Output
    always @* begin
        RESULT = outputwires[4];
    end
endmodule

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Module for 32-bit right shift
// Logical shift right
module slr_32(
    output reg [31:0] RESULT,
    input [31:0] DATA1,
    input [4:0] DATA2
);
    wire [31:0] outputwires [4:0];

    // Using 5 levels of the mux. At each bit, shift operation is performed
    // Level 0: Shift by 1 bit
    generate
        for (i = 0; i < 32; i = i + 1) begin
            if (i == 31)
                mux2_1_32 l0(.DATA1(DATA1[i]), .DATA2(1'b0), .SELECTIONbit(DATA2[0]), .RESULT(outputwires[0][i]));
            else
                mux2_1_32 l0(.DATA1(DATA1[i]), .DATA2(DATA1[i+1]), .SELECTIONbit(DATA2[0]), .RESULT(outputwires[0][i]));
        end
    endgenerate

    // Remaining levels (shift by 2, 4, 8, 16 bits)
    // Similar logic as above with appropriate indexing

    // Final Output
    always @* begin
        RESULT = outputwires[4];
    end
endmodule
