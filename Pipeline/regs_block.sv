`include "macros.vh"

module regs_block(
    // control signals
    input  wire                 clk,
    input  wire                 rst,
    // from WB
    input  wire [2:0]           dest,
    input  wire [`D_BITS - 1:0] result, 
    // from Read
    input  wire [2:0]           src1,
    input  wire [2:0]           src2,
    output reg  [`D_BITS - 1:0] op1,
    output reg  [`D_BITS - 1:0] op2
    );
    
reg [`D_BITS - 1:0] regs [7:0];

initial
begin
    for (integer i = 0; i <= 7; i++) 
        regs[i] <= 0;
end

always @(posedge clk)
begin
    if (!rst) 
    begin
        for (integer i = 0; i <= 7; i++) 
            regs[i] <= 0;
    end
    else 
    begin
        //WB
        regs[dest] <= result;
    end
end 
   
always @(*)
begin
    // Read
    op1 <= regs[src1];
    op2 <= regs[src2];
end

endmodule
