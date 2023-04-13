module ALU(
  input [31:0] Data1,
  input [31:0] Data2,
  input [31:0] Instruction,
  input [3:0] Opcode_ALU,
  output reg [31:0] Result
);
  wire [15:0] Immediate_Branch;            // We will need this in case of I-type operations
  assign Immediate_Branch= Instruction[15:0];


  always @(*) begin
    case (Opcode_ALU)

    // for alu R-type(add, sub, addu, subu, and, or)
      4'b0000: Result = Data1 + Data2; //add
      4'b0001: Result = Data1 - Data2; //sub
      4'b0010: Result = Data1 + Data2; //addu d
      4'b0011: Result = Data1 - Data2; //subu d
    
      4'b0110: Result = Data1 & Data2; //and
      4'b0111: Result = Data1 | Data2; //or
      //4'b0100: result = operand1 + {{16{operand1[15]}}, operand2[15:0]}; //addi d
      4'b0100: Result = Data1 + {{16{Immediate_Branch[15]}}, Immediate_Branch[15:0]}; //addi d
      4'b0101: Result = Data1 + {{16{1'b0}}, Immediate_Branch[15:0]}; //addiu  d

      
      4'b1000: Result = Data1 & {{16{Immediate_Branch[15]}}, Data2[15:0]}; //andi  d
      4'b1001: Result = Data1 | {{16{Immediate_Branch[15]}}, Data2[15:0]}; //ori  d

      // for comparision 
      4'b1010: Result = Data1 << Data2[4:0]; //sll
      4'b1011: Result = Data1 >> Data2[4:0]; //srl

      // 4'b1100: Result = Data1 << Data2[4:0]; //slt
      // 4'b1101: Result = Data1 >> Data2[4:0]; //srl
      4'b1100: Result = ($signed(Data1) < $signed(Data2)) ? 1:0; //slt
      4'b1101:  Result = ($signed(Data1) < $signed({{16{1'b0}}, Immediate_Branch[15:0]}))?1:0 ; //slti

    endcase
  end

endmodule