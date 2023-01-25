// module full_sub_32(borrow,diff,a,b,c);
//     input[31:0] a,b,c;
//     output[31:0] borrow, diff;
    
//    interger i;
//    for(i=0;i<32;i=i+1)
//     begin:
//         full_sub(borrow[i], diff[i], a[i], b[i], c[i]);
//     end

// endmodule

`timescale 1ns / 1ps
`include "full_sub.v"


module full_sub_32(a,b,diff, borout);
parameter W=32;
input [W-1:0] a,b;
output [W-1:0] diff;
output borout;

wire [W:0] borrow_temp;
assign borrow_temp[0]= 1'b0;
genvar i;

generate
for(i=0;i<32;i=i+1)
begin: loop1
full_sub sub0(borrow_temp[i+1], diff[i], a[i], b[i], borrow_temp[i]);
end
    endgenerate
    assign borout=borrow_temp[W];
    endmodule
