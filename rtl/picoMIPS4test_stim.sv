module application_cpu_stim #(parameter n = 8, p_size = 6, i_size = 24);

timeunit 1ns; timeprecision 10ps;

// picoMIPS4test inputs
logic clk;
logic [9:0] SW;

// picoMIPS4test outputs
logic signed [7:0] LED;

// picoMIPS4test instance
picoMIPS4test p0(.fastclk(clk), .SW(SW), .LED(LED));

// Define global reset and assign it to SW[9]
logic n_reset;
assign SW[9] = n_reset;

// Define a variable for general purpose switches and assign to SW[8:0]
logic signed [8:0] gp_sw;
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


task run_affine_operation(logic signed [7:0] x1, y1, x2, y2);
    gp_sw[7:0] = x1; // Apply first input 
    gp_sw[8] = 1;      // Signal a new input is ready

    clock();                 // Clock that input in 
    clock();

    gp_sw[7:0] = y1; // Apply second input
    gp_sw[8] = 0;      // Signal new input is ready
    clock();
    #1000 gp_sw[8] = 1;

    clock();
    clock();                // Clock that input in
    
    gp_sw[8] = 0;
    clock();                // Start Affine transformation

    clock();
    clock();
    clock();                // Compute x2

    clock();
    clock();
    clock();                // Compute y2

    clock();                // Display x2

    // Check output is correct 
    #1000 assert (LED == x2) else
      begin
        error_count = error_count + 1;
        $display("\nTest %2d Failed!", test_count);
        $display("Ouptut on LEDs did not match x2");
        $display("Expected: %3d\tActual: %3d\n", x2, LED);
      end
    test_count = test_count + 1;

    gp_sw[8] = 1;
    clock();
    clock();                // Display y2

    #1000 assert (LED == y2) else
      begin
        error_count = error_count + 1;
        $display("\nTest %2d Failed!", test_count);
        $display("Ouptut on LEDs did not match y2");
        $display("Expected: %3d\tActual: %3d\n", y2, LED);
      end
    test_count = test_count + 1;

    gp_sw[8] = 0;     // Complete handshake and loop back to program start
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

    run_affine_operation(25, 78, 62, 57);

    // Try to interrupt it with some clocks
    clock();
    clock();

    run_affine_operation(-32, 6, -16, 32);
    run_affine_operation(45, -65, 5, -60);

    if (error_count == 0) $display("No errors were recorded!");
    else                  $error("%1d errors were reported!", error_count);

  end // initial

endmodule // picoMIPS4test_stim


// x1: 25 y1: 78    x2: 62 y2: 58
// x2 = 5 + 18 + 39
// y2 = 12 + -12 + 58


// x1: -32 y1: 6    x2: -16 y2: 32
// x2 = 5 + -24 + 3
// y2 = 12 + 16 + 4


//x1: 25 y1: 78           x2: 62 y2: 58
//x1: -32 y1: 6           x2: -16 y2: 32
//x1: 45 y1: -65          x2: 6 y2: -58
