//-----------------------------------------------------
// File Name        :   alu_stim.sv
// Function         :   Testbench for alu module
// Original Author  :   Peter Alexander
// Last rev. 24 Mar 2021
//-----------------------------------------------------


`include "alucodes.sv"
module alu_stim #(parameter n=8);

timeunit 1ns; timeprecision 10ps;

// alu input
logic [n-1:0] a, b;
logic [2:0] func;

// alu output
logic [3:0] flags;
logic [n-1:0] result;

// alu instance
alu alu0 (a,b,func,flags,result);

// Error and test counter
integer error_count;
integer test_count;


// Function to perform a test with arbitrary func and inputs
// Checks for correct result and flags
task check_alu_output();
  input logic [2:0]   func_in;
  input logic [n-1:0] a_in, b_in;
  input logic [n-1:0] expected_result;
  input logic [3:0]   expected_flags;    // V,N,Z,C

  // Apply inputs
  #1000 a = a_in; b = b_in; func = func_in;

  // Check outputs
  #1000 assert ((flags == expected_flags) && (result == expected_result)) else
    begin
      // Convert values to printable integers 

      $display("\nTest number %2d Failed!\n", test_count);
      $display("Inputs         A: %3d %8b\tB: %3d %8b", a, a, b, b);
      $display("Expected Results: %3d %8b\tExpected Flags: %4b", expected_result, expected_result, expected_flags);
      $display("  Actual Results: %3d %8b\t  Actual Flags: %4b\n", result, result, flags);
      error_count = error_count + 1;
    end
    test_count = test_count + 1;
endtask

initial 
  begin
    // Initialize test and error counts
    error_count = 0;
    test_count = 0;

    //-----------------RADD------------------//
    // Basic addition
    check_alu_output(`RADD, 1, 1, 2, 4'b0000);
    // Zero flag
    check_alu_output(`RADD, 0, 0, 0, 4'b0010);
    // Carry flag
    check_alu_output(`RADD, 255, 1, 0, 4'b0011);
    // Negative flag
    check_alu_output(`RADD, 5, -10, -5, 4'b0100);
    // Overflow flag
    check_alu_output(`RADD, 127, 127, -2, 4'b1100);
    //-------------END RADD------------------//

    //-----------------RSUB------------------//
    // Basic subtraction
    check_alu_output(`RSUB, 2, 1, 1, 4'b0000);
    // Carry flag
    check_alu_output(`RSUB, -128, 1, 127, 4'b0001);
    // Overflow flag
    check_alu_output(`RSUB, -128, 256, 128, 4'b1101);
    //-------------END RSUBB-----------------//

    //-----------------RA------------------//
    check_alu_output(`RA, -24, 45, -24, 4'b0100);
    //-------------END RA-----------------//

    //-----------------RB------------------//
    check_alu_output(`RB, -24, 45, 45, 4'b0000);
    //-------------END RB-----------------//

    if (error_count == 0) $display("No errors were recorded!");
    else                  $error("%1d errors were reported!", error_count);
  end

endmodule