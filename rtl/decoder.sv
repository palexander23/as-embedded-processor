//---------------------------------------------------------
// File Name : decoder.sv
// Function : picoMIPS instruction decoder
// Author: tjk
// ver 1: // only NOP, ADD, ADDI,
// Modified By : Peter Alexander
// Last rev. 26 March 2021
//--------------------------------------------------------- 

`include "opcodes.sv"

module decoder(
    input logic [1:0] opcode,           // Opcode from instruction
    input logic z,

    output logic acc_en, acc_add,       // Accumulator control 
    output logic in_en,                 // SW input control 
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

    acc_en = 1'b0;
    acc_add = 1'b0;

    in_en = 1'b0;

    case(opcode)
      
      `ACCI: begin
        acc_en = 1'b1;
        in_en = 1'b1;
        w = 1'b1;
      end

      `MACI: begin
        acc_en = 1'b1;
        acc_add = 1'b1;
        w = 1'b1;
      end      
      
      `BEQ:   if(z == 1'b1) begin       // If ALU Zero flag is set
        pc_incr = 1'b0;                 // Enable relative branching in PC
        pc_relbranch = 1'b1;
        acc_en = 1'b0;
      end

      `BNE:   if(z == 1'b0) begin       // If ALU Zero flag is NOT set
        pc_incr = 1'b0;                 // Enable relative branching in PC
        pc_relbranch = 1'b1;
        acc_en = 1'b0;
      end

      default:  $error("Unimplemented Opcode: %6d", opcode);
    endcase

  end // always_comb

endmodule // prog