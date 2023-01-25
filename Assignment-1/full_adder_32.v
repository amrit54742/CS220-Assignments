`timescale 1ns / 1ps

`include "full_add.v"
module full_adder_32(a,b,sum,cout);

parameter W=32;
input [W-1:0] a,b;
output [W-1:0] sum;
output cout;

wire [W:0] c_temp;

assign c_temp[0]=1'b0;

genvar i;

generate
for(i=0;i<32;i=i+1)
begin: loop1
full_add add0(a[i],b[i],c_temp[i],sum[i],c_temp[i+1]);
end
endgenerate

assign cout=c_temp[W];


endmodule
