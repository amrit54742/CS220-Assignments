`timescale 1ns / 1ps
`include "orig_ripple_bit_adder.v"
module orig_ripple_bit_adder_tb;

	// Inputs
	reg [127:0] c;
	reg [127:0] d;

	// Outputs
	wire [127:0] sum;
	wire cout;

	// Instantiate the Unit Under Test (UUT)
	orig_ripple_bit_adder uut (
		.c(c), 
		.d(d), 
		.sum(sum), 
		.cout(cout)
	);

	initial begin
		// Initialize Inputs
        $dumpfile("orig_ripple_bit_adder_tb.vcd");
        $dumpvars(0, orig_ripple_bit_adder_tb);
        // $monitor("sum- ", sum, ", cout- ", cout);
	//	a = 32'b11111111111111111111111111111111;
	//	b = 32'b11111111111111111111111111111111;


        c = 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011110;
		d = 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001001;
		// Wait 100 ns for global reset to finish
		#1;
        
		// Add stimulus here

	end
      
endmodule


