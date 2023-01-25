`timescale 1ns / 1ps
`include "full_adder_32.v"
module full_adder_32_tb;

	// Inputs
	reg [31:0] a;
	reg [31:0] b;

	// Outputs
	wire [31:0] sum;
	wire cout;

	// Instantiate the Unit Under Test (UUT)
	full_adder_32 uut (
		.a(a), 
		.b(b), 
		.sum(sum), 
		.cout(cout)
	);

	initial begin
		// Initialize Inputs
        $dumpfile("full_adder_32_tb.vcd");
        $dumpvars(0, full_adder_32_tb);
        // $monitor("sum- ", sum, ", cout- ", cout);
		a = 32'b11111111111111111111111111111111;
		b = 32'b11111111111111111111111111111111;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule


