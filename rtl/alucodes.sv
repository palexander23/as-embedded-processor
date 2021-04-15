//-----------------------------------------------------
// File Name        :   alucodes.sv
// Function         :   pMIPS ALU function code definitions
// Original Author  :   tjk
// Modified By      :   Peter Alexander
// Last rev. 24 Mar 2021
//-----------------------------------------------------
//

// ALU FUNCTION CODES
`define RA      3'b000
`define RB      3'b001
`define RADD    3'b010
`define RSUB    3'b011
`define RMULL   3'B100

// INPUT MUX CODES
`define REG     2'b00
`define SW_7_0  2'b01
`define SW_8    2'b10