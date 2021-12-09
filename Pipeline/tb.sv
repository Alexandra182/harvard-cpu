`timescale 1ns / 1ps

`include "macros.vh"

module tb();
    
reg clk;
reg rst;

wire wr;
wire rd;

wire [`INSTR_BITS - 1:0] instruction;
reg  [`A_BITS - 1:0]     PC;

reg [`A_BITS - 1:0] addr;
reg [`D_BITS - 1:0] mdin;
reg [`D_BITS - 1:0] mdout;

cpu dut(
    .clk(clk),
    .rst(rst),
    .instr(instruction),
    .pc(PC)
    );
    
prog_memory pmem(
    .pc(PC),
    .instr(instruction)
);

data_memory dmem(
    .clk(clk),
    .write(wr),
    .read(rd),
    .address(addr),
    .mem_data_in(mdin),
    .mem_data_out(mdout)
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
    rst <= 0;
    #20 rst <= 1;
end

initial
begin
    #500 $stop;
end

initial
begin
    #5
    dut.REGBLOCK.regs[0] <= 2;
    dut.REGBLOCK.regs[1] <= 4;
end

endmodule
