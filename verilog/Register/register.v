module register_file(data1,data2,addr1,addr2,write_enable,clk,reg_write_data,reset,write_reg_addr);
    input [4:0] addr1,addr2,write_reg_addr;
    input [31:0] reg_write_data;
    input R,clk,reset,write_enable;
    output [31:0] data1,data2;

    reg [31:0] register [31:0];

    assign data1 = register[addr1];
    assign data2 = register[addr2];

    always @ (posedge clk)
    begin
      if (reset == 1)
        begin
          for (i=0; i<32; i=i+1)
            register[i] <= 32'b0000_0000_0000_0000_0000_0000_0000_0000;
        end
      else
        begin
          if (write_enable == 1)
            begin
                register[write_reg_addr] <= reg_write_data;
            end
        end
    end
endmodule