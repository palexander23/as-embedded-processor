module as_alu #(parameter n = 8) (
    input logic signed [n-1:0] rd_data, rs_data, immediate,   // Numerical inputs
    input logic add_a_sel, add_b_sel,                         // Input selectors
    input logic [8:0] switches,                               // External input switches
    input logic acc_en,                                       // ACC write enable
    input logic acc_add,                                      // Route ACC back to adder
    input logic in_en,                                        // Route SW[7:0] to writeback bus
    input logic clk, n_reset,                                 // Synchronising signals for ACC

    output logic z,                                           // Zero flag from ALU
    output logic [n-1:0] w_data,                              // Regs w_data
    output logic [n-1:0] acc_out                              // ACC output for LEDs
);

timeunit 1ns; timeprecision 10ps;

// Define multiplier and associated temporary variables 
logic signed [(2*n)-1:0] full_mult_out;                 // Full 16-bit output of multiplier 
logic signed [n-1:0] mult_out;                          // Bits [14:7] of the mult output   

assign full_mult_out = rs_data * immediate;             // Multiplier definition
assign mult_out = full_mult_out[(2*n)-1:(2*n)-9];       // Only take the integer part of the mult result


// Define adder and associated temporary variables
logic signed [7:0] add_a_in, add_b_in;                  // Adder inputs
logic signed [7:0] add_out;                             // Adder output

assign add_out = add_a_in + add_b_in;                     // Adder definition


// Define ACC
always_ff @(posedge clk, negedge n_reset) 
  begin: ACC
    if (!n_reset)
      acc_out <= {n{1'b0}};
    else
      acc_out <= add_out;
  end // always_ff ACC


// Multiplexer for Adder A input
always_comb 
  begin 
    if (acc_add)
      add_a_in = acc_out;                               // Feedback ACC to adder
    else if(add_a_sel)
      add_a_in = {n{switches[8]}};                      // Route SW[8] to adder for branching
    else
      add_a_in = rd_data;                               // Otherwise, take value stored in Rd

  end // always_comb ADDER A MUX

// Multiplexer for Adder B input
always_comb 
  begin
    if(add_b_sel)
      add_b_in = immediate;                             // Route immediate input to adder
    else
      add_b_in = mult_out;                              // Otherwise take value stored in Rs
      
  end // always_comb ADDER A MUX


// Multiplexer for SW[7:0] onto writeback line
always_comb 
  begin 
    if(in_en)
      w_data = switches[7:0];                           // Route input switches to w_data
    else
      w_data = add_out;                                 // Otherwise route adder output to w_data 

  end

// Zero flag
assign z = add_out == {n{1'b0}}; // Z

endmodule

