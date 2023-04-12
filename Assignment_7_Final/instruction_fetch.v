module instruction_memory(
	input clk, reset,
	input [9:0] Instruction_Address,
	output reg [31:0] Instruction
);

	reg [31:0] Data_Memory [0:1023]; // 1024 32-bit words of memory

	integer i;
	initial begin
		$readmemb("instructions.bin", Data_Memory); // Read the instructions from a hex file
		
		for(i=0; i<30; i = i+1) begin
			$display("memory[%d] = %b", i, Data_Memory[i]);
		end
	end

	always @(posedge clk) begin
		if (reset == 1) begin
      $readmemb("instructions.bin", Data_Memory);
    end
		else begin
			Instruction = Data_Memory[Instruction_Address]; // Select the instruction at the given address
			// $display("Values at DataMemory[%d]:---->%d", Instruction_Address, Data_Memory[Instruction_Address]);
	  end
	end
endmodule

module Instruction_Fetch(
	input clk, reset,
	input [9:0] PC,
	output [31:0] Instruction
);

	instruction_memory IM(.clk(clk), .reset(reset), .Instruction_Address(PC), .Instruction(Instruction));

endmodule


