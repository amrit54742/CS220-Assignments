module test;
reg sign1,sign2;
reg[7:0] exp1,exp2;
reg[22:0] frac1,frac2;
wire sign_out;
wire[7:0] exp_out;
wire[22:0] frac_out;
fp_adder uut (sign1,sign2,exp1,exp2,frac1,frac2,sign_out,exp_out,frac_out);
initial begin
    {sign1,exp1,frac1}=32'b01000001001101100000000000000001;
    {sign2,exp2,frac2}=32'b01000000101100100000010000011011;
    // sign1=0;
    // sign2=0;
    // exp1=
    // exp2=
    // frac1=
    // frac2=
    #100
    $display("%b",{sign_out,exp_out,frac_out});
end
endmodule