module application_cpu_stim #(parameter n = 8, p_size = 6, i_size = 24);

timeunit 1ns; timeprecision 10ps;

// picoMIPS4test inputs
logic clk;
logic [9:0] SW;

// picoMIPS4test outputs
logic [7:0] LED;

// picoMIPS4test instance
picoMIPS4test p0(.fastclk(clk), .SW(SW), .LED(LED));

// Define global reset and assign it to SW[9]
logic n_reset;
assign SW[9] = n_reset;

// Define a variable for general purpose switches and assign to SW[8:0]
logic [8:0] gp_sw;
assign SW[8:0] = gp_sw;

// Error and test counters
integer error_count;
integer test_count;

task clock();
  #1000 clk = 0;
  #1000 clk = 1;
  #1000 clk = 0;
endtask // clock

task reset_system();
  // Place all inputs into known state
  #1000 clk = 0;
        n_reset = 1;
        gp_sw = 0;
  
  // Reset system
  #1000 n_reset = 0;
  #1000 n_reset = 1;
endtask // reset


task run_mac_operation();
    input logic [7:0] num1;
    input logic [7:0] num2;
    input logic [7:0] expected_result; 

    #1000 gp_sw[7:0] = num1; // Apply first input 
    #1000 gp_sw[8] = 1;      // Signal a new input is ready

    clock();                 // Clock that input in 
    clock();

    #1000 gp_sw[7:0] = num2; // Apply second input
    #1000 gp_sw[8] = 0;      // Signal new input is ready
    clock();
    #1000 gp_sw[8] = 1;

    clock();
    clock();                // Clock that input in

    clock();                // Perform MAC operation

    // Check output is correct 
    assert (LED == expected_result) else
      begin
        error_count = error_count + 1;
        $display("\nTest %2d Failed!", test_count);
        $display("Ouptut on LEDs was not correct");
        $display("Expected: %3d\tActual: %3d\n", expected_result, LED);
      end
    test_count = test_count + 1;

    clock();

    #1000 gp_sw[8] = 0;     // Complete handshake and loop back to program start
    clock();
    clock();

endtask


initial
  begin
    error_count = 0;
    test_count = 0;

    reset_system();

    // Clock once to set R8 to 0
    clock();

    run_mac_operation(1, 2, 2);
    run_mac_operation(2, 4, 10);

    // Try to interrupt it with some clocks
    clock();
    clock();
    clock();
    clock();
    clock();

    run_mac_operation(-45, -2, 100);

    if (error_count == 0) $display("No errors were recorded!");
    else                  $error("%1d errors were reported!", error_count);

  end // initial

endmodule // picoMIPS4test_stim