`include "CPU.v"

module CPUtb;
    reg CLK;
    reg reset;

    CPU mycpu(
        .CLK(CLK), 
        .RESET(reset)
    );
	
    initial
    begin   
        // generate files needed to plot the waveform using GTKWave
 
        CLK = 1'b0;	
        reset = 1'b1;
        #9
        reset = 1'b0;
		#15000;
		$finish;
        
    end

    initial
    begin
        $dumpfile("cputb_dump.vcd");
	    $dumpvars(0, CPUtb);
    end
    
// clock genaration.
always begin
    #8 CLK = ~CLK;
end

// Monitor signals
    // initial begin
    //     $monitor("Time: %0t | PC (IF): %h | Instruction (IF): %h | ALU Result (EX): %h | Read Data (MA): %h | Write Data (WB): %h",
    //              $time, uut.pc_out_if, uut.instruction_out_if, uut.ALU_result_ex, uut.read_data_ma, uut.write_data_out_if);
    // end

endmodule