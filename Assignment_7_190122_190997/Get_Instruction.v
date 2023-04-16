// Amrit kumar --190122
// Yash Gupta ---190997

module Get_Instruction(
	input clk, reset,
	input [9:0] PC,
	output reg [31:0] Instruction
);

	reg [31:0] Instruction_Memory [0:512]; // 32-bit words of Instruction memory

	integer i;
	initial begin
		$readmemb("Instruction_File.bin", Instruction_Memory); //Loading contents from Intruction_file 
	end
// reading procedure for different address 
	always @(posedge clk) begin
		if (reset == 1) begin
      $readmemb("Instruction_File.bin", Instruction_Memory);
    end
		else begin
			Instruction = Instruction_Memory[PC]; // Select the instruction at the given address
			// $display("Values at DataMemory[%d]:---->%d", Instruction_Address, Data_Memory[Instruction_Address]);
	  end
	end
endmodule
