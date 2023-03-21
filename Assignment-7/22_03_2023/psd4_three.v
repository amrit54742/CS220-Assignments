module instruction_memory(
    input [31:0] instruction_address,
    output reg [31:0] instruction
);

reg [31:0] memory [0:1023]; //size of memory where each row would store 32 bits memory in binary 




//reference http://www.testbench.in/TB_03_FILE_IO_TB.html for reading memory .txt file (well formatted in binary or hexa)
initial
begin
    $readmemb("instructions.bin", memory); //read in binary format for memb and in hex format for memh
end

always @(*)
begin
    instruction = memory[instruction_address[9:0]]; // store the instruction located at the 9 to 0 bits in memory. This will give a value of 32 bits and will be stored in instruction.
end

endmodule




//******************doubt in line 19..