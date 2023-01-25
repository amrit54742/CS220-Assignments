`timescale 1ns / 1ps
`include "full_sub_32.v"
module full_sub_32_tb;
	// Inputs
	reg [31:0] a;
	reg [31:0] b;

	// Outputs
	wire [31:0] diff;
	wire borout;

	// Instantiate the Unit Under Test (UUT)
	full_sub_32 uut (
		.a(a), 
		.b(b), 
		.diff(diff), 
		.borout(borout)
	);

	initial begin
		// Initialize Inputs
        $dumpfile("full_sub_32_tb.vcd");
        $dumpvars(0, full_sub_32_tb);
        // $monitor("sum- ", sum, ", cout- ", cout);
		a = 32'b00000000000000000000000000110000;
		b = 32'b00000000000000000000000000011101;
        #1;
        // a=48;
        // b=29;
        a = 32'b00000000000000000000000000110100;
		b = 32'b00000000000000000000000000010101;
		#1;
        a = 32'b00000000000000000000000000100000;
		b = 32'b00000000000000000000000000001101;
        #1;
        a = 32'b00000000000000000000000000110000;
		b = 32'b00000000000000000000000000000101;
        #1;
        a = 32'b00000000000000000000000111110000;
		b = 32'b00000000000000000000000110011101;
        #1;
        a = 32'b00000000000000000000000110010000;
		b = 32'b00000000000000000000000111111101;
        #1;
		// Add stimulus here
	end
      
endmodule


