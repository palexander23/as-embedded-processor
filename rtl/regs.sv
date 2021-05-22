//-----------------------------------------------------
// File Name : regs.sv
// Function : picoMIPS 32 x n registers, %0 == 0
// Version 1 :
// Author: tjk
// Modified by: Peter Alexander
// Last rev. 25 March 2021
//-----------------------------------------------------
module regs #(parameter n = 8) // n - data bus width
(input logic clk, w, n_reset, // clk and write control
 input logic [n-1:0] w_data,
 input logic [4:0] Rd, Rs,
 output logic [n-1:0] Rd_data, Rs_data);

  
timeunit 1ns; timeprecision 10ps;

// Declare 32 n-bit registers 
logic signed [n-1:0] gpr [31:0];


// write process, dest reg is Raddr2
always_ff @ (posedge clk, negedge n_reset)
  begin
    // On an active low reset reset all registers to 0
    if(!n_reset)
      gpr <= '{default:0};
    else if (w)
      gpr[Rd] <= w_data;
      
  end

// read process, output 0 if %0 is selected
always_comb
  begin
    if (Rd==5'd0)
      Rd_data =  {n{1'b0}};
    else  Rd_data = gpr[Rd];
  
    if (Rs==5'd0)
      Rs_data =  {n{1'b0}};
    else  Rs_data = gpr[Rs];
  end	


endmodule // regs