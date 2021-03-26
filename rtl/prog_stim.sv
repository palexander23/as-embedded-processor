module prog_stim #(parameter p_size = 6, i_size = 24);

// prog inputs
logic [p_size-1:0] address;

// prog outputs
logic [i_size:0] instr;

// prog instance
prog p0 (.*);

// Place to store local copy of program for comparison
logic [i_size:0] prog_mem[ (1<<p_size)-1:0];

// Error and test counters
integer error_count;
integer test_count;

initial
  begin
    // Initialize test and error counts
    error_count  = 0;
    test_count  = 0;

    // Initialize input
    address = 0;

    // Load the program that should be in prog
    // Fill all unused addresses with NOPs.
    prog_mem = '{default:0};
    $readmemh("prog.hex", prog_mem);

    // Loop through the address space, checking prog gives correct instruction
    for(int i = 0; i < (1<<p_size); i++)
      begin
        #1000 address = i;
        #1000 assert(instr == prog_mem[i]) else
          begin
            error_count = 1;
            $display("\nTest %2d Failed!", test_count);
            $display("Address: %2d was incorrect.",i);
            $display("Expected: %24b\tActual: %24b\n", prog_mem[i], instr);
          end // assert
      end // for
    
  end // initial

endmodule // prog_stim
