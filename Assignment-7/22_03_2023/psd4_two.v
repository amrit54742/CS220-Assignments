`include "psd4_one.v"

module pc_register(
    input clk,
    input reset,
    input [31:0] pc_input,
    output reg [31:0] pc_output
);

always @(posedge clk, posedge reset)
begin
    if (reset)
        pc_output <= 32'h00000000; // Reset the PC to 0
    else
        pc_output <= pc_input; // storing the value of program counter(input PC) in the pc_output and will return it to the fetch function to do further computation
end

endmodule