`include "macros.vh"

module prog_memory(
    input  [`A_BITS - 1:0] pc,
    output [15:0] instr
);

reg [15:0] progM[31:0]; 

assign instr = progM[pc];

initial 
begin
    progM[0]  = {`ADD,       `R2, `R1,  `R0 };
    progM[1]  = {`SUB,       `R4, `R1,  `R0 };
    progM[2]  = {`SHIFTL,    `R1,       6'd4};
    progM[3]  = {`SHIFTR,    `R0,       6'd3};
    progM[4]  = {`ADDF,      `R5, `R4, `R2  };
    progM[5]  = {`SUBF,      `R6, `R4, `R3  };
    progM[6]  = {`AND,       `R0, `R2, `R4  };
    progM[7]  = {`NAND,      `R0, `R2, `R4  };
    progM[8]  = {`OR,        `R0, `R2, `R4  };
    progM[9] =  {`XOR,       `R0, `R2, `R4  };
    progM[10] = {`NXOR,      `R0, `R2, `R4  };
    progM[11] = {`NOR,       `R0, `R2, `R4  };
    progM[12] = {`SHIFTRA,   `R6,       6'd1};
    progM[13] = {`NOP};
    progM[14] = {`HALT};
end

endmodule