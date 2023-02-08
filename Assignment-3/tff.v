`timescale 1ns / 1ps

module tff(input reset, input clk, output reg q);
  always @(negedge clk, posedge reset)
  begin 
    if (reset) q<=1'b0; 
    else q<=~q;
    // $display(reset,q);
  end
endmodule