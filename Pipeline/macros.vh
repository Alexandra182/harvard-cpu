// Main parameters
`define D_BITS 32
`define A_BITS 10

// Pipeline registers sizes
`define INSTR_BITS 16 
`define IR_BITS    16
`define RR_BITS    2 * `D_BITS + 16
`define ER_BITS    `D_BITS + 4

// Register set
`define R0 3'd0
`define R1 3'd1
`define R2 3'd2
`define R3 3'd3
`define R4 3'd4
`define R5 3'd5
`define R6 3'd6
`define R7 3'd7

// OPcodes
`define HALT    16'hFFFF // 65535
`define NOP     16'h0000 // 0

`define ADD      7'b1001100 
`define ADDF     7'b1001011
`define SUB      7'b1001010
`define SUBF     7'b1001001
`define AND      7'b1001000
`define OR       7'b1000111
`define XOR      7'b1000110
`define NAND     7'b1000101
`define NOR      7'b1000100
`define NXOR     7'b1000011
`define SHIFTR   7'b1000010
`define SHIFTRA  7'b1000001
`define SHIFTL   7'b1000000

`define LOAD     5'b01110
`define LOADC    5'b01101
`define STORE    5'b01100

`define JMP      4'b0101
`define JMPR     4'b0100 

`define JMPcond  4'b0011
`define JMPRcond 4'b0010 

// conditions
`define N        3'b000
`define NN       3'b001
`define Z        3'b010
`define NZ       3'b011

// Memory
`define MEMSIZE  2**`A_BITS