`timescale 1ns / 1ps
`include "q2.v"
module tb2;
    reg clk,reset,writeEnable,mode;
    reg [31:0] datain;
    reg [4:0]addressa;
    reg [4:0]addressb;
    wire [31:0] dataout;

    q2 dut (
        .clk(clk),
        .reset(reset),
        .writeEnable(writeEnable),
        .mode(mode),
        .datain(datain),
        .addressa(addressa),
        .addressb(addressb),
        .dataout(dataout)
    );

    initial begin
        clk = 0;
        reset = 1;
        #2 reset = 0;
    end
    always #1 clk = ~clk;

    initial begin
        $dumpfile("tb2.vcd");
        $dumpvars(0,tb2);
        // reset = 0;
        writeEnable = 1;
         mode = 0;
        datain = 42;
        addressa = 0;
        addressb = 0;//3
        #2;
        mode=0;
        addressa=2;
        writeEnable = 1;
       datain=31;
        addressb = 0;
        #2;
        mode=1;
        addressa=2;
        writeEnable = 1;
       datain=36;
        addressb = 2; 
        #2;
        mode=1;
        addressa=0;
        writeEnable = 1;
       datain=31;
        addressb = 0;
        #2;

        $display("dataout: %d", dataout);
        #2$finish;
    end
endmodule
