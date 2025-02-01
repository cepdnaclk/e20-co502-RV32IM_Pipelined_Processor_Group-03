// Advanced Computer Architecture (CO502)
// Design: Data Memory
// Group Number: 03
// E Numbers: E/20/369, E/20/381, E/20/385
// Last Modified: 16.12.2024

//256x32-bit data memory

`timescale 1ns/100ps

module Data_Memory(
    input clk,                  // Clock signal
    input reset,                // Reset signal
    input mem_read,             // Memory read enable
    input mem_write,            // Memory write enable
    input [31:0] mem_address,    // 10-bit address for 256 words
    input [31:0] data_in,       // Data to be written
    input [2:0] func3,          // Function code for memory access

    output reg [31:0] data_out, // Data to be read
    output reg busywait         // Busywait signal for memory access
);

    // Declare memory array (256 x 32-bit words)
    reg [31:0] memory_array [255:0];

    // Memory access signals
    reg mem_read_access, mem_write_access;

    // Detect memory access
    always @(mem_read or mem_write) begin
        busywait = (mem_read || mem_write) ? 1 : 0;
        mem_read_access = (mem_read && !mem_write) ? 1 : 0;
        mem_write_access = (!mem_read && mem_write) ? 1 : 0;
    end

    // Read operation
    always @(posedge clk) begin
        if (mem_read_access) begin
            data_out = #10 memory_array[mem_address]; // Read data with delay
            busywait = 0;
            mem_read_access = 0;
        end
    end

    // Write operation
    always @(posedge clk) begin
        if (mem_write_access) begin
            memory_array[mem_address] = #10 data_in; // Write data with delay
            busywait = 0;
            mem_write_access = 0;
        end
    end

    // Reset memory
    integer i;
    always @(posedge reset) begin
        if (reset) begin
            for (i = 0; i < 256; i = i + 1) begin
                memory_array[i] = 0;
            end
            busywait = 0;
            mem_read_access = 0;
            mem_write_access = 0;
        end
    end

    // Dump memory contents for debugging
    task dump_memory;
        integer j;
        begin
            for (j = 0; j < 256; j = j + 1) begin
                $display("Memory[%0d] = %0d", j, memory_array[j]);
            end
        end
    endtask

    initial begin
        //$dumpfile("DataMemory_wavedata.vcd");
        $dumpvars(1, clk, reset, mem_read, mem_write, mem_address, data_in, data_out, busywait);
    end

endmodule
