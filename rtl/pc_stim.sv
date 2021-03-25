module pc_stim #(parameter p_size = 6);

timeunit 1ns; timeprecision 10ps;

// pc inputs
logic clk, n_reset, pc_incr, pc_relbranch;
logic [p_size-1:0] branch_addr;

// pc outputs
logic [p_size-1:0] pc_out;

// pc instance
pc #(p_size) pc0 (.*);

// Initialize test and error counters
integer test_count;
integer error_count;

// Task to reset system and inputs
task reset_system();
  // Place all inputs in a known state
  #1000 clk = 0;
        n_reset = 1;
        pc_incr = 0;
        pc_relbranch = 0;
        branch_addr = 0;

  // Reset system
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
    // Initialize error and test counters
    test_count = 0;
    error_count = 0;

    reset_system();
    
    //----------------RESET TEST--------------------//
    #1000 assert(pc_out == {p_size{1'b0}}) else
      begin
        error_count = error_count + 1;
        $display("\nTest %2d Failed!", test_count);
        $display("PC was not set to 0 by reset.");
        $display("Expected: %8b\tActual: %8b\n", 0, pc_out);
      end
    test_count = test_count + 1;
    //---------------END RESET TEST-----------------//

    //---------------INCREMENT TEST----------------//
    // Increment up to the physical limit of the counter
    for(int i = 1; i < (1 << p_size); i++)
      begin
        #1000 pc_incr = 1;
        clock();
        #1000 assert(pc_out == i) else
          begin
            $display("\nTest %2d Failed!", test_count);
            $display("Counter failed to increment.");
            $display("Expected: %8b\tActual: %8b\n", i, pc_out);
          end
      end
      test_count = test_count + 1;
    //-------------END INCREMENT TEST--------------//

    //---------------OVERFLOW TEST----------------//
    // Increment the counter once more, check it goes to 0
    #1000 pc_incr = 1;
    clock();
    #1000 assert(pc_out == 0) else
      begin
        $display("\nTest %2d Failed!", test_count); 
        $display("PC failed to overflow back to 0.");
        $display("Expected: %8b\tActual: %8b\n", 0, pc_out);
      end
      test_count = test_count + 1;
    //-------------END OVERFLOW TEST--------------//

    reset_system();

    //-------------NO INCREMENT TEST--------------//
    // Check with pc_incr = 0 no incrementing happens
    #1000 pc_incr = 0;
    clock();
    #1000 assert(pc_out == 0) else
      begin
        $display("\nTest %2d Failed!", test_count); 
        $display("PC incremented when it wasn't meant to.");
        $display("Expected: %8b\tActual: %8b\n", 0, pc_out);
      end
      test_count = test_count + 1;
    //-----------END NO INCREMENT TEST------------//

    reset_system();

    //--------POSITIVE REL INCREMENT TEST---------//
    #1000 pc_relbranch = 1; branch_addr = 20;
    clock();
    #1000 assert(pc_out == 20) else
      begin
        $display("\nTest %2d Failed!", test_count); 
        $display("Positive rel increment failed");
        $display("Expected: %8b\tActual: %8b\n", 20, pc_out);
      end
      test_count = test_count + 1;

    //------END POSITIVE REL INCREMENT TEST-------//

    //--------NEGATIVE REL INCREMENT TEST---------//
    #1000 pc_relbranch = 1; branch_addr = -10;
    clock();
    #1000 assert(pc_out == 10) else
      begin
        $display("\nTest %2d Failed!", test_count); 
        $display("Positive rel increment failed");
        $display("Expected: %8b\tActual: %8b\n", 10, pc_out);
      end
      test_count = test_count + 1;
    //------END NEGATIVE REL INCREMENT TEST-------//


    if (error_count == 0) $display("No errors were recorded!");
    else                  $error("%1d errors were reported!", error_count);

  end //initial
endmodule //pc_stim