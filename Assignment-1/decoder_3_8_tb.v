`timescale 1ns / 1ps
`include "decoder_3_8.v"
module decoder_3_8_tb;
reg [2:0] in;
wire [7:0] out;
reg en;
decoder_3_8 uut(
    .in(in),
    .out(out),
    .en(en)
);
initial begin
    $dumpfile("decoder_3_8_tb.vcd");
    $dumpvars(0, decoder_3_8_tb);
    en=1'b1;
    in = 3'b000;
    #1;
    in = 3'b001;
    #1;
    in = 3'b010;
    #1;
    in = 3'b011;
    #1;
    in = 3'b100;
    #1;
    in = 3'b101;
    #1;
    in = 3'b110;
    #1;
    in = 3'b111;
    #1;


    en= 1'b0;
    in = 3'b111;
    #1;


end
endmodule