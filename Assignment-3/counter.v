`timescale 1ns / 1ps

module counter(reset, clk, y);
output [3:0]y;
input clk, reset;
wire reset2;

assign reset2 = reset | (y[1]&y[3]&(!y[0])&(!y[2]));

tff t1(reset2, clk, y[0]);
tff t2(reset2, y[0], y[1]);
tff t3(reset2, y[1], y[2]);
tff t4(reset2, y[2], y[3]);

endmodule
