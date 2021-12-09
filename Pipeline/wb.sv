`include "macros.vh"

module wb(
    input  wire [`ER_BITS - 1:0] din,
    output wire [2:0]            dest,
    output wire [`D_BITS - 1:0]  value
    );

reg [`D_BITS - 1:0] val;
reg [2:0]           dst;

assign value = val;
assign dest  = dst;
        
always @(*)
begin   
    if (din[0] == 1) // check if the instr needs to write into a reg
    begin
        val <= din[`ER_BITS - 1:4];
        dst  <= din[3:1];
    end
end

endmodule
