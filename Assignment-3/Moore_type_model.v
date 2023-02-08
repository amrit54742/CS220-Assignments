module Moore_type_model(clock,reset,i_p,o_p);
input   clock,reset;
input  i_p;
output reg o_p;
reg[1:0]state;
reg[1:0]next_state;
always @ (clock)
begin
  if(reset)
  begin
  state=2'b00;
  end
  else
  begin
case(state)
   2'b00 : if (i_p == 1'b1) begin
                state <= 2'b01;
                o_p<=0;
              end
              else begin
                state <= 2'b00;
                o_p<=0;
              end
   2'b01 : if (i_p == 1'b1) begin
                state <= 2'b01;
                o_p<=0;
          end
          else begin
            state <= 2'b10;
            o_p<=0;
            //$display(i_p);
          end
   2'b10 : if (i_p == 1'b1) begin
                state <= 2'b11;
                o_p<=0;
              end
              else begin
                state <= 2'b00;
                o_p<=0;
              end
    2'b11 : if (i_p == 1'b1) begin
                state <= 2'b01;
                o_p<=0;
              end
              else begin
                state <= 2'b10;
                o_p<=1;
              end
   default : state <= 2'b00;
  endcase
  end
end

endmodule