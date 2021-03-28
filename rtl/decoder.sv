//---------------------------------------------------------
// File Name : decoder.sv
// Function : picoMIPS instruction decoder
// Author: tjk
// ver 1: // only NOP, ADD, ADDI,
// Modified By : Peter Alexander
// Last rev. 26 March 2021
//--------------------------------------------------------- 

`include "alucodes.sv"
`include "opcodes.sv"

module decoder(
    input logic [5:0] opcode,           // Opcode from instruction
    input logic [3:0] alu_flags,        // ALU flags

    output logic imm,                   // Selects imm as ALU B inputns
    output logic [2:0] alu_func,        // Control signals for ALU
    output logic w,                     // Write enable for registers
    output logic pc_incr, pc_relbranch  // Controls for program counter
);

timeunit 1ns; timeprecision 10ps;

// Control flag generation
always_comb
  begin
    // Set default values for all signals
    pc_incr = 1'b1;
    pc_relbranch = 1'b0;

    w = 1'b0;
    imm = 1'b0;

    // Route lower half of opcode to ALU as alufunc
    alu_func = opcode[2:0];

    case(opcode)
      `NOP: ;                                     // Do nothing
      `ADD, `MOV, `MULL:  w = 1'b1;               // Enable register write back

      `ADDI:  begin           
                          w = 1'b1;               // Enable register write back 
                          imm = 1'b1;
      end


      `BEQ:   if(alu_flags[1] == 1'b1) begin      // If ALU Zero flag is set
                          pc_incr = 1'b0;         // Enable relative branching in PC
                          pc_relbranch = 1'b1;
      end


      `BNE:   if(alu_flags[1] == 1'b0) begin      // If ALU Zero flag is NOT set
                          pc_incr = 1'b0;         // Enable relative branching in PC
                          pc_relbranch = 1'b1;
      end

      
      default:  $error("Unimplemented Opcode: %6d", opcode);
    endcase

  end // always_comb

endmodule // prog