`include "macros.vh"

module seq_core(
    // general
    input 		             rst,   // active 0
    input		             clk,
    // program memory
    output reg [`A_BITS-1:0] pc,
    input  [15:0] instruction,
    // data memory
    output reg read,  // active 1
    output reg write, // active 1
    output reg [`A_BITS-1:0] address,
    input  reg [`D_BITS-1:0] data_in,
    output reg [`D_BITS-1:0] data_out
);

reg [`D_BITS-1:0] R[0:7];

always @(posedge clk, negedge rst) 
begin
    if (!rst) 
        begin
            pc <= 0;
            read <= 0;
            write <= 0;
            address <= 0;
            for (integer i = 0; i <= 7; i++) 
                R[i] <= 0;
        end 
    else 
    begin
        if (instruction == `NOP) 
        begin
            pc <= pc + 1; // NOP
            read <= 0;
            write <= 0;
        end
        else
        if (instruction == `HALT)
            pc <= pc; // HALT
        else 
        if (instruction[15:13] == 3'b100)
        begin
            read <= 0;
            write <= 0;
            pc <= pc + 1;
            case (instruction[15:9])
            `ADD:     R[instruction[8:6]] <= R[instruction[5:3]] + R[instruction[2:0]];
            `ADDF:    R[instruction[8:6]] <= R[instruction[5:3]] + R[instruction[2:0]];
            `SUB:     R[instruction[8:6]] <= R[instruction[5:3]] - R[instruction[2:0]];
            `SUBF:    R[instruction[8:6]] <= R[instruction[5:3]] - R[instruction[2:0]];
            `AND:     R[instruction[8:6]] <= R[instruction[5:3]] & R[instruction[2:0]];
            `OR:      R[instruction[8:6]] <= R[instruction[5:3]] | R[instruction[2:0]];
            `XOR:     R[instruction[8:6]] <= R[instruction[5:3]] ^ R[instruction[2:0]];
            `NAND:    R[instruction[8:6]] <= !(R[instruction[5:3]] & R[instruction[2:0]]);
            `NOR:     R[instruction[8:6]] <= !(R[instruction[5:3]] | R[instruction[2:0]]);
            `NXOR:    R[instruction[8:6]] <= !(R[instruction[5:3]] ^ R[instruction[2:0]]);
            `SHIFTR:  R[instruction[8:6]] <= R[instruction[8:6]] >> instruction[5:0];
            `SHIFTRA: R[instruction[8:6]] <= R[instruction[8:6]] >> instruction[5:0];
            `SHIFTL:  R[instruction[8:6]] <= R[instruction[8:6]] << instruction[5:0];
            endcase
        end
        else
        if (instruction[15:13] == 3'b011)
        begin
            case (instruction[15:11])
            `LOAD:  
            begin
                read <= 1;
                write <= 0;
                address <= R[instruction[2:0]][`A_BITS - 1:0];
                #20
                R[instruction[10:8]] <= data_in;
            end
            `LOADC: 
            begin
                read <= 0;
                write <= 0;
                R[instruction[10:8]] <= {R[instruction[10:8]][`D_BITS - 1:8], instruction[7:0]};
            end
            `STORE: 
            begin
                read <= 0;
                write <= 1;
                data_out <= R[instruction[2:0]];
                address <= R[instruction[10:8]][`A_BITS - 1:0];
            end
            endcase
            pc <= pc + 1;
        end
        else
        if (instruction[15:13] == 3'b010)
        begin
            read <= 0; 
            write <= 0;
            case (instruction[15:12])
            `JMP:  pc <= R[instruction[2:0]];
            `JMPR: pc <= pc + instruction[5:0];
            endcase
        end
        else
        if (instruction[15:13] == 3'b001) 
        begin
            read <= 0; 
            write <= 0;
            case (instruction[15:12])
            `JMPcond: 
                case (instruction[11:9])
                `N:  if(instruction[8:6] < 0)  pc <= R[instruction[2:0]];
                `NN: if(instruction[8:6] >= 0) pc <= R[instruction[2:0]];
                `Z:  if(instruction[8:6] == 0) pc <= R[instruction[2:0]];
                `NZ: if(instruction[8:6] != 0) pc <= R[instruction[2:0]];
                endcase
            `JMPRcond: 
                 case (instruction[11:9])
                `N:  if(instruction[8:6] < 0)  pc <= pc + instruction[5:0];
                `NN: if(instruction[8:6] >= 0) pc <= pc + instruction[5:0];
                `Z:  if(instruction[8:6] == 0) pc <= pc + instruction[5:0];
                `NZ: if(instruction[8:6] != 0) pc <= pc + instruction[5:0];
                endcase
            endcase
        end
    end
end
  
endmodule