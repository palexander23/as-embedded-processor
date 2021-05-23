//-----------------------------------------------------
// File Name : prog.sv
// Function : Program memory p_size x i_size - reads from file prog.hex
// Author: tjk, 
// Modified By : Peter Alexander
// Last rev. 25 March 2021
//------------------------------
//-----------------------------------------------------
module prog #(parameter p_size = 6, i_size = 24) // p_size - address width, i_size - instruction width
(input logic [p_size-1:0] address,
output logic [i_size-1:0] instr); // I - instruction code

timeunit 1ns; timeprecision 10ps;

// program memory declaration
logic [i_size-1:0] prog_mem[15:0];

// get memory contents from file
initial
  begin
    // Set all prog_mem to 0 then load program
    // Ensures all unused instructions are NOP
    prog_mem = '{default:0};
    $readmemh("prog.hex", prog_mem);
  end
// program memory read 
always_comb
  instr = prog_mem[address];
  
endmodule // end of module prog