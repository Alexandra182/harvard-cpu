`include "macros.vh"

module pipe_reg
   #(parameter DATASIZE = 64) 
   (
    input  wire                 clk,
    input  wire                 rst,
    input  reg [DATASIZE - 1:0] din,
    output reg [DATASIZE - 1:0] dout
    );

always @(posedge clk) 
begin 
    if (!rst)
        dout <= 0;
    else
        dout <= din;
end
endmodule
