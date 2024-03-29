// Amrit kumar --190122
// Yash Gupta ---190997


module Branching(
  input [31:0] Data1,
  input [31:0] Data2,
  input [31:0] Instruction,
  input [9:0] PC,   //program counter
  input [3:0] Opcode_Branch,
  output reg [9:0] Next_PC,
  output reg [9:0] ra
);

wire [25:0] Immediate_Jump;
assign Immediate_Jump= Instruction[25:0];


wire [15:0] Immediate_Branch;
assign Immediate_Branch= Instruction[15:0];

  initial begin
      ra=PC;          
  end

  always @(*) begin
    case (Opcode_Branch)

    4'b0000:Next_PC = ($signed(Data1) == $signed(Data2)) ? (PC + $signed(Immediate_Branch)) : PC ;   //beq
    4'b0001: Next_PC = ($signed(Data1) != $signed(Data2)) ? (PC + $signed(Immediate_Branch)) : PC;   //bne
    4'b0010:Next_PC = ($signed(Data1) > $signed(Data2)) ? (PC + $signed(Immediate_Branch)) :PC ;   //bgt
    4'b0011:Next_PC = ($signed(Data1) >= $signed(Data2)) ? (PC + $signed(Immediate_Branch)) : PC;    //bgte
    4'b0100:Next_PC = ($signed(Data1) < $signed(Data2)) ? (PC + $signed(Immediate_Branch)) : PC;   //ble
    4'b0101:Next_PC = ($signed(Data1) <= $signed(Data2)) ? (PC + $signed(Immediate_Branch)) : PC;    //bleq
    4'b0110: Next_PC= Immediate_Jump-1;      //j
    4'b0111: Next_PC= Data1-1;        //jr
    4'b1000:   begin
        ra=PC+1;                //jal
        Next_PC= $signed(Immediate_Jump)-1;
    end
    endcase

end


endmodule