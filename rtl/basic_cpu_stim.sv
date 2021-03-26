module basic_cpu_stim;

timeunit 1ns; timeprecision 10ps;

parameter n = 8;

// cpu inputs
logic clk, n_reset;
logic [8:0] sw;

// cpu outputs
logic [n-1:0] leds;

// cpu instance
cpu #(.n(n)) c0 (
  .clk(clk),
  .n_reset(n_reset),
  .sw(sw),
  .leds(leds)
);

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
        $display("PC did not increment on 4th instruction");
        $display("Expected: %8b\tActual: %8b\n", 4, c0.pc_out);
      end
      test_count = test_count + 1; 

    // Check %3 is now at 60
    assert(c0.r0.gpr[3] == 114) else
      begin
        error_count = error_count + 1;
        $display("\nTest %2d Failed!", test_count);
        $display("R3 did not go to 114 after instruction 2 was clocked");
        $display("Expected: %8b\tActual: %8b\n", 114, c0.r0.gpr[3]);
      end
      test_count = test_count + 1; 
    //-----------------END INSTR 4------------------//


    //-------------------INSTR 4--------------------//
    // Check ALU output is 65
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
        $display("R3 did not go to 65 after instruction 2 was clocked");
        $display("Expected: %8b\tActual: %8b\n", 65, c0.r0.gpr[3]);
      end
      test_count = test_count + 1; 
    //-----------------END INSTR 4------------------//


    //-------------------INSTR 5--------------------//
    // Set SW[7:0] to 30 and read switches into R5
    #1000 sw[7:0] = 8'b00011110;

    #1000 assert(c0.alu_result == 30 && leds == 30) else
      begin
        error_count = error_count + 1;
        $display("\nTest %2d Failed!", test_count);
        $display("ALU output was not 30 before 5th instruction clock");
        $display("Expected: %8b\tActual: %8b\n", 30, c0.alu_result);
      end
      test_count = test_count + 1; 

    // Run the first instruction
    clock();
    
    // Check PC has incremented
    assert(c0.pc_out == 6) else
      begin
        error_count = error_count + 1;
        $display("\nTest %2d Failed!", test_count);
        $display("PC did not increment on 3nd instruction");
        $display("Expected: %8b\tActual: %8b\n", 6, c0.pc_out);
      end
      test_count = test_count + 1; 

    assert(c0.r0.gpr[5] == 30) else
      begin
        error_count = error_count + 1;
        $display("\nTest %2d Failed!", test_count);
        $display("R5 did not go to 30 after instruction 5 was clocked");
        $display("Expected: %8b\tActual: %8b\n", 30, c0.r0.gpr[5]);
      end
      test_count = test_count + 1; 
    //-----------------END INSTR 5------------------//


    //-------------------INSTR 6--------------------//
    // Set SW[7:0] to 30 and read switches into R5
    #1000 sw[7:0] = -3;

    #1000 assert(c0.alu_result == 8'b11111101 && leds == 8'b11111101) else
      begin
        error_count = error_count + 1;
        $display("\nTest %2d Failed!", test_count);
        $display("ALU output was not -3 before 6th instruction clock");
        $display("Expected: %8b\tActual: %8b\n", -3, c0.alu_result);
      end
      test_count = test_count + 1; 

    // Run the first instruction
    clock();
    
    // Check PC has incremented
    assert(c0.pc_out == 7) else
      begin
        error_count = error_count + 1;
        $display("\nTest %2d Failed!", test_count);
        $display("PC did not increment on 6th instruction");
        $display("Expected: %8b\tActual: %8b\n", 7, c0.pc_out);
      end
      test_count = test_count + 1; 

    assert(c0.r0.gpr[6] == 8'b11111101) else
      begin
        error_count = error_count + 1;
        $display("\nTest %2d Failed!", test_count);
        $display("R6 did not go to 30 after instruction 6 was clocked");
        $display("Expected: %8b\tActual: %8b\n", 8'b11111101, c0.r0.gpr[6]);
      end
      test_count = test_count + 1; 
    //-----------------END INSTR 6------------------//


    //-------------------INSTR 7--------------------//
    // Set SW[7:0] to 30 and read switches into R5
    #1000 sw[8] = 1'b1;

    #1000 assert(c0.alu_result == 8'b11111111 && leds == 8'b11111111) else
      begin
        error_count = error_count + 1;
        $display("\nTest %2d Failed!", test_count);
        $display("ALU output was not -3 before 6th instruction clock");
        $display("Expected: %8b\tActual: %8b\n", 8'b11111111, c0.alu_result);
      end
      test_count = test_count + 1; 

    // Run the first instruction
    clock();
    
    // Check PC has incremented
    assert(c0.pc_out == 8) else
      begin
        error_count = error_count + 1;
        $display("\nTest %2d Failed!", test_count);
        $display("PC did not increment on 6th instruction");
        $display("Expected: %8b\tActual: %8b\n", 8, c0.pc_out);
      end
      test_count = test_count + 1; 

    assert(c0.r0.gpr[7] == 8'b11111111) else
      begin
        error_count = error_count + 1;
        $display("\nTest %2d Failed!", test_count);
        $display("R6 did not go to 111111111 after instruction 7 was clocked");
        $display("Expected: %8b\tActual: %8b\n", 8'b11111111, c0.r0.gpr[7]);
      end
      test_count = test_count + 1; 
    //-----------------END INSTR 7------------------//


    if (error_count == 0) $display("No errors were recorded!");
    else                  $error("%1d errors were reported!", error_count);


  end
endmodule