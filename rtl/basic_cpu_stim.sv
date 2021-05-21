module basic_cpu_stim;

timeunit 1ns; timeprecision 10ps;

parameter n = 8;

// cpu inputs
logic clk, n_reset;
logic [9:0] SW;

// User programable switches 
logic [8:0] sw;

assign SW[8:0] = sw;

// cpu outputs
logic [n-1:0] leds;

// Assign the active low reset to SW[9]
assign SW[9] = n_reset;

// Assign the 

// cpu instance
cpu #(.n(n)) c0 (
  .clk(clk),
  .SW(SW),
  .LED(leds)
);

// Extract interesting internal signals
logic signed[7:0] mult_out, add_out, immediate;
logic signed[7:0] rd_data, rs_data;
logic signed[7:0] w_data;
logic signed[7:0] switches;
logic signed[7:0] acc_out;
logic[4:0] rd, rs;

assign mult_out = c0.as_alu0.mult_out;
assign add_out = c0.as_alu0.add_out;
assign rd_data = c0.as_alu0.rd_data;
assign rs_data = c0.as_alu0.rs_data;
assign switches = SW[7:0];
assign w_data = c0.as_alu0.w_data;
assign acc_out = c0.as_alu0.acc_out; 
assign immediate = c0.instr[n-1:0];
assign rd = c0.rd;
assign rs = c0.rs;


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

// Define new test function
task new_test();
  test_count = test_count + 1;
endtask

// Define error function
task log_error();
  input string error_message;
  begin 
    $display("\nTest number %2d Failed!", test_count);
    $display(error_message);
    $display("\n");
    $display("                 rd: %3d %8b\t       rs: %3d %8b", rd, rd, rs, rs);
    $display("            rd_data: %3d %8b\t  rs_data: %3d %8b", rd_data, rd_data, rs_data, rs_data);
    $display("          immediate: %3d %8b\t ", immediate, immediate);
    $display("            SW[7:0]: %3d %8b\t n{SW[8]}: %3d %8b", switches[7:0], switches[7:0], {n{switches[8]}}, {n{switches[8]}});
    $display("\n");
    $display("             w_data: %3d %8b", w_data, w_data);
    $display("            acc_out: %3d %8b", acc_out, acc_out);
    $display("           mult_out: %3d %8b\t  add_out: %3d %8b", mult_out, mult_out, add_out, add_out);
    $display("\n");

    error_count = error_count + 1;

  end
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
    //---------------END RESET TEST-----------------//

    //----------------INSTRUCTION 1-----------------//

    new_test();
    // Run first instruction 
    #1000 assert(add_out == 45) else
      log_error("Instruction 1: ACC 45 setup failed");

    clock();

    new_test();
    #1000 assert(acc_out == 45) else
      log_error("Instruction 1: ACC 45 execution failed");
    //-------------END INSTRUCTION 1----------------//

    //----------------INSTRUCTION 2-----------------//

    new_test();
    // Run first instruction 
    #1000 assert(add_out == -12) else
      log_error("Instruction 2: ACC -12 setup failed");

    clock();

    new_test();
    #1000 assert(acc_out == -12) else
      log_error("Instruction 2: ACC -12 execution failed");
    //-------------END INSTRUCTION 2----------------//

    //----------------INSTRUCTION 3-----------------//

    new_test();
    // Run first instruction 
    sw[7:0] = 4;
    #1000 assert(w_data == 4 && add_out == 2) else
      log_error("Instruction 3: ACCI %2 %1 2 setup failed");

    clock();

    new_test();
    #1000 assert(c0.r0.gpr[2] == 4 && acc_out == 2) else
      log_error("Instruction 3: ACCI %2 %1 2 execution failed");
    //-------------END INSTRUCTION 3----------------//

    //----------------INSTRUCTION 4-----------------//

    new_test();
    // Run first instruction 
    sw[7:0] = 17;
    #1000 assert(w_data == 17 && add_out == 3) else
      log_error("Instruction 4: ACCI %2 %1 2 setup failed");

    clock();

    new_test();
    #1000 assert(c0.r0.gpr[23] == 17 && acc_out == 3) else
      log_error("Instruction 4: ACCI %23 %1 3 execution failed");
    //-------------END INSTRUCTION 4----------------//

    //----------------INSTRUCTION 5-----------------//

    new_test();
    // Run first instruction 
    sw[7:0] = 17;
    #1000 assert(add_out == 0) else
      log_error("Instruction 5: MACI %0 %2 6 setup failed");

    clock();

    new_test();
    #1000 assert(acc_out == 0) else
      log_error("Instruction 5: MACI %0 %2 6 3 execution failed");
    //-------------END INSTRUCTION 5----------------//


    if (error_count == 0) $display("No errors were recorded!");
    else                  $error("%1d errors were reported!", error_count);


  end 
endmodule