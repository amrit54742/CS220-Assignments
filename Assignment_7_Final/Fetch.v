
`include "Get_Instruction.v"
module Instruction_Fetch(
	input clk, reset,
	input [9:0] PC,
	output [31:0] Instruction
);

	Get_Instruction GI(.clk(clk), .reset(reset), .PC(PC), .Instruction(Instruction));

endmodule


