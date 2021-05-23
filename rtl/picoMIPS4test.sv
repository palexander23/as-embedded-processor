// synthesise to run on Altera DE0 for testing and demo
module picoMIPS4test(
  input logic fastclk,  // 50MHz Altera DE0 clock
  input logic [9:0] SW, // Switches SW0..SW9
  output logic [7:0] LED); // LEDs

  timeunit 1ns; timeprecision 10ps;
  
  logic clk; // slow clock, about 10Hz
  
  counter c (.fastclk(fastclk),.clk(clk)); // slow clk from counter
  
  // to obtain the cost figure, synthesise your design without the counter 
  // and the picoMIPS4test module using Cyclone IV E as target
  // and make a note of the synthesis statistics

  // EDIT BY PETER ALEXANDER: 
  // When running the testbench for this module we don't want to have to 
  // clock it 2^24 times to get the program to progress.
  // The macro TESTBENCH_CLOCK can be defined in the testbench to bypass 
  // The clock divider.
  //`ifdef TESTBENCH_CLOCK
    cpu c0 (.clk(fastclk), .SW(SW),.LED(LED));
  //`else
  //  cpu c0 (.clk(clk), .SW(SW),.LED(LED));
  //`endif 
    
  
endmodule  