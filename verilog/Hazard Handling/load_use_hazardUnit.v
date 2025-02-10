module load_use_hazardUnit(
    input CLK,
    input RESET,
    input Load_signal,
    input [4:0] rd_out,
    input [4:0] addr1,
    input [4:0] addr2,

    output reg stall_signal,
    output reg forward_from_wb_to_rs1,
    output reg forward_from_wb_to_rs2
);
    wire [4:0] addr1_xnor_wire, addr2_xnor_wire;
    wire addr1_comparing_wire, addr2_comparing_wire, stall_signal_wire;

    //Identyfying the hazards
    assign addr1_xnor_wire = ~(addr1 ^ rd_out);
    assign addr2_xnor_wire = ~(addr2 ^ rd_out);
    //Comparing the addresses
    assign addr1_comparing_wire = (&addr1_xnor_wire);
    assign addr2_comparing_wire = (&addr2_xnor_wire);

    //Stall signal(Stall signal is high when Load signal is high and either of the address is same as the destination register)
    assign stall_signal_wire = (Load_signal & (addr1_comparing_wire | addr2_comparing_wire));

    //Forwarding signals
    always @(posedge CLK) begin
        if (Load_signal) begin
            forward_from_wb_to_rs1 = addr1_comparing_wire;
            forward_from_wb_to_rs2 = addr2_comparing_wire;
            stall_signal = stall_signal_wire;
        end
        else begin
            forward_from_wb_to_rs1 = 1'b0;
            forward_from_wb_to_rs2 = 1'b0;
            stall_signal = 1'b0;
        end
    end

    //reset all signals to zero when no hazard is detected
    always @(posedge RESET) begin
        forward_from_wb_to_rs1 = 0;
        forward_from_wb_to_rs2 = 0;
        stall_signal = 0;
    end
endmodule

