`include "macros.vh"

module read(
    input  wire [15:0]           IR,
    output reg  [`RR_BITS - 1:0] dout, // RR_in
    output reg  [2:0]            src1,
    output reg  [2:0]            src2,
    input  wire [`D_BITS - 1:0]  op1,
    input  wire [`D_BITS - 1:0]  op2
    );
   
always @(*)
begin 
    if (IR[15:0] == `NOP)
    begin
        dout <= 0;
    end
    else
    begin
        if (IR[15:13] == 3'b100) // ALU instructions
        begin
             if ((IR[15:9] == 7'b1000000) | (IR[15:9] == 7'b1000001) | (IR[15:9] == 7'b1000010)) // SHIFT instructions
             begin
                // one operand
                src1 <= IR[8:6];
             end
             else 
             begin
                // two operands
                src1 <= IR[5:3];
                src2 <= IR[2:0];
             end
        end 
        dout <= {IR, op1, op2};
    end 
end 
   
endmodule
