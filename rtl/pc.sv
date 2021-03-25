//-----------------------------------------------------
// File Name : pc.sv
// Function : picoMIPS Program Counter
// functions: increment and relative branches
// Author: tjk
// Modified By      :   Peter Alexander
// Last rev. 25 March 2021
//-----------------------------------------------------
module pc #(parameter p_size = 6) // up to 64 instructions
(input logic clk, n_reset, pc_incr, pc_relbranch,
 input logic [p_size-1:0] branch_addr,
 output logic [p_size-1:0] pc_out
);

timeunit 1ns; timeprecision 10ps;

//------------- code starts here---------
logic[p_size-1:0] r_branch; // temp variable for addition operand
always_comb
  if (pc_incr)
       r_branch = { {(p_size-1){1'b0}}, 1'b1};
  else r_branch =  branch_addr;


always_ff @ (posedge clk, negedge n_reset) // async reset
  if (!n_reset) // sync reset
     pc_out <= {p_size{1'b0}};
  else if (pc_incr | pc_relbranch) // increment or relative branch
     pc_out <= pc_out + r_branch; // 1 adder does both
	 
endmodule // module pc