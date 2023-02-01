`timescale 1ns / 1ps

`include "b_bit_adder.v"
`include "mul_2_1.v"
module orig_ripple_bit_adder(c,d,sum,cout);
parameter length=4;
parameter W=128;
parameter s=32;
input [W-1:0] c,d;
// input length;

output [W-1:0] sum;
output cout;
wire [s-1:0] p;
// wire [length-1:0] a,b;
wire [s:0] c_temp;
assign c_temp[0]=1'b0;
//assign iter= (128/length);
 wire [(128/length)-1:0] out;

genvar i;
generate

// for(i=0;i<32;i=i+1)
// begin: loop1
// b_bit_adder add1(c[((i+1)*length)-1 -: length], d[((i+1)*length)-1 -: length], c_temp[i], sum[((i+1)*length)-1 -: length], c_temp[i+1], p[i]);
// mul_2_1 mul0(p[i], c_temp[i], c_temp[i+1], c_temp[i+1]);
// // assign c_temp[i+1]= p[i]? c_temp[i]:c_temp[i+1];
// end
 for(i=0;i<128/length;i=i+1)
            begin: generate_stormbreaker
                b_bit_adder add1(c[(i+1)*length-1:i*length], d[(i+1)*length-1:i*length], c_temp[i], sum[(i+1)*length-1:i*length], out[i],p[i]);
                mul_2_1 mul0(out[i],c_temp[i],p[i],c_temp[i+1]);
            end
endgenerate

assign cout=c_temp[s];

endmodule
