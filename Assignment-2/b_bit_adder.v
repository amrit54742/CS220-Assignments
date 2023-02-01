`timescale 1ns / 1ps
`include "one_bit_adder.v"
`include "p_cal.v"
module b_bit_adder(c,d, c_temp,sum,cout,p);

//parameter W=32;
parameter W=4;                       //This value needs to be changed for different b parameters, here b=W;
input [W-1:0] c,d;
input c_temp;
output [W-1:0] sum;
output cout;
output p;
// wire c,d,c_temp;
wire sum, cout;
wire [W:0] c_temp1;
 wire [W-1:0] t;
assign c_temp1[0]=c_temp;

// genvar i;
// wire p;

//  assign p=c[0] ^ d[0];
// genvar j;

// generate
// for(j=1;j<W;j=j+1)
// begin: loop2
//  assign p= (p & (c[j] ^ d[j]));
// end
// endgenerate
 assign t[0]=c[0]^d[0];
    genvar i;
    generate 
    for(i=1;i<W;i=i+1)
        begin: generate_p
            assign t[i]=(c[i]^d[i])&(t[i-1]);
        end
    endgenerate
    assign p=t[W-1];


genvar k;
generate
for(k=0;k<W;k=k+1)
begin: loop1
one_bit_adder add0(c[k],d[k],c_temp1[k],sum[k],c_temp1[k+1]);
end
endgenerate

assign cout=c_temp1[W];

endmodule
