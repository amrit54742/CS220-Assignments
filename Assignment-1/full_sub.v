`timescale 1ns / 1ps 
module full_sub(borrow,diff,a,b,c);
 output borrow,diff;
 wire borrow, diff;
 input a,b,c;
// wire w1,w4,w5,w6;
// xor (diff,a,b,c);
// not n1(w1,a);
// and a1(w4,w1,b);
// and a2(w5,w1,c);
// and a3(w6,b,c);
// or o1(borrow,w4,w5,w6);
// wire acomp, bcomp, ccomp;
assign diff= ((~a & ~b & c) | (~a & b & ~c) | (a & ~b & ~c) | (a & b & c));
assign borrow= ((~a & c) | (~a & b) | (b & c));

// not g4(abar, a);
// not g3(v1bar, v1);
// xor g1(v1,a,b);
// xor g2(diff, v1, c);
// and g5(v2, abar, a);
// and g6(v3, v1bar, c);
// or g7(borrow, v2, v3); 
endmodule