module instruction_fetch(
    input clk,
    input reset,
    output [31:0] instruction,
    output [31:0] pc_output
);

wire [31:0] pc_next;     // for storing next program counter (i.e next instruction info/address)
pc_register pc(.clk(clk), .reset(reset), .pc_input(pc_next), .pc_output(pc_output));

instruction_memory im(.instruction_address(pc_output), .instruction(instruction));

assign pc_next = pc_output + 4; // increase the initial value of pc by 4 (to store the address of next instruction)



// Here, we will use this instruction of 32 bits and will be sent to the instruction decode file (psd5). In psd5, we will do further operation(like arith, data etc.) 

endmodule