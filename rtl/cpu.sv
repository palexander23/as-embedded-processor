//------------------------------------
// File Name   : cpu.sv
// Function    : picoMIPS CPU top level encapsulating module, version 2
// Author      : Peter Alexander
// Last revised: 26/03/2021
//------------------------------------

`include "alucodes.sv"

module cpu #( parameter n = 8, p_size = 6, i_size = 16)
(input logic clk,
    input logic [9:0] SW,
    output logic [n-1:0] LED);

timeunit 1ns; timeprecision 10ps;

// Active Low reset
// Brought in on SW[9]
logic n_reset;
assign n_reset = SW[9];

// Internal connecting signals for each module
// Registers
logic w;
logic [n-1:0] Rd_data, Rs_data;
logic [n-1:0] w_data;

// ALU
logic add_a_sel, add_b_sel;
logic acc_en, acc_add;
logic in_en;

logic z;
logic [n-1:0] acc_out;

// PC 
logic pc_incr, pc_relbranch;
logic [p_size-1:0] pc_out;

// Program Memory
logic [i_size-1:0] instr;

// Extract operands
logic[2:0] rd, rs;

assign rd = instr[i_size-3:i_size-5];
assign rs = instr[i_size-6:i_size-8];

decoder d0 (
    .opcode(instr[i_size-1:i_size-2]),
    .z(z),
    .acc_en(acc_en),
    .acc_add(acc_add),
    .in_en(in_en),
    .w(w),
    .pc_incr(pc_incr),
    .pc_relbranch(pc_relbranch)
);

// Instantiate Modules
pc #(.p_size(p_size)) pc0 (
    .clk(clk),
    .n_reset(n_reset),
    .pc_incr(pc_incr),
    .pc_relbranch(pc_relbranch),
    .branch_addr(instr[p_size-1:0]),
    .pc_out(pc_out)
);

as_alu #(.n(n)) as_alu0 (
    .rd_data(Rd_data),
    .rs_data(Rs_data),
    .immediate(instr[n-1:0]),
    .add_a_sel(add_a_sel),
    .add_b_sel(add_b_sel),
    .switches(SW[8:0]),
    .acc_en(acc_en),
    .acc_add(acc_add),
    .in_en(in_en),
    .clk(clk),
    .n_reset(n_reset),
    .z(z),
    .w_data(w_data),
    .acc_out(acc_out)
);

regs #(8) r0 (
    .clk(clk),
    .w(w),
    .n_reset(n_reset),
    .w_data(w_data),
    .Rd(rd),
    .Rs(rs),
    .Rd_data(Rd_data),
    .Rs_data(Rs_data)
);

prog #(.p_size(p_size), .i_size(i_size)) prog0 (
    .address(pc_out),
    .instr(instr)
);

always_comb 
  begin
    // ALU adder A input selection
    if(rd == 1)
        add_a_sel = 1;
    else
        add_a_sel = 0;

    // ALU adder B input selection
    if(rs == 1)
        add_b_sel = 1;
    else
        add_b_sel = 0;

  end

// Route ALU output to LEDs
assign LED = acc_out;

endmodule