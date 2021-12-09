`include "macros.vh"

module exec(
    input  wire [`RR_BITS - 1:0] din, 
    output wire [`ER_BITS - 1:0] dout // ER_in
    );
    
reg  [`D_BITS - 1:0]     result;
wire [2:0]               dest;
wire [`INSTR_BITS - 1:0] instr;
wire [`D_BITS - 1:0]     op1;
wire [`D_BITS - 1:0]     op2;
wire [6:0]               opcode;
wire [5:0]               val;
reg                      write_en;

assign instr  = din[`RR_BITS - 1:64];
assign op1    = din[63:32];
assign op2    = din[31:0];
assign opcode = instr[15:9];
assign dest   = instr[8:6];
assign val    = instr[5:0];
assign dout   = {result, dest, write_en};
    
always @(*)
begin    
    if (instr == `NOP || instr == `HALT)
    begin
        write_en <= 0;
    end
    else 
    begin
        write_en <= 1; 
        case (opcode)
            `ADD:     result <= op1 + op2; 
            `ADDF:    result <= op1 + op2; 
            `SUB:     result <= op1 - op2; 
            `SUBF:    result <= op1 - op2; 
            `AND:     result <= op1 & op2; 
            `OR:      result <= op1 | op2; 
            `XOR:     result <= op1 ^ op2; 
            `NAND:    result <= !(op1 & op2); 
            `NOR:     result <= !(op1 | op2);
            `NXOR:    result <= !(op1 ^ op2); 
            `SHIFTR:  result <= op1 >> val; 
            `SHIFTRA: result <= op1 >> val; 
            `SHIFTL:  result <= op1 << val;
        endcase
    end
end
endmodule
