module basic_cpu_stim;

timeunit 1ns; timeprecision 10ps;

parameter n = 8;

// cpu inputs
logic clk, n_reset;
logic [8:0] sw;

// cpu outputs
logic [n-1:0] leds;

// cpu instance
cpu #(.n(n)) c0 (.*);

// Error and test counters
integer error_count;
integer test_count;

task clock();
  #1000 clk = 0;
  #1000 clk = 1;
  #1000 clk = 0;
endtask

task reset_system();
  // Place all inputs into known state
  #1000 clk = 0;
        n_reset = 1;
        sw = 0;
  
  // Reset system
  #1000 n_reset = 0;
  #1000 n_reset = 1;

endtask

initial 
  begin
    // Initialize test and error counters
    error_count  = 0;
    test_count  = 0;

    // Initialize system
    reset_system();

    //----------------RESET TEST--------------------//
    // Check PC output is 0
    assert(c0.pc_out == 0) else
      begin
        $display("\nTest %2d Failed!", test_count);
        $display("PC did not go to 0 on reset.");
        $display("Expected: %5b\tActual: %5b\n", 0, c0.pc_out);
        error_count = error_count + 1;
      end
      test_count = test_count + 1; 

    // Check registers have zeroed
    for(int i = 0; i < 32; i++)
    begin
      assert(c0.r0.gpr[i] == {n{1'b0}}) else
        begin
          error_count = error_count + 1;
          $display("\nTest %2d Failed!", test_count);
          $display("Resetting the system did not put registers to a 0 state");
          $display("Register %2d\tExpected: %8b\tActual: %8b\n", i, 0, c0.r0.gpr[i]);
        end
    end
    test_count = test_count + 1; 
    //---------------END RESET TEST-----------------//

    //-------------------INSTR 1--------------------//
    // Check ALU output is 60
    assert(c0.alu_result == 60 && leds == 60) else
      begin
        error_count = error_count + 1;
        $display("\nTest %2d Failed!", test_count);
        $display("ALU output was not 60 before first instruction clock");
        $display("Expected: %8b\tActual: %8b\n", 60, c0.alu_result);
      end
      test_count = test_count + 1; 

    // Run the first instruction
    clock();
    
    // Check PC has incremented
    assert(c0.pc_out == 1) else
      begin
        error_count = error_count + 1;
        $display("\nTest %2d Failed!", test_count);
        $display("PC did not increment on first instruction");
        $display("Expected: %8b\tActual: %8b\n", 1, c0.pc_out);
      end
      test_count = test_count + 1; 

    // Check %3 is now at 60
    assert(c0.r0.gpr[3] == 60) else
      begin
        error_count = error_count + 1;
        $display("\nTest %2d Failed!", test_count);
        $display("R3 did not go to 60 after instruction 1 was clocked");
        $display("Expected: %8b\tActual: %8b\n", 60, c0.r0.gpr[3]);
      end
      test_count = test_count + 1; 
    //-----------------END INSTR 1------------------//


    //-------------------INSTR 2--------------------//
    // Check ALU output is 54
    assert(c0.alu_result == 54 && leds == 54) else
      begin
        error_count = error_count + 1;
        $display("\nTest %2d Failed!", test_count);
        $display("ALU output was not 54 before 2nd instruction clock");
        $display("Expected: %8b\tActual: %8b\n", 54, c0.alu_result);
      end
      test_count = test_count + 1; 

    // Run the first instruction
    clock();
    
    // Check PC has incremented
    assert(c0.pc_out == 2) else
      begin
        error_count = error_count + 1;
        $display("\nTest %2d Failed!", test_count);
        $display("PC did not increment on 2nd instruction");
        $display("Expected: %8b\tActual: %8b\n", 2, c0.pc_out);
      end
      test_count = test_count + 1; 

    // Check %3 is now at 60
    assert(c0.r0.gpr[4] == 54) else
      begin
        error_count = error_count + 1;
        $display("\nTest %2d Failed!", test_count);
        $display("R4 did not go to 54 after instruction 2 was clocked");
        $display("Expected: %8b\tActual: %8b\n", 54, c0.r0.gpr[4]);
      end
      test_count = test_count + 1; 
    //-----------------END INSTR 2------------------//


    //-------------------INSTR 3--------------------//
    // Check ALU output is 114
    assert(c0.alu_result == 114 && leds == 114) else
      begin
        error_count = error_count + 1;
        $display("\nTest %2d Failed!", test_count);
        $display("ALU output was not 114 before 3rd instruction clock");
        $display("Expected: %8b\tActual: %8b\n", 114, c0.alu_result);
      end
      test_count = test_count + 1; 

    // Run the first instruction
    clock();
    
    // Check PC has incremented
    assert(c0.pc_out == 3) else
      begin
        error_count = error_count + 1;
        $display("\nTest %2d Failed!", test_count);
        $display("PC did not increment on 3nd instruction");
        $display("Expected: %8b\tActual: %8b\n", 3, c0.pc_out);
      end
      test_count = test_count + 1; 

    // Check %3 is now at 60
    assert(c0.r0.gpr[3] == 114) else
      begin
        error_count = error_count + 1;
        $display("\nTest %2d Failed!", test_count);
        $display("R3 did not go to 54 after instruction 2 was clocked");
        $display("Expected: %8b\tActual: %8b\n", 114, c0.r0.gpr[3]);
      end
      test_count = test_count + 1; 
    //-----------------END INSTR 3------------------//


    //-------------------INSTR 4--------------------//
    // Check ALU output is 0
    assert(c0.alu_result == 0 && leds == 0) else
      begin
        error_count = error_count + 1;
        $display("\nTest %2d Failed!", test_count);
        $display("ALU output was not 114 before 3rd instruction clock");
        $display("Expected: %8b\tActual: %8b\n", 0, c0.alu_result);
      end
      test_count = test_count + 1; 

    // Run the first instruction
    clock();
    
    // Check PC has incremented
    assert(c0.pc_out == 4) else
      begin
        error_count = error_count + 1;
        $display("\nTest %2d Failed!", test_count);
        $display("PC did not increment on 3nd instruction");
        $display("Expected: %8b\tActual: %8b\n", 4, c0.pc_out);
      end
      test_count = test_count + 1; 

    // Check %3 is now at 60
    assert(c0.r0.gpr[3] == 114) else
      begin
        error_count = error_count + 1;
        $display("\nTest %2d Failed!", test_count);
        $display("R3 did not go to 54 after instruction 2 was clocked");
        $display("Expected: %8b\tActual: %8b\n", 114, c0.r0.gpr[3]);
      end
      test_count = test_count + 1; 
    //-----------------END INSTR 4------------------//


    //-------------------INSTR 4--------------------//
    // Check ALU output is 0
    assert(c0.alu_result == 65 && leds == 65) else
      begin
        error_count = error_count + 1;
        $display("\nTest %2d Failed!", test_count);
        $display("ALU output was not 114 before 3rd instruction clock");
        $display("Expected: %8b\tActual: %8b\n", 65, c0.alu_result);
      end
      test_count = test_count + 1; 

    // Run the first instruction
    clock();
    
    // Check PC has incremented
    assert(c0.pc_out == 5) else
      begin
        error_count = error_count + 1;
        $display("\nTest %2d Failed!", test_count);
        $display("PC did not increment on 3nd instruction");
        $display("Expected: %8b\tActual: %8b\n", 5, c0.pc_out);
      end
      test_count = test_count + 1; 

    // Check %3 is now at 60
    assert(c0.r0.gpr[3] == 65) else
      begin
        error_count = error_count + 1;
        $display("\nTest %2d Failed!", test_count);
        $display("R3 did not go to 54 after instruction 2 was clocked");
        $display("Expected: %8b\tActual: %8b\n", 65, c0.r0.gpr[3]);
      end
      test_count = test_count + 1; 
    //-----------------END INSTR 4------------------//


    if (error_count == 0) $display("No errors were recorded!");
    else                  $error("%1d errors were reported!", error_count);


  end
endmodule