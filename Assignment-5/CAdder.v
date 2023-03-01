module fp_adder(
    input wire sign1,sign2,
    input wire[7:0] exp1,exp2,
    input wire [22:0] frac1,frac2,
    output reg sign_out,
    output reg [7:0] exp_out,
    output reg [22:0] frac_out
);
reg signb,signs;
reg [7:0] expb,exps,expn,exp_diff;
reg[23:0] fracb,fracs,fraca;
reg [22:0]fracn;
reg[24:0] sum;
reg [23:0]sum_norm;
reg [4:0]leading;
//body
integer i;
always@*
begin
    //first we will find the larger number
    if({exp1,frac1}>{exp2,frac2})
        begin
            signb=sign1;
            signs=sign2;
            expb=exp1;
            exps=exp2;
            fracb={1'b1,frac1};
            fracs={1'b1,frac2};
        end
    else 
        begin
            signb=sign2;
            signs=sign1;
            expb=exp2;
            exps=exp1;
            fracb={1'b1,frac2};
            fracs={1'b1,frac1};
        end
    
    //Now,we will align the smaller guy
    exp_diff=expb-exps;
    fraca=fracs >> exp_diff;

    //next, will perform addition/subtraction
    if(signb==signs)
        sum={1'b0,fracb}+{1'b0,fraca};
    else
        sum={1'b0,fracb}-{1'b0,fraca};

    //Now, we will normalize it 
    //counting leading 0s
    leading=23;
        for(i=1;i<24;i=i+1)begin
            if(sum[i])begin
                leading=24-i;
            end
            else begin
                leading=leading;
            end
        end
    sum_norm=sum<<leading;
    if(sum[24])begin
        expn=expb+1;
        fracn=sum[23:1];
    end
    else if(leading>expb)begin
        expn=0;
        fracn=0;
    end
    else begin
        expn=expb-leading;
        fracn=sum_norm[22:0];
    end
    sign_out=signb;
    exp_out=expn;
    frac_out=fracn;
end
endmodule