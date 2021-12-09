`include "macros.vh"

module prog_memory(
    input  [`A_BITS - 1:0] pc,
    output [15:0] instr
);

reg [15:0] progM[30:0]; 

assign instr = progM[pc];

initial 
begin
    progM[0]  = {`LOADC,     `R1, 8'd1       };    
    progM[1]  = {`LOADC,     `R0, 8'd2       };    
    progM[2]  = {`ADD,       `R2, `R1,  `R0  };
    progM[3]  = {`STORE,     `R3, 5'd0, `R0  };
    progM[4]  = {`SUB,       `R4, `R2,  `R1  };
    progM[5]  = {`SHIFTL,    `R4,       6'd4 };
    progM[6]  = {`SHIFTR,    `R4,       6'd3 };
    progM[7]  = {`ADDF,      `R5, `R4, `R2   };
    progM[8]  = {`SUBF,      `R6, `R4, `R3   };
    progM[9]  = {`AND,       `R0, `R1, `R2   };
    progM[10] = {`NAND,      `R0, `R1, `R2   };
    progM[11] = {`OR,        `R0, `R1, `R2   };
    progM[12] = {`XOR,       `R0, `R1, `R2   };
    progM[13] = {`NXOR,      `R0, `R1, `R2   };
    progM[14] = {`NOR,       `R0, `R1, `R2   };
    progM[15] = {`SHIFTRA,   `R6,       6'd1 };
    progM[16] = {`LOADC,     `R7,       8'd20};
    progM[17] = {`JMP,       9'd0,     `R7   };
    progM[18] = {`NOP                        };
    progM[19] = {`NOP                        };
    progM[20] = {`LOAD,      `R1, 5'd0, `R0  };
    progM[21] = {`JMPRcond, `Z, `R0,    6'd2 };
    progM[22] = {`NOP                        };
    progM[23] = {`NOP                        };
    progM[24] = {`JMPR,     6'd0,       6'd2 };
    progM[25] = {`NOP                        };
    progM[26] = {`NOP                        };
    progM[27] = {`HALT};
end

endmodule
