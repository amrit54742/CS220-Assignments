module  q2 (
    clk,reset,writeEnable,addressa,datain,dataout,mode,addressb
);
input clk,reset,writeEnable,mode;
input [31:0] datain;
input [4:0]addressa;
input [4:0]addressb;
output reg [31:0]dataout;
reg [31:0]memory[31:0];
integer i;
always @(posedge clk) begin
    if (reset==1) begin
        for(i=0;i<32;i=i+1)
        begin
            memory[i]=0;
        end
    end

    if(mode==0 && writeEnable==1)
    begin
        memory[addressa]=datain;
    end
    dataout=memory[addressb];
end
// always @(posedge clk) begin
//     dataout=memory[addressb];
// end
endmodule