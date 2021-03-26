//------------------------------------
// File Name   : cpu.sv
// Function    : picoMIPS CPU top level encapsulating module, version 2
// Author      : Peter Alexander
// Last revised: 26/03/2021
//------------------------------------

module cpu #( parameter n = 8)
(input logic clk, n_reset,
    input logic [8:0] sw,
    output logic [n-1:0] leds);

timeunit 1ns; timeprecision 10ps;

// Internal connecting signals for each module
// Registers
logic w;
logic Rd, Rs;
logic [n-1:0] Rd_data, Rs_data;

// ALU
logic [2:0] alu_func;
logic [1:0] a_sel, b_sel;
logic [3:0] alu_flags;
logic [n-1:0] alu_result;

// PC 
parameter p_size = 6;
logic pc_incr, pc_relbranch;
logic [p_size-1:0] pc_branch_addr;
logic [p_size-1:0] pc_out;

// Program Memory
parameter i_size = 24;
logic [i_size-1:0] instr;

decoder d0 (
    .opcode(instr[i_size-1:i_size-6]),
    .alu_flags(alu_flags),
    .a_sel(a_sel),
    .b_sel(b_sel),
    .alu_func(alu_func),
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
    .branch_addr(pc_branch_addr),
    .pc_out(pc_out)
);

alu #(.n(n)) alu0 (
    .a_in(Rd_data),
    .b_in(Rs_data),
    .func(alu_func),
    .a_sel(a_sel),
    .b_sel(b_sel),
    .switches(sw),
    .immediate(instr[n-1:0]),
    .flags(alu_flags),
    .result(alu_result)
);

regs #(8) r0 (
    .clk(clk),
    .w(w),
    .n_reset(n_reset),
    .w_data(alu_result),
    .Rd(instr[i_size-7:i_size-11]),
    .Rs(instr[i_size-12:i_size-16]),
    .Rd_data(Rd_data),
    .Rs_data(Rs_data)
);

prog #(.p_size(p_size), .i_size(i_size)) prog0 (
    .address(pc_out),
    .instr(instr)
);

// Route ALU output to LEDs
assign leds = alu_result;

endmodule