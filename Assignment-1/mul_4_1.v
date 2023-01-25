`timescale 1ns / 1ps
module mul_4_1(i0, i1, i2, i3, out, s0, s1);
output reg [31:0] out;
input [31:0] i0, i1, i2, i3;
input s0, s1;
always @(i0 or i1 or i2 or i3 or s0 or s1)
begin
case({s0, s1})
    2'b00: out=i0;
    2'b01: out=i1;
    2'b10: out=i2;
    2'b11: out=i3;
    default: $display("please enter correct pair of s0 and s1");
endcase
end
endmodule
    
