`timescale 1ns / 1ps
// module mul_2_1(p, i0, i1, out);
// output out;
// reg out;
// input p, i0, i1;
// //input s0, s1;
// always @(p or i0 or i1)
// begin
// case(p)
//     1'b0: out=i1;
//     1'b1: out=i0;
//     default: $display("please enter correct value");
// endcase
// end
// endmodule
    
module mul_2_1(a,b,sel,out);
    input a,b;
    input sel;
    output out;

    assign out=(sel)?b:a;

endmodule