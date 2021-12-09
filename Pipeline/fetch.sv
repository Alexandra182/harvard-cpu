`include "macros.vh"

module fetch(
    input  wire                     clk,
    input  wire                     rst,
    input  wire [`INSTR_BITS - 1:0] instr,
    output reg  [`A_BITS - 1:0]     PC,
    output wire [`IR_BITS - 1:0]    dout // IR
    );

assign dout = instr;

initial
begin
    PC <= 0;
end

always @(posedge clk)
begin
    if (!rst)
        PC <= 0;
    else
    if (instr == `HALT)
        PC <= PC; // HALT
    else
        PC <= PC + 1; // ALU instructions & NOP
end
endmodule
