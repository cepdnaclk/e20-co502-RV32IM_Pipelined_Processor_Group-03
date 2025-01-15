module pc(CLK, RESET,pc_in, pc);
  input CLK, RESET;
  input [31:0] pc_in;
  output reg [31:0] pc;

  always @(posedge CLK) 
  begin
    if (RESET == 1'b1) 
    begin
      pc <= #1 0;
    end
    else 
    begin
      pc <= #1 pc_in;
    end
  end
endmodule

