//-----------------------------------------------------
// File Name        :   regs_stim.sv
// Function         :   Testbench for register module
// Original Author  :   Peter Alexander
// Last rev. 25 Mar 2021
//-----------------------------------------------------

module regs_stim #(parameter n = 8);

timeunit 1ns; timeprecision 10ps;

// regs input
logic clk, w, n_reset;
logic [n-1:0] w_data;
logic [4:0] Rd, Rs;

// regs output
logic [n-1:0] Rd_data, Rs_data;

// regs instance 
regs r0 (.*);

// Error and test counters
integer error_count;
integer test_count;

task reset_system();
  // Place all inputs in known state
  #1000 clk     = 0;
        n_reset = 1; 
        w       = 0; 
        Rd      = 0; 
        Rs      = 0; 
        w_data  = 0; 

  // Reset system
  #1000 n_reset = 1;
  #1000 n_reset = 0;
  #1000 n_reset = 1;

endtask

task clock();
  #1000 clk = 0;
  #1000 clk = 1;
  #1000 clk = 0;
endtask

initial 
  begin
    // Initialize test and error counts
    error_count  = 0;
    test_count  = 0;

    // Reset system and inputs
    reset_system();

    //----------------RESET TEST--------------------//
    for(int i = 0; i < 32; i++)
    begin
      assert(r0.gpr[i] == {n{1'b0}}) else
        begin
          error_count = error_count + 1;
          $display("\nTest %2d Failed!", test_count);
          $display("Resetting the system did not put registers to a 0 state");
          $display("Register %2d\tExpected: %8b\tActual: %8b\n", i, 0, r0.gpr[i]);
        end
    end
    test_count = test_count + 1; 
    //---------------END RESET TEST-----------------//

    reset_system();

    //-----------------WRITE TEST-------------------//
    // Registers 0-2 are reserved
    for(int i = 3; i < 32; i++)
      begin
        #1000 Rd = i; w = 1; Rs = i-1; w_data = i;
        clock();
        
        // Have Rs checking the write before. 
        // If it is the first write (Rd = 3, Rs = 2), ignore Rs_data
        // as it will not have been written to since the reset. 
        assert(r0.gpr[i] == i && Rd_data == i && (Rs_data == i-1 || Rs == 2)) else
          begin
            error_count = 1;
            $display("\nTest %2d Failed!", test_count);
            $display("Register was not written correctly!");
            $display("Register %2d\tExpected: %8b\tActual: %8b\n", i, i, r0.gpr[i]);
          end
      end
      test_count = test_count + 1;
    //---------------END WRITE TEST-----------------//

    reset_system();

    //----------------R0 == 0 TEST------------------//
    // Attempt to set R0 to a non-zero value
    #1000 w_data = 12; Rd = 0; Rs = 0; w = 1;
    clock();

    // Check to see if outputs are now 0
    assert (Rs_data == 0 && Rd_data == 0) else
      begin
        $display("\nTest %2d Failed!", test_count); 
        $display("R0 not output as 0. Expected: %8b\tActual %8b\n", 0, Rs_data); 
      end
    //--------------END R0 == 0 TEST----------------//


    if (error_count == 0) $display("No errors were recorded!");
    else                  $error("%1d errors were reported!", error_count);

  end //initial

endmodule //regs_stim