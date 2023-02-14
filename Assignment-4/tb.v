`include "veda.v"
module tb;

reg clk, reset, writeEnable, mode;
reg [31:0] datain;
reg [4:0] address;
wire [31:0] dataout;

veda uut (
    .clk(clk),
    .reset(reset),
    .writeEnable(writeEnable),
    .address(address),
    .datain(datain),
    .dataout(dataout),
    .mode(mode)
);

initial begin
    clk = 0;
    reset = 1;
    #2 reset = 0;
end

always #1 clk = ~clk;

initial begin
     $dumpfile("tb.vcd");
    $dumpvars(0,tb);
    address = 5;
    datain = 32'h12345678;
    writeEnable = 1;
    mode = 0;
    #2;

    address = 10;
    datain = 32'habcdef01;
    mode = 1;
    #2;

    address = 15;
    datain = 32'habcdef02;
    mode = 1;
    #2;

    address = 5;
    datain = 32'h12345789;
    writeEnable = 1;
    mode = 0;
    #2;

    address = 5;
    writeEnable = 0;
    #2;

    address = 10;
    mode = 1;
    #2;

    address = 20;
    datain = 32'h12345111;
    writeEnable = 1;
    mode = 0;
    #2;

    $monitor(dataout);
    $finish;
end
endmodule