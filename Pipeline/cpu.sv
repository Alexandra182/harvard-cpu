`include "macros.vh"

module cpu(
    input wire                      clk,
    input wire                      rst,
    input wire  [`INSTR_BITS - 1:0] instr,
    output reg  [`A_BITS - 1:0]     pc
    );

wire [`IR_BITS - 1:0] IR_in;
wire [`IR_BITS - 1:0] IR_out;
wire [`RR_BITS - 1:0] RR_in;
wire [`RR_BITS - 1:0] RR_out;
wire [`ER_BITS - 1:0] ER_in;
wire [`ER_BITS - 1:0] ER_out;

wire [2:0]           reg_src1;
wire [2:0]           reg_src2;
wire [`D_BITS - 1:0] reg_op1;
wire [`D_BITS - 1:0] reg_op2;

wire [2:0]           reg_dest;
wire [`D_BITS - 1:0] reg_result;  

fetch FETCH(
    .clk(clk),
    .rst(rst),
    .instr(instr),
    .PC(pc),
    .dout(IR_in)
    );
    
pipe_reg #(.DATASIZE(`IR_BITS)) IR(
    .clk(clk),
    .rst(clk),
    .din(IR_in),
    .dout(IR_out)
    );
    
read READ(
    .IR(IR_out),
    .dout(RR_in),
    .src1(reg_src1),
    .src2(reg_src2),
    .op1(reg_op1),
    .op2(reg_op2)
    );    
    
pipe_reg #(.DATASIZE(`RR_BITS)) RR(
    .clk(clk),
    .rst(clk),
    .din(RR_in),
    .dout(RR_out)
    );
    
exec EXEC(
    .din(RR_out),
    .dout(ER_in)
    );    

pipe_reg #(.DATASIZE(`ER_BITS)) ER(
    .clk(clk),
    .rst(clk),
    .din(ER_in),
    .dout(ER_out)
    );

wb WB(
    .din(ER_out),
    .dest(reg_dest),
    .value(reg_result)
    );
    
regs_block REGBLOCK(
    .clk(clk),
    .rst(clk),
    .dest(reg_dest),
    .result(reg_result), 
    .src1(reg_src1),
    .src2(reg_src2),
    .op1(reg_op1),
    .op2(reg_op2)
    );    
    
endmodule
