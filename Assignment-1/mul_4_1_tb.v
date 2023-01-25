`timescale 1ns / 1ps
`include "mul_4_1.v"
module mul_4_1_tb;
reg [31:0] i0, i1, i2, i3;
reg s0;
reg s1;
wire [31:0] out;
mul_4_1 uut(
    .i0(i0),
    .i1(i1),
    .i2(i2),
    .i3(i3),
    .out(out),
    .s0(s0),
    .s1(s1)
);
initial 
begin
    $dumpfile("mul_4_1_tb.vcd");
    $dumpvars(0, mul_4_1_tb);

    i0=32'b00000000000000000000000000000001;
    i1=32'b00000000000000000000000000000010;
    i2=32'b00000000000000000000000000000100;
    i3=32'b00000000000000000000000000001000;
    s0=1'b0;
    s1=1'b0;
    #1;
    s0=1'b0;
    s1=1'b1;
    #1;
    s0=1'b1;
    s1=1'b0;
    #1;
    s0=1'b1;
    s1=1'b1;
    #1;
end

endmodule