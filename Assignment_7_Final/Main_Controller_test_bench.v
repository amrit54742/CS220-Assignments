`include "Main_Controller.v"
`timescale 1ps/1ps

module Main_Controller_test_bench;
    reg clk, reset;   
    Main_Controller M1(.clk(clk), .reset(reset));  ///calling main controller function for computation 

    initial begin                   //setting clock and reset values to zero
        clk=0;
        reset=0;
    end

    always #10 clk = ~clk;     // will invert clk value 
    initial begin
        $dumpfile("Main_Controller_test_bench.vcd");    
        $dumpvars(0, Main_Controller_test_bench);
        #11500 $finish;    //finish the whole program after 10000
    end


endmodule