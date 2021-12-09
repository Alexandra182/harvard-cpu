`include "macros.vh"

module data_memory(
    input                      clk,
    input                      write,
    input                      read,
    input  reg [`A_BITS - 1:0] address,
    input  reg [`D_BITS - 1:0] mem_data_in,
    output reg [`D_BITS - 1:0] mem_data_out
);

reg [`D_BITS - 1:0] M[0:`MEMSIZE-1];

always @(*)
    if (write) 
        M[address] <= mem_data_in;
    else if (read)
        mem_data_out <= M[address];

endmodule