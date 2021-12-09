`timescale 1ns / 1ps

`include "macros.vh"
`include "memory.sv"
`include "seq_core.sv"

module seq_core_tb;

reg                 clk;
reg                 rst;
reg                 read;
reg                 write;
reg          [15:0] instr;
reg [`A_BITS - 1:0] addr;
reg [`A_BITS - 1:0] PC;
reg [`D_BITS - 1:0] data_in;
reg [`D_BITS - 1:0] data_out; 

seq_core cpu(
    // general
    .rst         (rst),   // active 0
    .clk         (clk),
    
    // program memory
    .pc          (PC),
    .instruction (instr),
    
    // data memory
    .read        (read),  // active 1
    .write       (write), // active 1
    .address     (addr),
    .data_in     (data_in),
    .data_out    (data_out)
);

memory mem(
    .clk          (clk),
    .write        (write),
    .read         (read),
    .address      (addr),
    .mem_data_in  (data_out),
    .mem_data_out (data_in)
);

prog_memory pmem(
    .pc           (PC),
    .instr        (instr)
);

// Generating the clock signal
initial
begin
	clk <= 1;
	forever
		begin
		#10 clk <= ~clk;
		end
end

initial
begin
    rst <= 1;
    #20 rst <= 0;
    #20 rst <= 1;
end

// Ending the simulation
initial begin
    repeat (250) @(posedge clk);
    $stop;
end

endmodule
