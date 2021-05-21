module as_alu_stim #(parameter n=8);

timeunit 1ns; timeprecision 10ps;

// as_alu inputs
logic [n-1:0] rd_data, rs_data, immediate;    // Numerical inputs
logic add_a_sel, add_b_sel;                   // Input selectors
logic [8:0] switches;                         // External input switches
logic acc_en;                                 // ACC write enable
logic acc_add;                                // Route ACC back to adder
logic in_en;                                  // Route SW[7:0] to writeback bus
logic clk, n_reset;                           // Synchronising signals for ACC

// as_alu_outputs
logic z;                                     // Zero flag from ALU
logic [n-1:0] w_data;                         // Regs w_data
logic [n-1:0] acc_out;                        // ACC output for LEDs


//as_alu instance
as_alu as_alu0 (.*);


// Extract interesting internal signals
logic[7:0] mult_out, add_out;

assign mult_out = as_alu0.mult_out;
assign add_out = as_alu0.add_out;


// Error and test counter
integer error_count;
integer test_count;

// Define functions for clocking and reseting

task reset_inputs();
  rd_data = 0;
  rs_data = 0;
  add_a_sel = 0;
  add_b_sel = 0;
  switches = 0;
  acc_en = 0;
  acc_add = 0;
  in_en = 0;
  clk = 0;
  n_reset = 1;
endtask

task reset_system();

  reset_inputs();

  n_reset = 1;
  #1000 n_reset = 0;
  #1000 n_reset = 1;
endtask

task clock();
  clk = 0;
  #1000 clk = 1;
  #1000 clk = 0;
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
    $display("Inputs      rd_data: %3d %8b\t  rs_data: %3d %8b", rd_data, rd_data, rs_data, rs_data);
    $display("          immediate: %3d %8b\t ", immediate, immediate);
    $display("            SW[7:0]: %3d %8b\t n{SW[8]}: %3d %8b", switches[7:0], switches[7:0], {n{switches[8]}}, {n{switches[8]}});
    $display("\n");
    $display("Outputs      w_data: %3d %8b", w_data, w_data);
    $display("            acc_out: %3d %8b", acc_out, acc_out);
    $display("           mult_out: %3d %8b\t  add_out: %3d %8b", mult_out, mult_out, add_out, add_out);
    $display("\n");

    error_count = error_count + 1;

  end
endtask

initial 
  begin
    // Initialize test and error counts
    error_count = 0;
    test_count = 0;
    
    reset_system();

    
    //--------Place number in ACC--------//
    new_test();

    // Set up data path
    add_b_sel = 1;
    acc_en = 1;

    // Set up inputs
    rd_data = 0;
    rs_data = 23;
    immediate = 6;

    clock();
    #1000 assert(acc_out == add_out && acc_out == immediate) else
        log_error("Constant was not placed into ACC");
    //------End Place number in ACC------//

    //--------MACC Operation -----------//
    new_test();
    reset_inputs();
    
    // Set up data path
    acc_add = 1;
    acc_en = 1;

    // Set up inputs for ACC + 0.75*20 = 6 + 15 = 21
    rd_data = 32;            // Not used
    rs_data = 20;            // Pixel coordinate
    immediate = 8'b01100000; // 0.75

    clock();
    #1000 assert(acc_out == 21) else
        log_error("MACC operation failed");
    //------END MACC Operation---------//

    //--------w_data Assignment-------//
    new_test();
    reset_system();

    // Set up data path for ADDI 12+8 = 20
    add_b_sel = 1;

    // Setup inputs including SW[7:0] = 30
    rd_data = 12;
    rs_data = 13;
    immediate = 8;
    switches[7:0] = 30;

    #1000 assert(w_data == 20) else 
      log_error("w_data did not show result of ADDI");

    new_test();
    
    // Enable switches
    in_en = 1;
    #1000 assert(w_data == 30) else
      log_error("w_data did not follow switch value when in_en goes high");
    //-----END w_data Assignment-----//

    //---Z Flag with SW[8] Input ---//
    new_test();
    reset_system();

    // Set up data path for checking whether {n{SW[8]}} == 0 or not
    add_a_sel = 1;
    rs_data = 0;

    // Set up inputs for SW[8] == 0
    switches[8] = 0;

    #1000 assert(add_out == 0 && z == 1) else
      log_error("SW[8] == 0 was not detected correctly in the ALU");

    new_test();
    // Set SW[8] to 1 and check for detection
    switches[8] = 1'b1;

    #1000 assert(add_out == 8'b11111111 && z == 0) else
      log_error("SW[8] == 1 was not detected correctly on the ALU");

    //-END Z Flag with SW[8] Input--//


    if (error_count == 0) $display("No errors were recorded!");
    else                  $error("%1d errors were reported!", error_count);

  end

endmodule