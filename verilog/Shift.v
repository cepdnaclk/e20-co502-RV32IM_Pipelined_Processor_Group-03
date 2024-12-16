// Advanced Computer Architecture (CO502)
// Design: Shift Modules
// Group Number: 03
// E Numbers: E/20/369, E/20/381, E/20/385
// Last Modified: 10.12.2024

module mux2_1_32(
    input  DATA1,
    input  DATA2,
    input  SELECTIONbit,
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


// Module for 32-bit left shift
// Logical shift left
module sll_32(
    output reg [31:0] RESULT,
    input [31:0] DATA1,
    input [4:0] DATA2 // 5 bits for shift amount, as 2^5 = 32
);
    wire [31:0] outputwires [4:0];

    // At 1st bit shift
    mux2_1_32 l1_0(.DATA1(DATA1[0]), .DATA2(1'b0), .SELECTIONbit(DATA2[0]), .RESULT(outputwires[0][0]));
    mux2_1_32 l1_1(.DATA1(DATA1[1]), .DATA2(DATA1[0]), .SELECTIONbit(DATA2[0]), .RESULT(outputwires[0][1]));
    mux2_1_32 l1_2(.DATA1(DATA1[2]), .DATA2(DATA1[1]), .SELECTIONbit(DATA2[0]), .RESULT(outputwires[0][2]));
    mux2_1_32 l1_3(.DATA1(DATA1[3]), .DATA2(DATA1[2]), .SELECTIONbit(DATA2[0]), .RESULT(outputwires[0][3]));
    mux2_1_32 l1_4(.DATA1(DATA1[4]), .DATA2(DATA1[3]), .SELECTIONbit(DATA2[0]), .RESULT(outputwires[0][4]));
    mux2_1_32 l1_5(.DATA1(DATA1[5]), .DATA2(DATA1[4]), .SELECTIONbit(DATA2[0]), .RESULT(outputwires[0][5]));
    mux2_1_32 l1_6(.DATA1(DATA1[6]), .DATA2(DATA1[5]), .SELECTIONbit(DATA2[0]), .RESULT(outputwires[0][6]));
    mux2_1_32 l1_7(.DATA1(DATA1[7]), .DATA2(DATA1[6]), .SELECTIONbit(DATA2[0]), .RESULT(outputwires[0][7]));
    mux2_1_32 l1_8(.DATA1(DATA1[8]), .DATA2(DATA1[7]), .SELECTIONbit(DATA2[0]), .RESULT(outputwires[0][8]));
    mux2_1_32 l1_9(.DATA1(DATA1[9]), .DATA2(DATA1[8]), .SELECTIONbit(DATA2[0]), .RESULT(outputwires[0][9]));
    mux2_1_32 l1_10(.DATA1(DATA1[10]), .DATA2(DATA1[9]), .SELECTIONbit(DATA2[0]), .RESULT(outputwires[0][10]));
    mux2_1_32 l1_11(.DATA1(DATA1[11]), .DATA2(DATA1[10]), .SELECTIONbit(DATA2[0]), .RESULT(outputwires[0][11]));
    mux2_1_32 l1_12(.DATA1(DATA1[12]), .DATA2(DATA1[11]), .SELECTIONbit(DATA2[0]), .RESULT(outputwires[0][12]));
    mux2_1_32 l1_13(.DATA1(DATA1[13]), .DATA2(DATA1[12]), .SELECTIONbit(DATA2[0]), .RESULT(outputwires[0][13]));
    mux2_1_32 l1_14(.DATA1(DATA1[14]), .DATA2(DATA1[13]), .SELECTIONbit(DATA2[0]), .RESULT(outputwires[0][14]));
    mux2_1_32 l1_15(.DATA1(DATA1[15]), .DATA2(DATA1[14]), .SELECTIONbit(DATA2[0]), .RESULT(outputwires[0][15]));
    mux2_1_32 l1_16(.DATA1(DATA1[16]), .DATA2(DATA1[15]), .SELECTIONbit(DATA2[0]), .RESULT(outputwires[0][16]));
    mux2_1_32 l1_17(.DATA1(DATA1[17]), .DATA2(DATA1[16]), .SELECTIONbit(DATA2[0]), .RESULT(outputwires[0][17]));
    mux2_1_32 l1_18(.DATA1(DATA1[18]), .DATA2(DATA1[17]), .SELECTIONbit(DATA2[0]), .RESULT(outputwires[0][18]));
    mux2_1_32 l1_19(.DATA1(DATA1[19]), .DATA2(DATA1[18]), .SELECTIONbit(DATA2[0]), .RESULT(outputwires[0][19]));
    mux2_1_32 l1_20(.DATA1(DATA1[20]), .DATA2(DATA1[19]), .SELECTIONbit(DATA2[0]), .RESULT(outputwires[0][20]));
    mux2_1_32 l1_21(.DATA1(DATA1[21]), .DATA2(DATA1[20]), .SELECTIONbit(DATA2[0]), .RESULT(outputwires[0][21]));
    mux2_1_32 l1_22(.DATA1(DATA1[22]), .DATA2(DATA1[21]), .SELECTIONbit(DATA2[0]), .RESULT(outputwires[0][22]));
    mux2_1_32 l1_23(.DATA1(DATA1[23]), .DATA2(DATA1[22]), .SELECTIONbit(DATA2[0]), .RESULT(outputwires[0][23]));
    mux2_1_32 l1_24(.DATA1(DATA1[24]), .DATA2(DATA1[23]), .SELECTIONbit(DATA2[0]), .RESULT(outputwires[0][24]));
    mux2_1_32 l1_25(.DATA1(DATA1[25]), .DATA2(DATA1[24]), .SELECTIONbit(DATA2[0]), .RESULT(outputwires[0][25]));
    mux2_1_32 l1_26(.DATA1(DATA1[26]), .DATA2(DATA1[25]), .SELECTIONbit(DATA2[0]), .RESULT(outputwires[0][26]));
    mux2_1_32 l1_27(.DATA1(DATA1[27]), .DATA2(DATA1[26]), .SELECTIONbit(DATA2[0]), .RESULT(outputwires[0][27]));
    mux2_1_32 l1_28(.DATA1(DATA1[28]), .DATA2(DATA1[27]), .SELECTIONbit(DATA2[0]), .RESULT(outputwires[0][28]));
    mux2_1_32 l1_29(.DATA1(DATA1[29]), .DATA2(DATA1[28]), .SELECTIONbit(DATA2[0]), .RESULT(outputwires[0][29]));
    mux2_1_32 l1_30(.DATA1(DATA1[30]), .DATA2(DATA1[29]), .SELECTIONbit(DATA2[0]), .RESULT(outputwires[0][30]));
    mux2_1_32 l1_31(.DATA1(DATA1[31]), .DATA2(DATA1[30]), .SELECTIONbit(DATA2[0]), .RESULT(outputwires[0][31]));

    // Todo: 2, 4, 8 , 16 bits

    always @* begin
        RESULT = outputwires[4];
    end
endmodule


// left shift using for loops
module sll_32_for(
    output reg [31:0] RESULT,
    input [31:0] DATA1,
    input [4:0] DATA2 // 5 bits for shift amount, as 2^5 = 32
);
    wire [31:0] outputwires [4:0];

    // At 1st bit shift
    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : level1
            if (i == 0) begin
                mux2_1_32 l1(.DATA1(DATA1[i]), .DATA2(1'b0), .SELECTIONbit(DATA2[0]), .RESULT(outputwires[0][i]));
            end else begin
                mux2_1_32 l1(.DATA1(DATA1[i]), .DATA2(DATA1[i-1]), .SELECTIONbit(DATA2[0]), .RESULT(outputwires[0][i]));
            end
        end
    endgenerate

    // At 2nd bit shift
    generate
        for (i = 0; i < 32; i = i + 1) begin : level2
            if (i < 2) begin
                mux2_1_32 l2(.DATA1(outputwires[0][i]), .DATA2(1'b0), .SELECTIONbit(DATA2[1]), .RESULT(outputwires[1][i]));
            end else begin
                mux2_1_32 l2(.DATA1(outputwires[0][i]), .DATA2(outputwires[0][i-2]), .SELECTIONbit(DATA2[1]), .RESULT(outputwires[1][i]));
            end
        end
    endgenerate

    // At 4th bit shift
    generate
        for (i = 0; i < 32; i = i + 1) begin : level3
            if (i < 4) begin
                mux2_1_32 l3(.DATA1(outputwires[1][i]), .DATA2(1'b0), .SELECTIONbit(DATA2[2]), .RESULT(outputwires[2][i]));
            end else begin
                mux2_1_32 l3(.DATA1(outputwires[1][i]), .DATA2(outputwires[1][i-4]), .SELECTIONbit(DATA2[2]), .RESULT(outputwires[2][i]));
            end
        end
    endgenerate

    // At 8th bit shift
    generate
        for (i = 0; i < 32; i = i + 1) begin : level4
            if (i < 8) begin
                mux2_1_32 l4(.DATA1(outputwires[2][i]), .DATA2(1'b0), .SELECTIONbit(DATA2[3]), .RESULT(outputwires[3][i]));
            end else begin
                mux2_1_32 l4(.DATA1(outputwires[2][i]), .DATA2(outputwires[2][i-8]), .SELECTIONbit(DATA2[3]), .RESULT(outputwires[3][i]));
            end
        end
    endgenerate

    // At 16th bit shift
    generate
        for (i = 0; i < 32; i = i + 1) begin : level5
            if (i < 16) begin
                mux2_1_32 l5(.DATA1(outputwires[3][i]), .DATA2(1'b0), .SELECTIONbit(DATA2[4]), .RESULT(outputwires[4][i]));
            end else begin
                mux2_1_32 l5(.DATA1(outputwires[3][i]), .DATA2(outputwires[3][i-16]), .SELECTIONbit(DATA2[4]), .RESULT(outputwires[4][i]));
            end
        end
    endgenerate

    always @* begin
        RESULT = outputwires[4];
    end
endmodule
